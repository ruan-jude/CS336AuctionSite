<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
	<h1>Welcome to BuyMe Auctions! Log In to Begin</h1>
	<div id="Login Form">
		<form method="get" action=loginTest.jsp>
			<table>
				<tr>
					<td>Email</td>
					<td><input type="email" name="email"></td>
				</tr>
				<tr>
					<td>Username</td>
					<td><input type="text" name="username"></td>
				</tr>
			</table>
			<input type="submit" name="command" value="Log In">
			<%	
		if(session.getAttribute("invalidinput") != null && session.getAttribute("invalidinput") != ""){
			out.println(session.getAttribute("invalidinput"));
			session.setAttribute("invalidinput","");}
	%>
		</form>
	</div>
	<br>
	<div id="Create/Delete Account">
		<form method="get" action=createDeletePage.jsp>
			<input type="submit" name="createDelete"
				value="Create/Delete An Account">
		</form>
	</div>
</body>
</html>