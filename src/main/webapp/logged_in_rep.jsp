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
	<br><br>
	<a href = "log_out.jsp"> LOGOUT </a>
	<br> <br>
	<form method = "get" action = answerQuestion.jsp>
		<input type="submit" value="answer Question">
	</form>
</body>
</html>