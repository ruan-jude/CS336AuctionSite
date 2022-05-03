<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Screen</title>
</head>
<body>
	<h1>Online Auction Site</h1>
	<%	
    	out.println("Login Successful. Welcome " + session.getAttribute("user"));
	%>
	<a href = "log_out.jsp"> LOGOUT </a>
	<br> <br>
	<form method = "get" action = createAuction.jsp>
		<input type="submit" value="Create Auction">
	</form>
	<form method = "get" action = viewAuction.jsp>
		<input type="submit" value="View Items for Auction">
	</form>
</body>
</html>