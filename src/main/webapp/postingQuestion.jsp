<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="src.main.java.com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>PostingQuestion</title>
</head>
<body>
<%	

	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	try {
		String question = request.getParameter("paragraph_text");
		
		//Get current datetime
		Date dt = new Date();
		java.text.SimpleDateFormat sdf = 
			     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		String current = sdf.format(dt);
		
		//Check if date is in future
		//Create questionID:
		long questionID;
		Statement st;
		String findid;
		do {
			questionID = new Random().nextLong();
			st = con.createStatement();
			findid = "SELECT EXISTS(SELECT 1 FROM customerserv WHERE questionID = '" + questionID + "')";
		} while (!st.execute(findid));
		
		//Insert new item into items table:
		String insert = "INSERT INTO customerserv (questionID, question, askingUser, dateAsked, answer, answeringRep, dateAnswered, resolved)" 
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		
		//out.print(insert);
		
		PreparedStatement ps1 = con.prepareStatement(insert);
		ps1.setLong(1,questionID);
		ps1.setString(2,question);
		ps1.setString(3,session.getAttribute("email").toString());
		ps1.setString(4,current);
		ps1.setString(5,null);
		ps1.setString(6,null);
		ps1.setString(7,null);
		ps1.setBoolean(8,false);
		//out.print(ps1);
		ps1.executeUpdate();
		
		
		out.print("Question Created!");

		
	} catch (Exception e) {
		e.printStackTrace();
	}
	db.closeConnection(con);

%>
</body>
<form method = "get" action = "loggedInReg.jsp">
	<input type="submit" value="Back">
</form>
</body>
</html>