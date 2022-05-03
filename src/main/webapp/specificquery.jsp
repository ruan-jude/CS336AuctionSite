<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1> IM AWESOME</h1>
	<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	try {
		String itemID = request.getParameter("ItemID");
		String bid = request.getParameter("Bid");
		
		Statement st = con.createStatement();

		String str = "UPDATE auctions SET bidding = " + bid + " WHERE itemID = " + itemID;
		out.println(str);
						
		st.executeUpdate(str); //remember to change this

	
		db.closeConnection(con);
	} catch (Exception e) {
		e.printStackTrace();
	}

	%>
	
	
		
		<form method = "get" action = "logged_in.jsp">
		<input type="submit" value="Back">
		</form>

		
</body>
</html>