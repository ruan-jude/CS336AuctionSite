<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="src.main.java.com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Place Bid</title>
</head>
<body>
	<%
	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		Boolean isAutobid = false;
		//Getting all parameters:
		String bidstr = request.getParameter("bidAmt");
		long currAuc = Long.parseLong(request.getParameter("aucid"));
		String entity = request.getParameter("command");
		String alertNorm = request.getParameter("setAlert");
		if (alertNorm == null) alertNorm = "no";
		String autoincStr = request.getParameter("bidderInc");
		String automaxStr = request.getParameter("bidderMax");
		float autoinc = 0;
		float automax = 0;
		
		Statement st1 = con.createStatement();
		ResultSet rs1 = st1.executeQuery("SELECT * FROM auctions WHERE auctionID ='" + currAuc +"'");
		rs1.next();
		String winner = rs1.getString("winner");
		if (winner != null) {
			session.setAttribute("invalidinput", "Auction Is Closed, Sorry!");
			response.sendRedirect("viewDetailedAuction.jsp");
			return;
		}
		float currLargest = rs1.getFloat("bidding");
		String aucOwner = rs1.getString("owner");
		
		//Get item name for current auction
		ResultSet item = st1.executeQuery("SELECT * FROM items WHERE itemID = '" + rs1.getLong("itemID") + "'");
		item.next();
		String itemName = item.getString("name");
		if (aucOwner.equals(session.getAttribute("email").toString())) {
			session.setAttribute("invalidinput", "Error: CANNOT BID ON YOUR OWN ACTION!");
			response.sendRedirect("viewDetailedAuction.jsp");
			return;
		}
		
		if (bidstr.length() == 0 || entity == null) {
			session.setAttribute("invalidinput", "Error: required(*) field(s) are empty");
			response.sendRedirect("viewDetailedAuction.jsp");
			return;
		} else if (currLargest >= Float.parseFloat(bidstr)) {
			session.setAttribute("invalidinput", "Error: your bid is less than or equal to the current highest bid!");
			response.sendRedirect("viewDetailedAuction.jsp");
			return;
		}
		if (entity.equals("yes")) {
			isAutobid = true;
			alertNorm = "no";
			if (autoincStr.length() == 0 || automaxStr.length() == 0) {
				session.setAttribute("invalidinput","Error: autobid field(s) are empty");
				response.sendRedirect("viewDetailedAuction.jsp");
				return;
			} 
			autoinc = Float.parseFloat(autoincStr);
			automax = Float.parseFloat(automaxStr);
			if (automax <= currLargest) {
				session.setAttribute("invalidinput", "Error: your autobid max is less than the current highest bid");
				response.sendRedirect("viewDetailedAuction.jsp");
				return;
			}
		}
		
		
		float bid = Float.parseFloat(bidstr);
		if (bid == 0) {
			session.setAttribute("invalidinput", "Error: cannot bid $0.00");
			response.sendRedirect("viewDetailedAuction.jsp");
			return;
		}
		
		//Update auction with new highest bid:
		Statement st2 = con.createStatement();
		st1.executeUpdate("UPDATE auctions SET bidding = '" + bid + "' WHERE auctionID = '" + currAuc +"'");
		
		//Create bidID:
		long bidid;
		Statement st;
		String findid;
		do {
			bidid = new Random().nextLong();
			st = con.createStatement();
			findid = "SELECT EXISTS(SELECT 1 FROM bids WHERE bidID = '" + bidid + "')";
		} while (!st.execute(findid));
		
		//Insert new item into items table:
		String insert = "INSERT INTO bids(bidID, auctionID, amount, bidder, autoIncrement, incrementAmount, maxBid, reachedMax, didAlertNorm)" 
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps1 = con.prepareStatement(insert);
		ps1.setLong(1, bidid);
		ps1.setLong(2, currAuc);
		ps1.setFloat(3, bid);
		ps1.setString(4, session.getAttribute("email").toString());
		if (isAutobid) {
			ps1.setBoolean(5, true);
			ps1.setFloat(6, autoinc);
			ps1.setFloat(7, automax);
			ps1.setBoolean(8, false);
			ps1.setBoolean(9, false);
		} else {
			ps1.setBoolean(5, false);
			ps1.setString(6, null);
			ps1.setString(7, null);
			ps1.setString(8, null);
			if (alertNorm.equals("yes")) ps1.setBoolean(9, true);
			else ps1.setBoolean(9, false);
		}
		//Run the query
		ps1.executeUpdate();
		
		out.print("Successfully placed bid!");
		
		
		
		/*
			FOR AUTO BIDDING:
		*/
		
		//Create temp table
		Statement st3 = con.createStatement();
		st3.executeUpdate("CREATE TEMPORARY TABLE autoIncrement AS SELECT * FROM bids WHERE autoIncrement = 1 AND reachedMax = 0 AND auctionID = '" + currAuc +"'");
		
		Statement st5 = con.createStatement();
		ResultSet rs5 = st5.executeQuery("SELECT count(*) AS count FROM autoIncrement");
		rs5.next();
		int count = rs5.getInt("count");
		Statement st4 = con.createStatement();
		ResultSet rs4 = null;
		
		boolean escape = false;
		long currHighestBidID = bidid;
		
		while (count > 0) {
			rs4 = st4.executeQuery("SELECT * FROM autoIncrement ORDER BY amount DESC");
			if (count >= 2) {
				rs4.next();
			}
			while (rs4.next()) {
				if (count == 1 && currHighestBidID == rs4.getLong("bidID")) {
					escape = true;
					break;
				}
				float newAmt = rs4.getFloat("incrementAmount") + bid;
				if (newAmt <= rs4.getFloat("maxBid")) {
					//Insert auto-created bid into item table
					String addBid = "INSERT INTO bids(bidID, auctionID, amount, bidder, autoIncrement, incrementAmount, maxBid, reachedMax)" 
							+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
					PreparedStatement ps2 = con.prepareStatement(addBid);
					
					//Create new bidID:
					long bidid0;
					Statement st0;
					String findid0;
					do {
						bidid0 = new Random().nextLong();
						st0 = con.createStatement();
						findid0 = "SELECT EXISTS(SELECT 1 FROM bids WHERE bidID = '" + bidid0 + "')";
					} while (!st.execute(findid0));
				
					ps2.setLong(1, bidid0);
					ps2.setLong(2, currAuc);
					ps2.setFloat(3, newAmt);
					ps2.setString(4, rs4.getString("bidder"));
					ps2.setBoolean(5, true);
					ps2.setFloat(6, rs4.getFloat("incrementAmount"));
					ps2.setFloat(7, rs4.getFloat("maxBid"));
					ps2.setBoolean(8, false);
					ps2.executeUpdate();
					
					//Update auction with new highest bid:
					Statement st8 = con.createStatement();
					st8.executeUpdate("UPDATE auctions SET bidding = '" + newAmt + "' WHERE auctionID = '" + currAuc +"'");
					
					//Update autoIncrement table:
					Statement st6 = con.createStatement();
					st6.executeUpdate("DELETE FROM autoIncrement WHERE bidID = '"+  rs4.getLong("bidID") +"'");
					String update = "INSERT INTO autoIncrement(bidID, auctionID, amount, bidder, autoIncrement, incrementAmount, maxBid, reachedMax)" 
							+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
					PreparedStatement ps3 = con.prepareStatement(update);
					ps3.setLong(1, bidid0);
					ps3.setLong(2, currAuc);
					ps3.setFloat(3, newAmt);
					ps3.setString(4, rs4.getString("bidder"));
					ps3.setBoolean(5, true);
					ps3.setFloat(6, rs4.getFloat("incrementAmount"));
					ps3.setFloat(7, rs4.getFloat("maxBid"));
					ps3.setBoolean(8, false);
					ps3.executeUpdate();
					
					currHighestBidID = bidid0;
					bid = newAmt;
				} else {
					Statement st9 = con.createStatement();
					st9.executeUpdate("UPDATE bids SET reachedMax = '" + 1 + "' WHERE bidID = '"+ rs4.getLong("bidID") +"'");
					Statement st10 = con.createStatement();
					st10.executeUpdate("DELETE FROM autoIncrement WHERE bidID = '"+ rs4.getLong("bidID") +"'");
					count--;
				}
			}
			if (escape) {
				break;
			}
		}
		
	} catch (Exception e) {
		out.print(e);
	}
	%>
	
	<form method = "get" action = "viewDetailedAuction.jsp">
		<input type="submit" value="Back">
	</form>
</body>
</html>