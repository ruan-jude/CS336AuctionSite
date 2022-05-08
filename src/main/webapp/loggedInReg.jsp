<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>RegLoginScreen</title>
</head>
<body>
	<h1>Online Auction Site</h1>
	<%	
    	out.println("Welcome " + session.getAttribute("user") + "!");
	%>
	<br> <br> 
	Requested items:
	<table border='1'>
		<tr>
			<td>Item Type</td>
			<td>Name</td>
			<td>Size</td>
			<td>Color</td>
			<td>Season</td>
			<td>Status</td>
			<td>Possible Auctions</td>
		</tr>
		<%
		try{
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			Statement st1 = con.createStatement();
			ResultSet rs1 = st1.executeQuery("SELECT * FROM itemsReq WHERE user = \"" + session.getAttribute("email").toString() + "\"");
			
			while(rs1.next()){
		%>
		<tr>
			<td><%= rs1.getString("clothingType") %> </td>
			<td><% if (rs1.getString("name") == null) out.println(""); else out.println(rs1.getString("name")); %></td>
			<td><% if (rs1.getString("size") == null) out.println(""); else out.println(rs1.getString("size")); %></td>
			<td><% if (rs1.getString("color") == null) out.println(""); else out.println(rs1.getString("color")); %></td>
			<td><% if (rs1.getString("season") == null) out.println(""); else out.println(rs1.getString("season")); %></td>
			<td><% 
				Statement st2 = con.createStatement();
				String query = "SELECT * FROM items i JOIN auctions a ON i.itemID = a.itemID WHERE \"" + rs1.getString("user") + "\" = \"" + session.getAttribute("email").toString() + "\" AND a.winner IS NULL AND i.clothingType=\""+rs1.getString("clothingType")+"\"";
				if (rs1.getString("name") != null) query += " AND i.name=\""+rs1.getString("name")+"\"";
				if (rs1.getString("size") != null) query += " AND i.size=\""+rs1.getString("size")+"\"";
				if (rs1.getString("color") != null) query += " AND i.color=\""+rs1.getString("color")+"\"";
				if (rs1.getString("season") != null) query += " AND i.season=\""+rs1.getString("season")+"\"";
				ResultSet rs2 = st2.executeQuery(query);
				boolean found = rs2.next();
				if (rs1.getBoolean("fulfilled")){
					found = true;
					out.println("valid auctions");
				} else {
					// Checks if the created auction is being searched for	
					if (found)
					{
						Statement st3 = con.createStatement();
						int res = st3.executeUpdate("UPDATE itemsReq SET fulfilled = true WHERE requestID = " + rs1.getLong("requestID"));
						out.println("valid auctions");
					} else out.println("no valid auctions"); 
				} 
			%></td>
			<td><%
				if (found == false) out.println("");
				else {
				%>
				<a href="viewDetailedAuction.jsp?aucid=<%= rs2.getString("auctionID") %>"><%= rs2.getString("name") %></a>
				<%
				}
				while (rs2.next()) {
					out.println(", ");
				%>
				<a href="viewDetailedAuction.jsp?aucid=<%= rs2.getString("auctionID") %>"><%= rs2.getString("name") %></a>
				<%
				out.println(" ");
				}
			%></td>		
		</tr>
		<%
			rs2.close();
			}
			rs1.close();
		%>

	</table>
		<% 
		} catch (Exception e) { 
			out.print(e);
		}
		%>

	<br>
	<br>

	<br>
	<br>
	<h3>
		<u>Auction Information</u>
	</h3>
	<form method="get" action=createAuction.jsp>
		<input type="submit" value="Create Auction">
	</form>
	<br>
	<form method="get" action=viewAuction.jsp>
		<input type="submit" value="View Items for Auction">
	</form>
	<br>
	<form method="get" action=requestItem.jsp>
		<input type="submit" value="Request Item">
	</form>
	<br>
	<h3>
		<u>Q&A</u>
	</h3>
	<form method="get" action=postQuestion.jsp>
		<input type="submit" value="Post Question">
	</form>
	<br>
	<form method="get" action=viewQuestions.jsp>
		<input type="submit" value="View Questions and Answers">
	</form>

	<br>
	<br>
	<form method="get" action=loginPage.jsp>
		<input type="submit" value="Logout">
	</form>
</body>
</html>