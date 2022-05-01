<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create/Delete Account</title>
</head>
<body>
<form method = "post" action = "createAcc.jsp">
	<table>
		<tr>    
			<td>Username</td><td><input type="text" name="username"></td>
		</tr>
		<tr>
			<td>Email</td><td><input type="email" name="email"></td>
		</tr>
	</table>
	<input type="submit" value="Create Account">
	<input type="submit" value="Delete Account" formaction = "deleteAcc.jsp">
	<%	
		if(session.getAttribute("invalidinput") != null && session.getAttribute("invalidinput") != ""){
			out.println(session.getAttribute("invalidinput"));
			session.setAttribute("invalidinput","");}
	%>
</form>
<br>
<form method = "get" action = "index.jsp">
	<input type="submit" value="Back">
</form>
</body>
</html>