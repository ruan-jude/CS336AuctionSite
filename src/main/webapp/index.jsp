<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>AuctionSite</title>
</head>
<body>
<h1>Online Auction Site</h1>
<div id="Login Form"> 
<form method="get" action = logtest.jsp>
	<table>
		<tr>    
			<td>Username</td><td><input type="text" name="username"></td>
		</tr>
		<tr>
			<td>Password</td><td><input type="password" name="password"></td>
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
</body>
</html>