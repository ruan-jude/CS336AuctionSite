<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Rep Home</title>
</head>
<body>
	<h1>Customer Representative Dashboard</h1>
	<%	
    	out.println("Welcome " + session.getAttribute("user") +"!");
	%>
	<br><br>
	<form method="get" action=answerQuestion.jsp>
		<input type="submit" value="Answer a Question">
	</form>
	<br>
	<form method="get" action=editDeletePage.jsp>
		<input type="submit" value="Edit/Delete Account">
	</form>
	<br>
	<form method="get" action=deleteAucPage.jsp>
		<input type="submit" value="Delete Auction">
	</form>
	<br>
	<form method="get" action=deleteBidPage.jsp>
		<input type="submit" value="Delete Bid">
	</form>
	<br><br>
	<form method="get" action=loginPage.jsp>
		<input type="submit" value="Logout">
	</form>
</body>
</html>