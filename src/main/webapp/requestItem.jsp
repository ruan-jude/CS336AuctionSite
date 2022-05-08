<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>RequestItem</title>
</head>
<body>
	<h1>Request Item</h1>
	<form method="post" action=createRequest.jsp>
		<label for="clothing">Choose a clothing type*:</label> <select
			name="clothing" id="clothing">
			<option value="Shirt">Shirt</option>
			<option value="Pants">Pants</option>
			<option value="Shoes">Shoes</option>
			<option value="Jacket">Jacket</option>
		</select>
		<table>
			<tr>
				<td>Name</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>Size</td>
				<td><input type="text" name="size"></td>
			</tr>
			<tr>
				<td>Color</td>
				<td><input type="text" name="color"></td>
			</tr>
		</table>
		<label for="season">Season:</label> <select name="season" id="season">
			<option value="-">-</option>
			<option value="Spring">Spring</option>
			<option value="Summer">Summer</option>
			<option value="Fall">Fall</option>
			<option value="Winter">Winter</option>
		</select> <br> <br> <input type="submit" name="command"
			value="Request">
		<%	
		if(session.getAttribute("invalidinput") != null && session.getAttribute("invalidinput") != ""){
			out.println(session.getAttribute("invalidinput"));
			session.setAttribute("invalidinput","");}
	%>
	</form>
	<br>
	<form method="get" action="loggedInReg.jsp">
		<input type="submit" value="Back">
	</form>
</body>
</html>