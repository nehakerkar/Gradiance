<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="Style.css"/>
		<title>Admin Home</title>
	</head>
	<script>
	function validateNotifications()
	{
		var radios = document.getElementsByName("notifications_checked");
	    var formValid = false;

	    var i = 0;
	    while (!formValid && i < radios.length) {
	        if (radios[i].checked) formValid = true;
	        i++;        
	    }

	    if (!formValid) alert("Please select a notification.");
	    return formValid;
	}
	</script>
<body>
	<% String userid= (String)session.getAttribute("userid"); if (userid==null) response.sendRedirect("index.jsp");%>
		<div class="header-container">
			<div class="header">
				<form action="userLogout" method="post" align="right">
					<input type="submit" value="Logout" />
				</form>
			</div>
		</div>
<center>
		<sql:setDataSource var="courses" driver="com.mysql.jdbc.Driver"
		     url="jdbc:mysql://localhost:3306/gradiance"
		     user="root"  password=""/>
		     
<div class="container">
<div class="main">
		<h2>Notifications</h2><hr/>
		<sql:query dataSource="${courses}" var="result1">
		SELECT * from notification where userid='<%=userid %>';
		</sql:query>
		<form name="notifications" method="post" action="notifications">
				<table border="1" width="500px">
				<c:forEach var="row" items="${result1.rows}">
					<tr>
						<td align="center" width="50 px"><input type="checkbox" name="notifications_checked" value="${row.messageid}"></td>
						<td align="center"><c:out value="${row.message}"/></td>
					</tr>
				</c:forEach>
				</table>
				<input type="submit" value="Delete seen messages" onclick="return validateNotifications()"/>
		</form>
		
</div>
</div>
		</center>
	</body>
</html>