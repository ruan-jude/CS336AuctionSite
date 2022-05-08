<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="src.main.java.com.cs336.pkg.*"%>
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

	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	try {
		Date dt = new Date();
		java.text.SimpleDateFormat sdf = 
			     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		String current = sdf.format(dt);
		
		String questionID = request.getParameter("questionID");
		String answer = request.getParameter("answer_text");
		boolean resolved = true;
		
		String str = "UPDATE customerserv SET answer = ?, customerRep = ?, dateAnswered = ?, resolved = ? " +
					 "WHERE questionID = " + questionID;
		
		PreparedStatement ps1 = con.prepareStatement(str);
		ps1.setString(1,answer);
		ps1.setString(2,session.getAttribute("email").toString());
		ps1.setString(3,current);
		ps1.setBoolean(4,resolved);
		
		
		out.print(ps1);
		
		ps1.executeUpdate();	
		out.print("Question Created!");
		
		
		
		

		
	} catch (Exception e) {
		e.printStackTrace();
	}
	db.closeConnection(con);

%>
</body>
</body>
<form method = "get" action = "answerQuestion.jsp">
	<input type="submit" value="Back">
</form>
</body>
</html>