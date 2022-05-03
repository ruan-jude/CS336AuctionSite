<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1>Item Auctions</h1>
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
			<td>Item ID</td>
			<td>Name</td>
			<td>CLOTHING TYPE</td>
			<td>size</td>
			<td>color</td>
			<td>OPEN DATE</td>
			<td>CLOSE DATE</td>
			<td>Minimum Price</td>
			<td>increment</td>
			<td>BIDDING</td>
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>   
					<td><%= result.getString("itemID") %></td>
					<td><%= result.getString("name") %></td>
					<td><%= result.getString("clothingType") %></td>
					<td><%= result.getString("size") %></td>
					<td><%= result.getString("color") %></td>
					<td><%= result.getString("dateOpen") %></td>
					<td><%= result.getString("dateClose") %></td>
					<td><%= result.getString("minPrice") %></td>
					<td><%= result.getString("increment") %></td>
					<td><%= result.getString("bidding") %></td>
				</tr>

			<% } %>
			

			<form method="get" action = specificquery.jsp>
			<td><br><br>Set Bid on Item</td>
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
		</table>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
</body>
</html>