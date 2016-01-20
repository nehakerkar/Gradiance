<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Teaching Assistant Activities</title>
<link rel="stylesheet" href="Style.css"/>
<script>
function validateViewHW()
{
	document.viewhw.valueconfirm.value="";
	var checkboxes = document.getElementsByName("radioexercise");
    var formValid = false;
	var i = 0;
    while (!formValid && i < checkboxes.length) {
        if (checkboxes[i].checked) formValid = true;
        i++;        
    }

    if (!formValid) 
    	alert("Please select a homework to view.");
    else
    	document.viewhw.valueconfirm.value="view";
    return formValid;
}
</script>
</head>
<body>
<% String userid= (String)session.getAttribute("userid"); if (userid==null) response.sendRedirect("index.jsp");%>
<% String token = request.getParameter("token");
	session.setAttribute("token", token);
%>
<sql:setDataSource var="courses" driver="com.mysql.jdbc.Driver"
		     url="jdbc:mysql://localhost:3306/gradiance"
		     user="root"  password=""/>
<center>
<div class="content">
<div class="header-container">
	<div class="header" align="right">
		<form action="userLogout" method="post">
			<input type="submit" name="logout" value="Logout" align="right"/>
		</form>
		<a href="tahome.jsp" class="back"> Home</a>
	</div>
</div>

<div class="container">
<div class="main">
		<h2>View a HW</h2><hr/>
		<form name="viewhw" action="selectquestions">
		<sql:query dataSource="${courses}" var="result">
		Select * from exercises where token='<%=token%>';
		</sql:query>
				<table border="0" width="500px">
				<tr>
					<th>Exercises:</th>
				</tr>
				<c:forEach var="row" items="${result.rows}">
					<tr>
						<td align="center">
						<input type="radio" value="${row.exerciseid}" name="radioexercise"><c:out value="${row.exerciseid}"/></td>
					</tr>
				</c:forEach>
				</table>
				<input type="hidden" name="valueconfirm" value=""/>
<input type="submit" value="View a homework" onclick="return validateViewHW()">
</form>
</div>
</div>
		
<div class="container">
<div class="main"><!-- View the class roll and HW attempts and grades of all students.-->
<h2>View the class roll and HW attempts and grades of all students</h2><hr/>
<button onclick="window.location.href='/Gradiance/viewReport.jsp'">Click to view report</button>
</div>
</div>
</div>
</center>
</body>
</html>