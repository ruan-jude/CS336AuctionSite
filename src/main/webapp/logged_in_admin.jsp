<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Dash</title>
</head>
<body>
	<h1>Admin Dashboard</h1>
	<%	
    	out.println("Welcome " + session.getAttribute("user") +"!");
	%>
	<br> <br>
	<form method = "get" action = createRep.jsp>
		<input type="submit" value="Create Customer Rep Account">
	</form>
	<br> 
	<form method = "get" action = salesReports.jsp>
		<input type="submit" value="View Sales Reports">
	</form>
	<br><br>
	<form method = "get" action = loginPage.jsp>
		<input type="submit" value="Logout">
	</form>
</body>
</html>