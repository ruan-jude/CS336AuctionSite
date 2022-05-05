<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
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
		String autoincStr = request.getParameter("bidderInc");
		String automaxStr = request.getParameter("bidderMax");
		float autoinc = 0;
		float automax = 0;
		
		Statement st1 = con.createStatement();
		ResultSet rs1 = st1.executeQuery("SELECT * FROM auctions WHERE auctionID ='" + currAuc +"'");
		rs1.next();
		float currLargest = rs1.getFloat("bidding");
		String aucOwner = rs1.getString("owner");
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
		String insert = "INSERT INTO bids(bidID, auctionID, amount, bidder, autoIncrement, incrementAmount, maxBid, reachedMax)" 
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
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
		} else {
			ps1.setBoolean(5, false);
			ps1.setString(6, null);
			ps1.setString(7, null);
			ps1.setString(8, null);
		}
		//Run the query
		ps1.executeUpdate();
		
		out.print("Successfully placed bid!");
		
		
	} catch (Exception e) {
		out.print(e);
	}
	%>
	
	<form method = "get" action = "viewDetailedAuction.jsp">
		<input type="submit" value="Back">
	</form>
</body>
</html>