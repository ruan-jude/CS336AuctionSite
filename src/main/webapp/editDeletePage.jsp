<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="src.main.java.com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit/Delete Account</title>
</head>
<body>
	<h1>Edit/Delete Account</h1>
	<h3>List of Users</h3>
	<%
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String str = "SELECT * from users";
		ResultSet result = stmt.executeQuery(str);
	%>
	<table border='1'>
		<tr>
			<td>Email</td>
			<td>Username</td>
		</tr>
		<%
		//parse out the results
		while (result.next()) {
		%>
		<tr>
			<td><%=result.getString("email")%></td>
			<td><%=result.getString("username")%></td>
		</tr>
		<%
		}
		result.close();
		%>
	</table>

	<%
	} catch (Exception e) {
	out.print(e);
	}
	%>
	<br>
	<h3>
		<u>Edit account username</u>
	</h3>
	<form method="post" action="changingUserRep.jsp">
		<table>
			<tr>
				<td>Email</td>
				<td><input type="email" name="email"></td>
			</tr>
			<tr>
				<td>New Username</td>
				<td><input type="text" name="username"></td>
			</tr>
		</table>
		<input type="submit" value="Change Email">
	</form>
	<br>
	<h3>
		<u>Delete account</u>
	</h3>
	<form method="post" action="deletingAccRep.jsp">
		<table>
			<tr>
				<td>Email of Account to Delete</td>
				<td><input type="email" name="email"></td>
			</tr>
		</table>
		<input type="submit" value="Delete Account">
	</form>
	<br>
	<%
	if (session.getAttribute("invalidinput") != null && session.getAttribute("invalidinput") != "") {
		out.println(session.getAttribute("invalidinput"));
		session.setAttribute("invalidinput", "");
	}
	%>
	<form method="get" action="loggedInRep.jsp">
		<input type="submit" value="Back">
	</form>
</body>
</html>