<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="Style.css"/>
<title>Insert title here</title>
<script>
function validate(addNewCourse)
{
	
	if (document.addNewCourse.token.value==""||document.addNewCourse.token.value==" "||document.addNewCourse.token.value==null)
	{
		alert("Please enter a token.");
		return false;
	}
	if(document.addNewCourse.courseid.selectedIndex==0)
	{
		alert("Please select Course Id.");
		return false;
	}
	if(document.addNewCourse.semester.selectedIndex==0)
	{
		alert("Please select semester.");
		return false;
	}
	if (document.addNewCourse.coursestartdate.value==""||document.addNewCourse.coursestartdate.value==" "||document.addNewCourse.coursestartdate.value==null)
	{
		alert("Please enter a course start date.");
		return false;
	}
	if (document.addNewCourse.courseenddate.value==""||document.addNewCourse.courseenddate.value==" "||document.addNewCourse.courseenddate.value==null)
	{
		alert("Please enter a course end date.");
		return false;
	}
	if((new Date())>(new Date(document.addNewCourse.courseenddate.value)))
		{
			alert("Please enter end date greater than start date.");
			return false;
		}
	if (document.addNewCourse.maxenrolled.value==""||document.addNewCourse.maxenrolled.value==" "||document.addNewCourse.maxenrolled.value==null)
	{
		alert("Please enter maximum number of students that can be enrolled in the course");
		return false;
	}
	if(document.addNewCourse.courselevel.selectedIndex==0)
	{
		alert("Please select courselevel.");
		return false;
	}
	return true;
}
</script>
</head>
<body>
<center>
<sql:setDataSource var="courses" driver="com.mysql.jdbc.Driver"
		     url="jdbc:mysql://localhost:3306/gradiance"
		     user="root"  password=""/>
		     
<sql:query dataSource="${courses}" var="result">
		Select * from courselist;
		</sql:query>		     
<form name="addNewCourse" action="addNewCourse" method="post">
	<div class="container">
		<div class="main">
				<h2>Add new Course</h2><hr/>
				Token : <input type="text" name="token" size="20"/><br>
				Course Id:<select name="courseid" size="1" onchange="courseidSelect()">
					<option selected="selected">Select</option>
					<c:forEach var="row" items="${result.rows}">
					<option value="${row.courseid}"><c:out value="${row.courseid}"/></option><c:out value="${row.courseid}"/>
					</c:forEach>
				</select><br>
				Semester:
				<select name="semester" size="1">
					<option selected="selected">Select
					<option value="Fall">Fall
					<option value="Spring">Spring
				</select><br>
				Course Start Date (yyyy-mm-dd):<input type="text" name="coursestartdate" size="20"/><br>
				Course End Date (yyyy-mm-dd):<input type="text" name="courseenddate" size="20" /><br>
				Maximum Students Enrolled:<input type="text" name="maxenrolled" size="20" /><br>
				Course Level:
				<select name="courselevel" size="1">
					<option selected="selected">Select
					<option value="Grad">Grad
					<option value="Undergrad">Undergrad
				</select><br>
				<input type="submit" value="Submit" onclick="return validate(this)"/>
		</div>
	</div>
</form>
</center>
</body>
</html>