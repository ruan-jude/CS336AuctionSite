<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DeletingAccount</title>
</head>
<body>
<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	try {
		String un = request.getParameter("username");
		String email = request.getParameter("email");
		
		if(un.length() == 0 || email.length() == 0){
			session.setAttribute("invalidinput","Error: fields are empty.");
			response.sendRedirect("createDeletePage.jsp");
			return;
		}
		
		Statement st = con.createStatement();
		String str = "SELECT * FROM users WHERE email = '" + email + "' and username = '" + un + "'";
		ResultSet rs = st.executeQuery(str);
		if (rs.next()) {
			//Make an insert statement for the Sells table:
			String delete = "DELETE FROM users WHERE email = '" + email + "' and username = '" + un + "'";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			Statement st2 = con.createStatement();
			st2.execute(delete);
			
			out.print("Account Deleted!");
		} else {
			session.setAttribute("invalidinput","No accounts exist with this username and email combination");
			response.sendRedirect("createDeletePage.jsp");
		}
		db.closeConnection(con);
	} catch (Exception e) {
		e.printStackTrace();
	}

%>
<form method = "get" action = "loginPage.jsp">
	<input type="submit" value="Back">
</form>
</body>
</html>