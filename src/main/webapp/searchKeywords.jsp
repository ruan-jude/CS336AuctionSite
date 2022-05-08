<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="src.main.java.com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search by Keyword</title>
</head>
<body>
<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	try {
		String keyStr = request.getParameter("keywords");
		if(keyStr == null || keyStr.length() == 0){
			session.setAttribute("invalidinput","Error: no keywords entered.");
			response.sendRedirect("viewQuestions.jsp");
			return;
		}
		String[] keywords = keyStr.split("\\s+");
		
		Statement st = con.createStatement();
		String query = "SELECT * FROM customerServ WHERE question LIKE '%" + keywords[0] + "%'";
		
		for (int i = 1; i < keywords.length; ++i){
			query += " AND question LIKE '%" + keywords[i] + "%'";
		}
		ResultSet rs = st.executeQuery(query);
		%>
		<table border='1'>
		<tr>
			<td>QUESTION ID</td>
			<td>Question</td>
			<td>Answer</td>
		</tr>
		<%
			//parse out the results
			while (rs.next()) { 
		
			%>
		<tr>
			<td><%= rs.getString("questionID") %></td>
			<td><%= rs.getString("question") %></td>
			<td>
				<% if(rs.getString("answer") == null) out.println("unanswered"); else rs.getString("answer"); %>
			</td>
		</tr>
		<% } 
			rs.close();%>
	</table>
		<% 
		db.closeConnection(con);
	} catch (Exception e) {
		e.printStackTrace();
	}

%>
<form method = "get" action = "viewQuestions.jsp">
	<input type="submit" value="Back">
</form>
</body>
</html>