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
			session.setAttribute("invalidinput","Error: fields are empty.");
			response.sendRedirect("createDeleteAcc.jsp");
			return;
		}
		
		Statement st = con.createStatement();
		String str = "SELECT * FROM users WHERE email = '" + email + "'";
		ResultSet rs = st.executeQuery(str);
		if (rs.next()) {
			session.setAttribute("invalidinput","Email already in use. Please try a different email.");
			response.sendRedirect("createDeleteAcc.jsp");
		} else {
			//Make an insert statement for the Sells table:
			String insert = "INSERT INTO users(username, email)"
					+ "VALUES (?, ?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, un);
			ps.setString(2, email);
			//Run the query against the DB
			ps.executeUpdate();
			
			out.print("Account Created!");
		}
		db.closeConnection(con);
	} catch (Exception e) {
		e.printStackTrace();
	}

%>
<form method = "get" action = "createDeleteAcc.jsp">
	<input type="submit" value="Back">
</form>
</body>
</html>