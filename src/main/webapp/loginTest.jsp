<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="src.main.java.com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Test</title>
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
			response.sendRedirect("loginPage.jsp");
			return;
		}
		
		Statement st = con.createStatement();

		String str = "select * from users where username='" + un + "' and email='" + email + "'";
		ResultSet rs = st.executeQuery(str); //remember to change this
		
		if (rs.next()) {
			session.setAttribute("user", rs.getString("username"));
			session.setAttribute("email", rs.getString("email"));
			if (rs.getBoolean("isAdmin")) {
				response.sendRedirect("logged_in_admin.jsp");
			} else if (rs.getBoolean("isRep")) {
				response.sendRedirect("loggedInRep.jsp");
			} else {
				response.sendRedirect("loggedInReg.jsp");
			}
		} else {
			session.setAttribute("invalidinput","Unsuccessful Login. Username/email did not work. Please try again");
			response.sendRedirect("loginPage.jsp");
		}
		
		rs.close();
		db.closeConnection(con);
	} catch (Exception e) {
		e.printStackTrace();
	}

	%>
</body>
</html>