<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="src.main.java.com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Deleting Bid</title>
</head>
<body>
<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	try {
		String bidIDStr = request.getParameter("bidID");
		
		if(bidIDStr.length() == 0){
			session.setAttribute("invalidinput","Error: fields are empty.");
			response.sendRedirect("deleteBidPage.jsp");
			return;
		}
		
		Long bidID = Long.parseLong(bidIDStr);		
		Statement st = con.createStatement();
		String str = "SELECT * FROM bids WHERE bidID = " + bidID;
		ResultSet rs = st.executeQuery(str);
		if (rs.next()) {
			//Make an insert statement for the Sells table:
			String delete = "DELETE FROM bids WHERE bidID = '" + bidID + "'";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			Statement st2 = con.createStatement();
			st2.executeUpdate(delete);
			
			out.print("Bid Deleted!");
		} else {
			session.setAttribute("invalidinput","Error: No auctions exist with this auctionID");
			response.sendRedirect("deleteBidPage.jsp");
			return;
		}
		db.closeConnection(con);
	} catch (Exception e) {
		e.printStackTrace();
	}

%>
<form method = "get" action = "deleteBidPage.jsp">
	<input type="submit" value="Back">
</form>
</body>
</html>