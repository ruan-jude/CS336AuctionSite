<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="src.main.java.com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Bid</title>
</head>
<body>
	<h1>Delete Bid</h1>
	<h3>List of Bids</h3>
	<%
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String str = "SELECT * FROM (bids b JOIN auctions a ON b.auctionID = a.auctionID) JOIN items i ON i.itemID=a.itemID GROUP BY a.auctionID, b.bidID ORDER BY a.auctionID, b.amount DESC";
		ResultSet result = stmt.executeQuery(str);
	%>
	<table border='1'>
		<tr>
			<td>bidID</td>
			<td>clothingType</td>
			<td>name</td>
			<td>size</td>
			<td>amount</td>
			<td>bidder</td>
		</tr>
		<%
		//parse out the results
		while (result.next()) {
		%>
		<tr>
			<td><%=result.getString("bidID")%></td>
			<td><%=result.getString("clothingType")%></td>
			<td><%=result.getString("name")%></td>
			<td><%=result.getString("size")%></td>
			<td><%=result.getString("amount")%></td>
			<td><%=result.getString("bidder")%></td>
		</tr>
		<%
		}
		result.close();
		%>
	</table>

	<%
	} catch (Exception e) {
	out.print(e);
	}
	%>
	<br>
	<form method="post" action="deletingBid.jsp">
		<table>
			<tr>
				<td>BidID</td>
				<td><input type="text" name="bidID"></td>
			</tr>
		</table>
		<input type="submit" value="Delete Bid">
	</form>
	<br>
	<%
	if (session.getAttribute("invalidinput") != null && session.getAttribute("invalidinput") != "") {
		out.println(session.getAttribute("invalidinput"));
		session.setAttribute("invalidinput", "");
	}
	%>
	<form method="get" action="loggedInRep.jsp">
		<input type="submit" value="Back">
	</form>
</body>
</html>