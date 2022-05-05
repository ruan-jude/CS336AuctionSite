<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Auction</title>
</head>
<body>
<h1>Create an Auction</h1>
<form method="post" action = createdAuction.jsp>
	<label for="clothing">Choose a clothing type*:</label>
	<select name="clothing" id="clothing">
    	<option value="Shirt">Shirt</option>
    	<option value="Pants">Pants</option>
 	   	<option value="Shoes">Shoes</option>
  	  	<option value="Jacket">Jacket</option>
 	 </select>
 	<table>
 		<tr>
 			<td>Name*</td><td><input type="text" name="name"></td>
 		</tr>
 		<tr>    
			<td>Size*</td><td><input type="text" name="size"></td>
		</tr>
		<tr>
			<td>Color</td><td><input type="text" name="color"></td>
		</tr>
 	</table>
 	<label for="season">Season:</label>
	<select name="season" id="season">
	 	<option value="-">-</option>
    	<option value="Spring">spring</option>
    	<option value="Summer">summer</option>
 	   	<option value="Fall">fall</option>
  	  	<option value="Winter">winter</option>
 	 </select>
 	<br>
 	<br>
	<table>
		<tr>
			<td>Increment*</td><td><input type="number" name="increment" step="any" min="0"></td>
		</tr>
		<tr>
			<td>Closing Date*</td><td><input type="datetime-local" name="closingDate"></td>
		</tr>
		<tr>    
			<td>Minimum Price</td><td><input type="number" name="minPrice" step="any" min="0"></td>
		</tr>
	</table>
	<input type="submit" name="command" value="Create">
	<%	
		if(session.getAttribute("invalidinput") != null && session.getAttribute("invalidinput") != ""){
			out.println(session.getAttribute("invalidinput"));
			session.setAttribute("invalidinput","");}
	%>
</form>
<br>
<form method = "get" action = "logged_in.jsp">
	<input type="submit" value="Back">
</form>

</body>
</html>