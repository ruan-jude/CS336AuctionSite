<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>CreateRequest</title>
</head>
<body>
	<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	try {
		String clothingType = request.getParameter("clothing");
		String size = request.getParameter("size");
		String name = request.getParameter("name");
		String color = request.getParameter("color");
		String season = request.getParameter("season");
		
		// Throws error if required field is empty
		if (clothingType.length() == 0){
			session.setAttribute("invalidinput","Error: required(*) field(s) are empty.");
			response.sendRedirect("requestItem.jsp");
			return;
		} 
		
		//Create requestID:
		long reqID;
		String foundID;
		Statement st;
		do {
			reqID = new Random().nextLong();
			st = con.createStatement();
			foundID = "SELECT EXISTS(SELECT 1 FROM itemsReq WHERE requestID = '" + reqID + "')";
		} while (!st.execute(foundID));
		
		//Insert new item into items table:
		String insert = "INSERT INTO itemsReq(requestID, user, clothingType, size, name, color, season, fulfilled)" 
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setLong(1, reqID);
		ps.setString(2, session.getAttribute("email").toString());
		ps.setString(3, clothingType);
		if (size.length() != 0) ps.setString(4, size);
		else ps.setString(4, null);
		if (name.length() != 0) ps.setString(5, name);
		else ps.setString(5, null);
		if (color.length() != 0) ps.setString(6, color);
		else ps.setString(6, null);
		if (!season.equals("-")) ps.setString(7, season);
		else ps.setString(7, null);
		ps.setBoolean(8, false);
		
		//Run the query
		ps.executeUpdate();
		
		out.print("Request Created! View request on home page!");
	} catch (Exception e) {
		e.printStackTrace();
	}
	db.closeConnection(con);

%>
	<form method="get" action="loggedInReg.jsp">
		<input type="submit" value="Back">
	</form>
</body>
</html>