<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="src.main.java.com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Answer Question</title>
</head>
<body>
	<h1>Answer a Question!</h1>
	<%
try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String str = "SELECT * from customerserv";
		ResultSet result = stmt.executeQuery(str);
		
%>

	<table border='1'>
		<tr>
			<td>QUESTION ID</td>
			<td>Question</td>
			<td>Answer</td>
		</tr>
		<%
			//parse out the results
			while (result.next()) { 
		
			%>
		<tr>
			<td><%= result.getString("questionID") %></td>
			<td><%= result.getString("question") %></td>
			<td>
				<% if(result.getString("answer") == null) out.println("unanswered"); else out.println(result.getString("answer")); %>
			</td>
		</tr>

		<% } 
			result.close();%>
	</table>

	<% } catch (Exception e) {
			out.print(e);
}
	%>
	<br>
	<br>
	<form method="get" action="answeringQuestion.jsp">
		<table>
			<tr>
				<td>Enter Question ID</td>
				<td><input type="text" name="questionID"></td>
			</tr>
		</table>
		<textarea name="answer_text" cols="50" rows="10"></textarea>
		<input type="submit" value="SUBMIT">
	</form>
</body>

<%
if(session.getAttribute("invalidinput") != null && session.getAttribute("invalidinput") != ""){
	out.println(session.getAttribute("invalidinput"));
	session.setAttribute("invalidinput","");}
%>
<br>
<form method="get" action="loggedInRep.jsp">
	<input type="submit" value="Back">
</form>
</html>