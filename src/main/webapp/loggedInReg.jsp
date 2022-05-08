<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>RegLoginScreen</title>
</head>
<body>
	<h1>Online Auction Site</h1>
	<%	
    	out.println("Welcome " + session.getAttribute("user") + "!");
	%>
	<br>
	Requested items:
	<table border='1'>
		<tr>
			<td>Item Details</td>
			<td>Status</td>
		</tr>
	</table>
	
	<br> <br>
	
	<br> <br>
	<h3><u>Auction Information</u></h3>
	<form method = "get" action = createAuction.jsp>
		<input type="submit" value="Create Auction">
	</form>
	<br>
	<form method = "get" action = viewAuction.jsp>
		<input type="submit" value="View Items for Auction">
	</form>
	<br>
	<form method = "get" action = requestItem.jsp>
		<input type="submit" value="Request Item">
	</form>
	<br>
	<h3><u>Q&A</u></h3>
	<form method = "get" action = postQuestion.jsp>
		<input type="submit" value="Post Question">
	</form>
	<br>
	<form method = "get" action = viewQuestions.jsp>
		<input type="submit" value="View Questions and Answers">
	</form>

	<br> <br>
	<form method = "get" action = loginPage.jsp>
		<input type="submit" value="Logout">
	</form>
</body>
</html>