<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Customer Rep Account</title>
</head>
<body>
	<h3>Create Account for Customer Representative</h3>
	<form method="get" action="creatingRepAcc.jsp">
		<table>
			<tr>
				<td>Email</td><td><input type="text" name="email"></td>
			</tr>
			<tr>    
				<td>Username</td><td><input type="text" name="username"></td>
			</tr>
		</table>
		<input type="submit" value="Create">
	</form>
	<br>
	
	<form method = "get" action = "logged_in_admin.jsp">
		<input type="submit" value="Back">
	</form>
</body>
</html>