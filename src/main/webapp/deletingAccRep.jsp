<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="src.main.java.com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Deleting Account</title>
</head>
<body>
<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	try {
		String em = request.getParameter("email");
		
		if(em.length() == 0){
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
			session.setAttribute("invalidinput","Error: Can't delete admin.");
			response.sendRedirect("editDeletePage.jsp");
			return;
		}
		
		Statement st = con.createStatement();
		String str = "SELECT * FROM users WHERE email = '" + em + "'";
		ResultSet rs = st.executeQuery(str);
		if (rs.next()) {
			//Make an insert statement for the Sells table:
			String delete = "DELETE FROM users WHERE email = '" + em + "'";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			Statement st2 = con.createStatement();
			st2.executeUpdate(delete);
			
			out.print("Account Deleted!");
		} else {
			session.setAttribute("invalidinput","No accounts exist with this email");
			response.sendRedirect("editDeletePage.jsp");
			return;
		}
		db.closeConnection(con);
	} catch (Exception e) {
		e.printStackTrace();
	}

%>
<form method = "get" action = "editDeletePage.jsp">
	<input type="submit" value="Back">
</form>
</body>
</html>