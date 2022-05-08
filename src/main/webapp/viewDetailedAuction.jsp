<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="src.main.java.com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Detailed Auction</title>

	<style>
		table td {
		  border: 1px solid black;
		}
	</style>

</head>
<body>
	<%
	long currAuc = 0;
	float inc = 0;
	String winner = "";
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Current auction we are looking at
		if (session.getAttribute("aucID").toString() == "") {
			session.setAttribute("aucID", request.getParameter("aucid"));
		}
		currAuc = Long.parseLong(session.getAttribute("aucID").toString());
		Statement st1 = con.createStatement();
		ResultSet rs1 = st1.executeQuery("SELECT * FROM items i, auctions a WHERE i.itemID = a.itemID AND a.auctionID ='" + currAuc +"'");
		%>
	<h2>Auction Details:</h2>
	
	
	<!-- TABLE FOR AUCTION DETAILS -->
	<table>
		<tr>    
			<td>Seller</td>
			<td>Name</td>	
			<td>Clothing Type</td>
			<td>Size</td>
			<td>Color</td>
			<td>Season</td>
			<td>Date Opened</td>
			<td>Closing Date</td>
			<td>Increment</td>
			<td>Current Highest Bid</td>
			<td>Winner</td>
		</tr>
		<%
			if (rs1.next()) {
				inc = rs1.getFloat("increment");
				Statement stmt2 = con.createStatement();
				String email = rs1.getString("owner");
				ResultSet rs2 = stmt2.executeQuery("SELECT * FROM users WHERE email = '" + email +"'");
				rs2.next();
		%>
		<tr>   
			<td><%= rs2.getString("username") %></td>
			<% rs2.close(); %>
			<td><%= rs1.getString("name") %></td>
			<td><%= rs1.getString("clothingType") %></td>
			<td><%= rs1.getString("size") %></td>
			<% 	String color = rs1.getString("color");
				if (color == null) {
					color = "N/A";
				}
			%>
			<td><%= color %></td>
			<% 	String seas = rs1.getString("season");
				if (seas == null) {
					seas = "N/A";
				}
			%>
			<td><%= seas %></td>
			<td><%= rs1.getString("dateOpen") %></td>
			<td><%= rs1.getString("dateClose") %></td>
			<td><%= rs1.getString("increment") %></td>
			<% String max = rs1.getString("bidding");
				if (max == null) {
					max = "N/A";
				}
			%>
			<td><%= max %></td>
			<%	winner = rs1.getString("winner");
				if (winner == null) {
					winner = "N/A";
				}
			%>
			<td><%= winner %></td>
		</tr>
		<%
			}
			rs1.close();
		%>
	</table>
	
	<br>
	
<h2>Bid History:</h2>
	<!-- TABLE FOR BID HISTORY -->
	<table>
		<tr>    
			<td>Bidder</td>
			<td>Amount</td>	
		</tr>
		<%
			Statement st3 = con.createStatement();
			ResultSet rs3 = st1.executeQuery("SELECT * FROM bids WHERE auctionID ='" + currAuc +"' ORDER BY amount DESC");
			while (rs3.next()) {
				Statement st4 = con.createStatement();
				String email = rs3.getString("bidder");
				ResultSet rs4 = st4.executeQuery("SELECT * FROM users WHERE email = '" + email +"'");
				rs4.next();
		%>
			<tr>   
				<td><%= rs4.getString("username") %></td>
				<% rs4.close(); %>
				<td><%= rs3.getString("amount") %></td>
			</tr>
		<%
			}
			rs3.close();
		%>
	</table>
	
	<% 
	} catch (Exception e) {
		out.print(e);
	} 
	%>
	
	
	
	<br>
	<h2>Place A Bid:</h2>
	<!-- SET A BID ON AUCTION -->
	<form method = "post" action = "setBid.jsp?aucid=<%= currAuc %>" id = bidForm>
	 	Amount* &emsp;<input type="number" name="bidAmt" step="<%= inc %>" min="0">	
	 	<br><br>
 		Autobid on this Auction?*
	 	<input type="radio" name="command" value = "yes" id="yesRadio"/> Yes
	 	<input type="radio" name="command" value = "no" id="noRadio"/> No
	 	<script>
		 	document.getElementById("yesRadio").addEventListener('click', function (event) {
		 	    if (event.target && event.target.matches("input[type='radio']")) {
		 	    	document.getElementById("autoinc").readOnly = false;
		 	    	document.getElementById("automax").readOnly = false;
		 	    }
		 	});
		 	document.getElementById("noRadio").addEventListener('click', function (event) {
		 	    if (event.target && event.target.matches("input[type='radio']")) {
		 	    	document.getElementById("autoinc").readOnly = true;
		 	    	document.getElementById("automax").readOnly = true;
		 	    	document.getElementById("autoinc").innerHTML = "";
		 	    	document.getElementById("automax").innerHTML = "";
		 	    }
		 	});
	 	</script>
	 	<br>
	 	Autobid Increment &emsp;<input type = "number" name="bidderInc" step="<%= inc %>" min="0" id="autoinc" readOnly>
	 	<br>
	 	Autobid Max &emsp;<input type = "number" name="bidderMax" step="<%= inc %>" min="0" id="automax" readOnly>
	 	<br>
		<input type="submit" value="Place Bid">
	</form>
	<%	
		if(session.getAttribute("invalidinput") != null && session.getAttribute("invalidinput") != ""){
			out.println(session.getAttribute("invalidinput"));
			session.setAttribute("invalidinput","");}
	%>
	
	<br> <br>
	<form method = "get" action = "viewAuction.jsp">
		<input type="submit" value="Back">
	</form>

</body>
</html>