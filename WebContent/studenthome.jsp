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
		<title>Student Home</title>
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
		formvalid = true;
		return formvalid;
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
		formvalid = true;
		return formvalid;
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
		<%
		if ((String)session.getAttribute("userid")==null) response.sendRedirect("index.jsp");
		%>
		<%!
		String getDate()
		{
			java.util.Date theDate = new java.util.Date();
			String newstring = new java.text.SimpleDateFormat("yyyy-MM-dd").format(theDate);
			return newstring;
		}
		%>
		<div class="header-container">
			<div class="header" align="right">
				<form action="userLogout" method="post">
					<input type="submit" name="logout" value="Logout" align="right"/>
				</form>
			</div>
		</div>
		<% String userid= (String)session.getAttribute("userid"); %>
		<sql:setDataSource var="courses" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/gradiance"
		user="root"  password=""/>
		<sql:query dataSource="${courses}" var="result">
		SELECT c1.token,c2.coursename from course c1, courselist c2 where c1.token in(Select token from enrollment where userid='<%=userid %>') and c1.courseid=c2.courseid AND courseenddate > '<%= getDate()%>';
		</sql:query>
		<div class="content">
		<center>
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
							<td align="center"><input type="radio" value="${row.token}" name="radiotoken"><c:out value="${row.token}"/></a></td>
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
				<form method="post" action="validateCourseStudent" name="courseselection" id="courseselection">
					<h2>Course Selection</h2><hr/>
					Course Token: <input type="text" id="coursetoken" name="coursetoken"><p id="coursetokentext" color="red"><b>Please enter a course name.</b></p><br>
					<center><input type="submit" id="coursetokenbutton" onclick="return validateform(this)"/></center>
				</form>
			</div>
		</div>
		<div class="container">
			<div class="main">
				<form method="post" action="removeCourseStudent" name="courseremoval" id="courseremoval">
					<h2>Course Unregister</h2><hr/>
					Course Token: <input type="text" id="remcoursetoken" name="remcoursetoken"><p id="remcoursetokentext" color="red"><b>Please enter a course name.</b></p><br>
					<center><input type="submit" id="remcoursetokenbutton" onclick="return remvalidateform(this)"/></center>
				</form>
			</div>
		</div>
		</center>
		</div>
	</body>
</html>