<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="src.main.java.com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Auction</title>
</head>
<body>
	<h1>Delete Auction</h1>
	<h3>List of Auctions</h3>
	<%
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String str = "SELECT * FROM auctions a JOIN items i ON a.itemID = i.itemID";
		ResultSet result = stmt.executeQuery(str);
	%>
	<table border='1'>
		<tr>
			<td>auctionID</td>
			<td>clothingType</td>
			<td>name</td>
			<td>size</td>
			<td>dateOpen</td>
			<td>dateClose</td>
			<td>owner</td>
		</tr>
		<%
		//parse out the results
		while (result.next()) {
		%>
		<tr>
			<td><%=result.getString("auctionID")%></td>
			<td><%=result.getString("clothingType")%></td>
			<td><%=result.getString("name")%></td>
			<td><%=result.getString("size")%></td>
			<td><%=result.getString("dateOpen")%></td>
			<td><%=result.getString("dateClose")%></td>
			<td><%=result.getString("owner")%></td>
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
	<form method="post" action="deletingAuction.jsp">
		<table>
			<tr>
				<td>AuctionID</td>
				<td><input type="text" name="auctionID"></td>
			</tr>
		</table>
		<input type="submit" value="Delete Auction">
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