<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
		String un = request.getParameter("username");
		String email = request.getParameter("email");
		
		if(un.length() == 0 || email.length() == 0){
			session.setAttribute("invalidinput","Error: fields are empty");
			response.sendRedirect("index.jsp");
			return;
		}
		
		Statement st = con.createStatement();

		String str = "select * from users where username='" + un + "' and email='" + email + "'";
		ResultSet rs = st.executeQuery(str); //remember to change this
		
		int count = 0;
		while (rs.next()) {
			count++;
			// retrieve and print the values for the current row
			//String a1 = rs.getString("username");
			//String a2 = rs.getString("password");
			//out.println("ROW = " + a1 + " " + a2);
		}
		if(count == 0){
			session.setAttribute("invalidinput","Unsuccessful Login.  Username/email did not work.  Please try again");
			response.sendRedirect("index.jsp");
		}
		else {
			session.setAttribute("user", un);
			response.sendRedirect("logged_in.jsp");
		}
		
		db.closeConnection(con);
	} catch (Exception e) {
		e.printStackTrace();
	}

	%>
</body>
</html>