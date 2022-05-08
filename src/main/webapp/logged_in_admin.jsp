<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Staff Login</title>
</head>
<body>
	<h1>Staff</h1>
	<%	
    	out.println("Login Successful. Welcome " + session.getAttribute("user"));
	%>
	<a href = "log_out.jsp"> LOGOUT </a>
	<br> <br>
	<form method = "get" action = createRep.jsp>
		<input type="submit" value="Create Customer Rep Account">
	</form>
	<br> <br>
	<form method = "get" action = salesReports.jsp>
		<input type="submit" value="View Sales Reports">
	</form>
</body>
</html>