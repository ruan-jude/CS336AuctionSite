<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create/Delete Account</title>
</head>
<body>
	<h1>Create/Delete Account</h1>
	<form method="post" action="createAcc.jsp">
		<table>
			<tr>
				<td>Username</td>
				<td><input type="text" name="username"></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><input type="email" name="email"></td>
			</tr>
		</table>
		<input type="submit" value="Create Account"> <input
			type="submit" value="Delete Account" formaction="deleteAcc.jsp">
		<%	
		if(session.getAttribute("invalidinput") != null && session.getAttribute("invalidinput") != ""){
			out.println(session.getAttribute("invalidinput"));
			session.setAttribute("invalidinput","");}
	%>
	</form>
	<br>
	<form method="get" action="index.jsp">
		<input type="submit" value="Back">
	</form>
</body>
</html>