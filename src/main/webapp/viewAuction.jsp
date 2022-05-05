<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html SYSTEM "about:legacy-compat">
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

	<style>
		table td {
		  border: 1px solid black;
		}
	</style>

</head>
<body>
	<h2>List of Auctions</h2>
	<h5>Click an Item Name to See More!</h5>
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("command");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM items i,auctions a WHERE i.itemID = a.itemID ORDER BY dateOpen DESC";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			session.setAttribute("aucID", "");
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table>
		<tr>    
			<td>Seller</td>
			<td>Name</td>	
			<td>Clothing Type</td>
			<td>Size</td>
			<td>Color</td>
			<td>Closing Date</td>
			<td>Current Highest Bid</td>
		</tr>
			<%
			//parse out the results
			while (result.next()) { 
				Statement stmt2 = con.createStatement();
				String email = result.getString("owner");
				ResultSet rs = stmt2.executeQuery("SELECT * FROM users WHERE email = '" + email +"'");
				rs.next();
			%>
				<tr>   
					<td><%= rs.getString("username") %></td>
					<% rs.close(); %>
					<td><a href="viewDetailedAuction.jsp?aucid=<%= result.getString("auctionID") %>"><%= result.getString("name") %></a> </td>
					<td><%= result.getString("clothingType") %></td>
					<td><%= result.getString("size") %></td>
					<td><%= result.getString("color") %></td>
					<td><%= result.getString("dateClose") %></td>
					<% String max = result.getString("bidding");
						if (max == null) {
							max = "N/A";
						}
					%>
					<td><%= max %></td>
				</tr>
				

			<% } 
			result.close();%>
		</table>
		
				
			<%
			//close the connection.
			db.closeConnection(con);
			%>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
		
		<br>
		<form method = "get" action = "logged_in.jsp">
			<input type="submit" value="Back">
		</form>
</body>
</html>