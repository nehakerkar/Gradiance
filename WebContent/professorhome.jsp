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
		<title>Professor Home</title>
		<script>
		function hide()
		{
			document.getElementById("coursetokentext").style.display="none";
			document.getElementById("remcoursetokentext").style.display="none";
			document.getElementById("feedback_text_alert").style.display="none";
		}
		function validate()
		{
			if (document.addCourse.token.value==""||document.addCourse.token.value==" "||document.addCourse.token.value==null)
			{
				document.getElementById("remcoursetokentext").style.display="none";
				document.getElementById("coursetokentext").style.display="inline";
				document.getElementById("feedback_text_alert").style.display="none";
				return false;
			}
			return true;
		}
		function remvalidateform()
		{
			if (document.courseremoval.remcoursetoken.value==""||document.courseremoval.remcoursetoken.value==" "||document.courseremoval.remcoursetoken.value==null)
			{
				document.getElementById("coursetokentext").style.display="none";
				document.getElementById("remcoursetokentext").style.display="inline";
				document.getElementById("feedback_text_alert").style.display="none";
				return false;
			}
			return true;
		}
		function feedbackvalidate()
		{
			if (document.feedback.feedback_text.value==""||document.feedback.feedback_text.value==" "||document.feedback.feedback_text.value==null)
			{
				document.getElementById("coursetokentext").style.display="none";
				document.getElementById("remcoursetokentext").style.display="none";
				document.getElementById("feedback_text_alert").style.display="inline";
				return false;
			}
			return true;
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
	</head>
<body onload=hide()>
	<% String userid= (String)session.getAttribute("userid"); if (userid==null) response.sendRedirect("index.jsp");%>
	<% String usertype= (String)session.getAttribute("type_description"); %>
	Welcome <%= usertype%>,
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

		<sql:query dataSource="${courses}" var="result">
		SELECT c1.token,c2.coursename from course c1, courselist c2 where c1.token in(Select token from professor where userid='<%=userid %>' and token<>'Default') and c1.courseid=c2.courseid;
		</sql:query>
		<div class="content">
		<div class="container">
			<div class="main">
			<h2>Your Courses</h2><hr/>
			<form name="selectCourse" method="post" action="selectCourseProfessor">
				<c:set var="default1" scope="session" value="default"/>
				<table border="0" width="500px">
				<tr>
					<th>Token</th>
					<th>Course Name</th>
				</tr>
				<c:forEach var="row" items="${result.rows}">
					<tr>
						<td align="center">
						<input type="radio" value="${row.token}" name="radiotoken"><c:out value="${row.token}"/></a></td>
						<td align="center"><c:out value="${row.coursename}"/></td>
					</tr>
				</c:forEach>
				</table><br/>
				<center><input type="submit" value="Select Course" onclick="return selectvalidate()"/></center>
				</form>
			</div>
		</div>
		<div class="container">
			<div class="main">
				<form name="addCourse" action="validateCourseProfessor" method="post">
				<h2>Course Selection</h2><hr/>
					Enter Token: <input type="text" name="token" maxlength="20"><p id="coursetokentext" color="red"><b>Please enter a course name.</b></p><br>
					<center><input type="submit" value="Add Course" onclick="return validate()"></center>
				</form>
			</div>
		</div>
		<div class="container">
			<div class="main">
				<form method="post" action="removeCourseProfessor" name="courseremoval" id="courseremoval">
					<h2>Course Unregister</h2><hr/>
					Course Token: <input type="text" name="remcoursetoken"><p id="remcoursetokentext" color="red"><b>Please enter a course token.</b></p><br>
					<center><input type="submit" value="Remove Course" onclick="return remvalidateform()"/></center>
				</form>
			</div>
		</div>
		
		<div class="container">
			<div class="main">
				<form method="post" action="addFeedback" name="feedback" id="feedback">
					<h2>Feedback</h2><hr/>
					Enter Feedback: <input type="text" name="feedback_text"><p id="feedback_text_alert"><b> Please enter a feedback.</b></p><br>
					<center><input type="submit" value="Submit Feedback" onclick="return feedbackvalidate()"/></center>
				</form>
			</div>
		</div>
		</div>
		</center>
	</body>
</html>