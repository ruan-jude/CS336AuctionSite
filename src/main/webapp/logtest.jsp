<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Testing Login</title>
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
		
		if (rs.next()) {
			session.setAttribute("user", rs.getString("username"));
			session.setAttribute("email", rs.getString("email"));
			response.sendRedirect("logged_in.jsp");
		} else {
			session.setAttribute("invalidinput","Unsuccessful Login. Username/email did not work. Please try again");
			response.sendRedirect("index.jsp");
		}
		
		rs.close();
		db.closeConnection(con);
	} catch (Exception e) {
		e.printStackTrace();
	}

	%>
</body>
</html>