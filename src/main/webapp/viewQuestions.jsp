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
<%
try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String str = "SELECT * from customerserv";
		ResultSet result = stmt.executeQuery(str);
		
%>

<table>
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
					
					<td><%= result.getString("answer") %></td>
				
				</tr>
				

			<% } 
			result.close();%>
</table>

<% } catch (Exception e) {
			out.print(e);
}%>
</body>
<form method = "get" action = "logged_in.jsp">
			<input type="submit" value="Back">
</form>
</html>