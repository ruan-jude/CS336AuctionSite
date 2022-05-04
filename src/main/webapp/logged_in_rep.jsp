<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1>Customer Rep</h1>
	<%	
    	out.println("Login Successful. Welcome " + session.getAttribute("user"));
	%>
	<a href = "log_out.jsp"> LOGOUT </a>
	<br> <br>
</body>
</html>