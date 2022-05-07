<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Customer Rep Account</title>
</head>
<body>
	<br><br>
	Create Account for Customer Representative
	<br>
		<form method="get" action="createAcc.jsp">
			<table>
				<tr>    
					<td>Username</td><td><input type="text" name="username"></td>
					<td>Email</td><td><input type="text" name="email"></td>
					<td>Enter Code (Code: Y)</td><td><input type="text" name="code"></td>
				</tr>
			</table>
			<input type="submit" value="SUBMIT">
		</form>
	<br>
</body>
</html>