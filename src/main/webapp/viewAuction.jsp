<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
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
	<h1>List of Auctions</h1>
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("command");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM items i,auctions a WHERE i.itemID = a.itemID";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table>
		<tr>    
			<td>Seller</td>
			<td>Name</td>	
			<td>Clothing Type</td>
			<td>Size</td>
			<td>Color</td>
			<td>Date Opened</td>
			<td>Date Closed</td>
			<td>Increment</td>
			<td>Current Max Bid</td>
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
					<td><%= result.getString("name") %></td>
					<td><%= result.getString("clothingType") %></td>
					<td><%= result.getString("size") %></td>
					<td><%= result.getString("color") %></td>
					<td><%= result.getString("dateOpen") %></td>
					<td><%= result.getString("dateClose") %></td>
					<td><%= result.getString("increment") %></td>
					<td><%= result.getString("bidding") %></td>
				</tr>

			<% } 
			result.close();%>
		</table>
		
		<br><br>
		<form method="get" action = specificquery.jsp>
			<label for="setBid">Set Bid on Item:</label>
			<table>
				<tr>    
				<td>Enter ItemID: </td><td><input type="text" name="ItemID"></td>
				</tr>
				<tr>
				<td>Bid Amount: </td><td><input type="text" name="Bid"></td>
				</tr>
			</table>
			<input type="submit" name="command" value="Submit">
		</form>
				
			<%
			//close the connection.
			db.closeConnection(con);
			%>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
</body>
</html>