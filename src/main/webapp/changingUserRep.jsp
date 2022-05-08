<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="src.main.java.com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Changing Username</title>
</head>
<body>
	<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	try {
		String em = request.getParameter("email");
		String un = request.getParameter("username");
		
		if(un.length() == 0 || em.length() == 0){
			session.setAttribute("invalidinput","Error: fields are empty.");
			response.sendRedirect("editDeletePage.jsp");
			return;
		}
		
		if (em.equals(session.getAttribute("email"))) {
			session.setAttribute("invalidinput","Error: Can't delete current user.");
			response.sendRedirect("editDeletePage.jsp");
			return;
		}
		
		if (em.equals("admin@gmail.com")) {
			session.setAttribute("invalidinput","Error: Can't edit admin.");
			response.sendRedirect("editDeletePage.jsp");
			return;
		}
		
		Statement st = con.createStatement();
		String str = "SELECT * FROM users WHERE email = '" + em + "'";
		ResultSet rs = st.executeQuery(str);
		if (rs.next()) {
			String query = "UPDATE users SET username = '" + un + "' WHERE email = '" + em + "'";		
			PreparedStatement ps = con.prepareStatement(query);
			ps.executeUpdate();	
			out.print("Updated username!");
		} else {
			session.setAttribute("invalidinput","Account doesn't exist Please try a different email.");
			response.sendRedirect("editDeletePage.jsp");
			
		}
		db.closeConnection(con);
	} catch (Exception e) {
		e.printStackTrace();
	}

%>
	<form method="get" action="editDeletePage.jsp">
		<input type="submit" value="Back">
	</form>
</body>
</html>