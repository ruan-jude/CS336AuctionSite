<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<br><br>
	Answer Question
	<br>
		<form method="get" action="answeredQuestion.jsp">
			<table>
				<tr>    
					<td>Enter Question ID</td><td><input type="text" name="questionID"></td>
				</tr>
			</table>
			Type Text Here:
			<textarea name="answer_text" cols="50" rows="10"></textarea>
			<input type="submit" value="SUBMIT">
		</form>
	<br>
</body>
<form method = "get" action = "logged_in.jsp">
	<input type="submit" value="Back">
</form>
</html>