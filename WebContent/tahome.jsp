<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="Style.css"/>
		<title>Teaching Assistant Home</title>
	</head>
	<script>
	function hide()
	{
		document.getElementById("coursetokentext").style.display="none";
		document.getElementById("remcoursetokentext").style.display="none";
	}
	function validateform()
	{
		var formValid = false;
		if (document.courseselection.coursetoken.value==""||document.courseselection.coursetoken.value==" "||document.courseselection.coursetoken.value==null)
		{
			//document.getElementById("coursetokentext").style.display="inline";
			alert("Please enter a course name.")
			return formValid;
		}
		formValid=true;
		return formValid;
	}
	function remvalidateform()
	{
		var formValid = false;
		if (document.courseremoval.remcoursetoken.value==""||document.courseremoval.remcoursetoken.value==" "||document.courseremoval.remcoursetoken.value==null)
		{
			//document.getElementById("coursetokentext").style.display="inline";
			alert("Please enter a course name.")
			return formValid;
		}
		formValid=true;
		return formValid;
	}
	function selectvalidate()
	{
		document.getElementById("coursetokentext").style.display="none";
		document.getElementById("remcoursetokentext").style.display="none";
		var radios = document.getElementsByName("radiotoken");
		var formValid = false;

		var i = 0;
		while (!formValid && i < radios.length) {
			if (radios[i].checked) formValid = true;
			i++;		
		}

		if (!formValid) alert("Please select a course.");
		return formValid;
	}
	</script>
	<body onload=hide()>
		<%!
		String getDate()
		{
			java.util.Date theDate = new java.util.Date();
			String newstring = new java.text.SimpleDateFormat("yyyy-MM-dd").format(theDate);
			return newstring;
		}
		%>
		<center>
		<div class="header-container">
			<div class="header" align="right">
				<form action="userLogout" method="post">
					<input type="submit" name="logout" value="Logout" align="right"/>
				</form>
			</div>
		</div>
			<% String userid= (String)session.getAttribute("userid"); if (userid==null) response.sendRedirect("index.jsp");%>
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
			
			<sql:query dataSource="${courses}" var="result">
		SELECT token from teaching_assistant where userid='<%=userid %>';
		</sql:query>
		<div class="container">
			<div class="main">
			<hr><h2>Courses you are TA for: </h2>
				<table border="0" width="500px">
				<c:forEach var="row" items="${result.rows}">
					<tr>
						<td align="center"><input type="radio" value="${row.token}" name="radiotoken" onclick="window.location.href='/Gradiance/taActivities.jsp?token=${row.token}'"><c:out value="${row.token}"/></td>
					</tr>
				</c:forEach>
				</table>
			</div>
		</div>
		
		<sql:query dataSource="${courses}" var="result">
		SELECT c1.token,c2.coursename from course c1, courselist c2 where c1.token in(Select token from enrollment where userid='<%=userid %>') and c1.courseid=c2.courseid AND courseenddate > '<%= getDate()%>';
		</sql:query>
		<div class="content">
		<div class="container">
			<div class="main">
				<h2>Courses Enrolled</h2><hr/>
				<form name="selectCourseStudent" method="post" action="selectCourseStudent">
 					<c:set var="default1" scope="session" value="default"/>
					<table border="0" width="500px">
					<tr>
						<th>Token</th>
						<th>Course Name</th>
					</tr>
					<c:forEach var="row" items="${result.rows}">
						<tr>
							<td align="center"><input type="radio" value="${row.token}" name="radiotoken" ><c:out value="${row.token}"/></td>
							<td align="center"><c:out value="${row.coursename}"/></td>
						</tr>
					</c:forEach>
					</table><br/>
					<center>
					<input type="submit" value="Select Course" onclick="return selectvalidate(this)"/>
					</center>
				</form>
			</div>
		</div>
		<div class="container">
			<div class="main">
				<form method="post" action="validateCourseTa" name="courseselection" id="courseselection">
					<h2>Course Register</h2><hr/>
					Course Token: <input type="text" id="coursetoken" name="coursetoken"><p id="coursetokentext" color="red"><b>Please enter a course name.</b></p><br>
					<center><input type="submit" id="coursetokenbutton" onclick="return validateform(this)"/></center>
				</form>
			</div>
		</div>
		<div class="container">
			<div class="main">
				<form method="post" action="removeCourseTa" name="courseremoval" id="courseremoval">
					<h2>Course Unregister</h2><hr/>
					Course Token: <input type="text" id="remcoursetoken" name="remcoursetoken"><p id="remcoursetokentext" color="red"><b>Please enter a course name.</b></p><br>
					<center><input type="submit" id="remcoursetokenbutton" onclick="return remvalidateform(this)"/></center>
				</form>
			</div>
		</div>
		</div>
		</center>
	</body>
</html>