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
<form method="get" action = createdAuction.jsp>
	<label for="clothing">Choose a clothing type*:</label>
	<select name="clothing" id="clothing">
    	<option value="shirt">Shirt</option>
    	<option value="pants">Pants</option>
 	   <option value="shoes">Shoes</option>
  	  <option value="jacket">Jacket</option>
 	 </select>
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

</body>
</html>