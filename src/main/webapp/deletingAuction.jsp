<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="src.main.java.com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Deleting Auction</title>
</head>
<body>
<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	try {
		String auctionIDStr = request.getParameter("auctionID");
		
		if(auctionIDStr.length() == 0){
			session.setAttribute("invalidinput","Error: fields are empty.");
			response.sendRedirect("deleteAucPage.jsp");
			return;
		}
		
		Long auctionID = Long.parseLong(auctionIDStr);		
		Statement st = con.createStatement();
		String str = "SELECT * FROM auctions WHERE auctionID = " + auctionID;
		ResultSet rs = st.executeQuery(str);
		if (rs.next()) {
			//Make an insert statement for the Sells table:
			String delete = "DELETE FROM auctions WHERE auctionID = '" + auctionID + "'";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			Statement st2 = con.createStatement();
			st2.executeUpdate(delete);
			
			out.print("Auction Deleted!");
		} else {
			session.setAttribute("invalidinput","Error: No auctions exist with this auctionID");
			response.sendRedirect("deleteAucPage.jsp");
			return;
		}
		db.closeConnection(con);
	} catch (Exception e) {
		e.printStackTrace();
	}

%>
<form method = "get" action = "deleteAucPage.jsp">
	<input type="submit" value="Back">
</form>
</body>
</html>