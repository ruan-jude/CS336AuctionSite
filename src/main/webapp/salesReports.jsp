<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="src.main.java.com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales Reports</title>
</head>
<body>
	<h1>Sales Reporting for BuyMe Auctions</h1>
	<h3>Total Earnings</h3>
	<table border='1'>
		<tr>
			<td>Total Earnings</td>
		</tr>
	<%
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			Statement st1 = con.createStatement();
			ResultSet rs1 = st1.executeQuery("SELECT FORMAT(SUM(bidding), 'C') AS 'Total Earnings' FROM auctions WHERE winner IS NOT NULL;");
			rs1.next();
		%>
		<tr>
			<td> <% if(rs1.getString("Total Earnings")== null)out.println("No Earnings");else out.println(rs1.getString("Total Earnings"));%></td>
	<% rs1.close(); %>
	</table>
	<br>
	<h3>Earnings per Each Item Sold</h3>
	<table border='1'>
		<tr>
			<td>Item ID</td>
			<td>Item Name</td>
			<td>Final Sale Price</td>
		</tr>
	<%
		st1 = con.createStatement();
		rs1 = st1.executeQuery("SELECT a.itemID, i.name, FORMAT(bidding, 'C') AS 'Final Sale Price' FROM auctions a JOIN items i ON a.itemID = i.itemID WHERE winner IS NOT NULL;");
		
		%>
		<% while (rs1.next()){ 
					%>
		<tr> 				
			<td><%= rs1.getString("itemID") %></td>		
			<td><%= rs1.getString("name") %></td>
			<td><%= rs1.getString("Final Sale Price") %></td>	
		</tr>		
		<%} rs1.close(); %>
	</table>
	<br>
	<h3>Earnings per Item Type</h3>
	<table border='1'>
		<tr>
			<td>Clothing Type</td>
			<td>Total Earnings</td>
		</tr>
		<%
			st1 = con.createStatement();
			rs1 = st1.executeQuery("SELECT i.clothingType, FORMAT(SUM(bidding), 'C') AS 'Total Earnings' FROM auctions a JOIN items i ON a.itemID = i.itemID WHERE winner IS NOT NULL GROUP BY clothingType;");
		%>
		<% while (rs1.next()){ 
					%>
		<tr> 				
			<td><%= rs1.getString("clothingType") %></td>		
			<td><%= rs1.getString("Total Earnings") %></td>
		</tr>		
		<%} rs1.close(); %>
	</table>
	<br>
</body>
</html>