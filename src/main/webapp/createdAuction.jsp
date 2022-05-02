<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
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
		String incrementstr = request.getParameter("increment");
		String minPricestr = request.getParameter("minPrice");
		String dateClosestr = request.getParameter("closingDate");
		float minPrice = -1;
		float increment = -1;
		
		//Get current datetime
		Date dt = new Date();
		java.text.SimpleDateFormat sdf = 
			     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String current = sdf.format(dt);
		
		
		if(clothingType.length() == 0 || incrementstr.length() == 0 || dateClosestr.length() == 0){
			session.setAttribute("invalidinput","Error: required(*) field(s) are empty.");
			response.sendRedirect("createDeleteAcc.jsp");
			return;
		}
		if (minPricestr.length() != 0) {
			minPrice = Float.parseFloat(minPricestr);
		}
		increment = Float.parseFloat(incrementstr);
		
		//Create auctionID for this new auction:
		long id;
		Statement st1;
		String findid;
		do {
			id = new Random().nextLong();
			st1 = con.createStatement();
			findid = "SELECT 1 FROM auctions WHERE auctionID = '" + id + "'";
		} while (!st1.execute(findid));
		
		
		Statement st = con.createStatement();
		String insert = "INSERT INTO auctions(auctionID, clothingType, dateOpen, dateClose, minPrice, increment, owner)" 
					+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setLong(1, id);
		ps.setString(2, clothingType);
		ps.setString(3, current);
		ps.setString(4, dateClosestr);
		if (minPrice != -1) ps.setFloat(5, minPrice);
		ps.setFloat(6, increment);
		ps.setString(7, session.getAttribute("email").toString());
		//Run the query against the DB
		ps.executeUpdate();
		
		out.print("Auction Created!");
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	db.closeConnection(con);

%>
<form method = "get" action = "createAuction.jsp">
	<input type="submit" value="Back">
</form>
</body>
</html>