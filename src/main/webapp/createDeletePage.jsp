<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create/Delete</title>
</head>
<body>
	<h3>Create/Delete Account</h3>
	<form method="post" action="creatingAcc.jsp">
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
		<input type="submit" value="Create Account"> <input
			type="submit" value="Delete Account" formaction="deletingAcc.jsp">
		<%	
		if(session.getAttribute("invalidinput") != null && session.getAttribute("invalidinput") != ""){
			out.println(session.getAttribute("invalidinput"));
			session.setAttribute("invalidinput","");}
	%>
	</form>
	<br>
	<form method="get" action="loginPage.jsp">
		<input type="submit" value="Back">
	</form>
</body>
</html>