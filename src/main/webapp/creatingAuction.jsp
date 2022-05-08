<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="src.main.java.com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Created Auction</title>
</head>
<body>
	<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	try {
		String clothingType = request.getParameter("clothing");
		String name = request.getParameter("name");
		String size = request.getParameter("size");
		String color = request.getParameter("color");
		String season = request.getParameter("season");
		
		String incrementstr = request.getParameter("increment");
		String minPricestr = request.getParameter("minPrice");
		String dateClosestr = request.getParameter("closingDate");
		dateClosestr = dateClosestr.replace("T"," ");
		float minPrice = 0;
		float increment = -1;
		
		//Get current datetime
		Date dt = new Date();
		java.text.SimpleDateFormat sdf = 
			     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		String current = sdf.format(dt);
		
		
		if (clothingType.length() == 0 || incrementstr.length() == 0 || dateClosestr.length() == 0 || 
				name.length() == 0 || size.length() == 0){
			session.setAttribute("invalidinput","Error: required(*) field(s) are empty.");
			response.sendRedirect("createAuction.jsp");
			return;
		} 
		//Check if date is in future
		Date dateClose = sdf.parse(dateClosestr);
		if (dt.compareTo(dateClose) >= 0) {
			session.setAttribute("invalidinput","Error: closing date must be in the future");
			response.sendRedirect("createAuction.jsp");
			return;
		}
		if (minPricestr.length() != 0) {
			minPrice = Float.parseFloat(minPricestr);
		}
		increment = Float.parseFloat(incrementstr);
		
		//Create itemID:
		long itemid;
		Statement st;
		String findid;
		do {
			itemid = new Random().nextLong();
			st = con.createStatement();
			findid = "SELECT EXISTS(SELECT 1 FROM items WHERE itemID = '" + itemid + "')";
		} while (!st.execute(findid));
		
		//Insert new item into items table:
		String insert = "INSERT INTO items(itemID, clothingType, size, name, color, season)" 
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		PreparedStatement ps1 = con.prepareStatement(insert);
		ps1.setLong(1, itemid);
		ps1.setString(2, clothingType);
		ps1.setString(3, size);
		ps1.setString(4, name);
		if (color.length() != 0) ps1.setString(5, color);
		else ps1.setString(5, null);
		if (!season.equals("-")) ps1.setString(6, season);
		else ps1.setString(6, null);
		
		//Run the query
		ps1.executeUpdate();

		
		//Create auctionID for this new auction:
		long aucid;
		Statement st1;
		do {
			aucid = new Random().nextLong();
			st1 = con.createStatement();
			findid = "SELECT EXISTS(SELECT 1 FROM auctions WHERE auctionID = '" + aucid + "')";
		} while (!st1.execute(findid));

		
		
		insert = "INSERT INTO auctions(auctionID, dateOpen, dateClose, minPrice, increment, owner, itemID)" 
					+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setLong(1, aucid);
		ps.setString(2, current);
		ps.setString(3, dateClosestr);
		ps.setFloat(4, minPrice);
		ps.setFloat(5, increment);
		ps.setString(6, session.getAttribute("email").toString());
		ps.setLong(7,itemid);
		//Run the query against the DB
		ps.executeUpdate();
		
		//out.print(ps);
		
		out.print("Auction Created!");
		
		//Set a scheduler to close the auction and select winner at closing date/time:
		Timer t = new Timer();  
		TimerTask tt = new TimerTask() {  
		    @Override  
		    public void run() {  
		    	ApplicationDB db = new ApplicationDB();
		    	Connection con = db.getConnection();
		    	try {
		    		Boolean noBids = true;
		    		Date now = new Date();
		    		java.text.SimpleDateFormat sdf = 
		   			     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		    		Statement s = con.createStatement();
		    		ResultSet allBids = s.executeQuery("SELECT * FROM bids b, auctions a WHERE b.auctionID = a.auctionID AND a.winner IS NULL ORDER BY b.amount DESC");
		    		while (allBids.next()) {
		    			noBids = false;
		    			String dateCloseStr = allBids.getString("dateClose");
		    			dateCloseStr = dateCloseStr.replace("T"," ");
		    			Date dateClose = sdf.parse(dateCloseStr);
		    			if (now.compareTo(dateClose) >= 0) {
		    				float minPrice = allBids.getFloat("minPrice");
		    				float highestBid = allBids.getFloat("amount");
		    				long aucid = allBids.getLong("auctionID");
		    				if (highestBid >= minPrice) {			
		    					Statement s2 = con.createStatement();
		    					s2.executeUpdate("UPDATE auctions SET winner = '" + allBids.getString("bidder") + "' WHERE auctionID = '" + aucid + "'");
		    				} else {
		    					Statement s2 = con.createStatement();
		    					s2.executeUpdate("UPDATE auctions SET winner = '" + allBids.getString("owner") + "' WHERE auctionID = '" + aucid + "'");
		    				}
		    			} else {
		    				continue;
		    			}
		    		}
		    		if (noBids) {
		    			Statement s3 = con.createStatement();
			    		ResultSet rs3 = s3.executeQuery("SELECT * FROM auctions");
			    		while (rs3.next()) {
			    			String dateCloseStr = rs3.getString("dateClose");
			    			dateCloseStr = dateCloseStr.replace("T"," ");
			    			Date dateClose = sdf.parse(dateCloseStr);
			    			if (now.compareTo(dateClose) >= 0) {
			    				long aucid = rs3.getLong("auctionID");
			    				Statement s2 = con.createStatement();
		    					s2.executeUpdate("UPDATE auctions SET winner = '" + rs3.getString("owner") + "' WHERE auctionID = '" + aucid + "'");
			    			}
			    		}
		    		}
		    	} catch (Exception e) {
		    		e.printStackTrace();
		    	}
		    };  
		};  
		t.schedule(tt, dateClose);  
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	db.closeConnection(con);

%>
	<form method="get" action="loggedInReg.jsp">
		<input type="submit" value="Back">
	</form>
</body>
</html>