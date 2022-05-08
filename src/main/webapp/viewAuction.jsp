<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="src.main.java.com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html SYSTEM "about:legacy-compat">
<html>
<style>
.alert {
	padding: 20px;
	background-color: #f44336;
	color: white;
}

.closebtn {
	margin-left: 15px;
	color: white;
	font-weight: bold;
	float: right;
	font-size: 22px;
	line-height: 20px;
	cursor: pointer;
	transition: 0.3s;
}

.closebtn:hover {
	color: black;
}
</style>
<head>
<meta charset="ISO-8859-1">
<title>View Auction</title>

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
			
			//Check if we need any alerts:
			Statement autoBidMaxed = con.createStatement();
			ResultSet checkAutoBids = autoBidMaxed.executeQuery("SELECT * FROM auctions a, items i, bids b WHERE i.itemID = a.itemID AND b.auctionID = a.auctionID AND b.reachedMax = 1 AND b.didAlert = 0 AND b.bidder = '" + session.getAttribute("email").toString() + "'");
			while (checkAutoBids.next()) {
			%>
			<div class="alert">
				<span class="closebtn"
					onclick="this.parentElement.style.display='none';">&times;</span>
				Someone has placed a bid that puts your autobid over your upper limit
				for the item, <strong><%=checkAutoBids.getString("name")%></strong>.
			</div>
			<% 	
				Statement st = con.createStatement();
				st.executeUpdate("UPDATE bids SET bids.didAlert = 1 WHERE bidID = '" + checkAutoBids.getLong("bidID") + "'");
			}
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("command");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "";
			
			
			
			if(request.getParameter("month") != null){
				String month = request.getParameter("month");
				str = "SELECT * FROM items i, auctions a WHERE i.itemID = a.itemID AND " +
					  "(monthname(dateOpen) = '" + month + "' or monthname(dateClose) = '" + month + "')";
				
			}
			
			
			else if(request.getParameter("queryname") != null){
				String x = request.getParameter("queryname");
				String str2 = "SELECT email from users WHERE username = '" + x + "'";
				
				Statement stmtX = con.createStatement();
				ResultSet r = stmtX.executeQuery(str2);
				r.next();
				String gmail = r.getString("email");
				
				str = "SELECT * FROM items i,auctions a, bids b " + 
						"WHERE i.itemID = a.itemID AND " + 
						"a.auctionID = b.auctionID AND (owner = '" + gmail + "' OR bidder = '" + gmail + "')";
			}
			else if(request.getParameter("specific") != null){
				String x = request.getParameter("specific");
				str = "SELECT * FROM items i,auctions a WHERE i.itemID = a.itemID ORDER BY " + x + " ASC";
			}
			else{
				str = "SELECT * FROM items i,auctions a WHERE i.itemID = a.itemID ORDER BY dateOpen DESC";
			}
			//Run the query against the database.
			//out.println(str);
			
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
			<td><a
				href="viewDetailedAuction.jsp?aucid=<%= result.getString("auctionID") %>"><%= result.getString("name") %></a>
			</td>
			<td><%= result.getString("clothingType") %></td>
			<td><%= result.getString("size") %></td>
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

	<br>
	<br> SORT BY:
	<br>
	<form method="get" action="viewAuction.jsp">
		<select name="specific" size=1>
			<option value="bidding">Bidding Price (Low to High)</option>
			<option value="clothingType">Clothing Type</option>
			<option value="dateClose">Closing Date</option>
			<option value="name">Name</option>
			<option value="owner">Seller</option>
			<option value="size">Size</option>
		</select>&nbsp;<br> <input type="submit" value="submit">
	</form>
	<br>

	<br>
	<br> List of all auctions a specific buyer or seller participated
	in
	<br>
	<form method="get" action="viewAuction.jsp">
		<table>
			<tr>
				<td>Name</td>
				<td><input type="text" name="queryname"></td>
			</tr>
		</table>
		<input type="submit" value="SUBMIT">
	</form>
	<br>

	<br>
	<br> View List of Similar Items on Auctions in Month
	<br>
	<form method="get" action="viewAuction.jsp">
		<table>
			<tr>
				<td>Month</td>
				<td><input type="text" name="month"></td>
			</tr>
		</table>
		<input type="submit" value="SUBMIT">
	</form>
	<br>




	<%
			//close the connection.
			db.closeConnection(con);
			%>


	<%} catch (Exception e) {
			out.print(e);
		}%>

	<br>
	<form method="get" action="loggedInReg.jsp">
		<input type="submit" value="Back">
	</form>
</body>
</html>