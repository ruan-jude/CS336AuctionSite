<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Post Question</title>
</head>
<body>
<h1>Ask a Question for our Customer Reps!</h1>
	<br><br>
	Post Question
	<br>
		<form method="get" action="postingQuestion.jsp">	
			<textarea name="paragraph_text" cols="50" rows="10"></textarea>
			<input type="submit" value="SUBMIT">
		</form>
	<br>
</body>

<form method = "get" action = "loggedInReg.jsp">
	<input type="submit" value="Back">
</form>

</html>