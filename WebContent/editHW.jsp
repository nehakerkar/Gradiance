<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="Style.css"/>
<title>Edit Homework</title>
<script>
function hide()
{
	document.getElementById("tabloid").innerHTML=" ";
}

function applyFilters()
{
	var topics = document.editHW.topics.value;
	var start_exer_diff_level = document.editHW.start_exer_diff_level.value;
	var end_exer_diff_level = document.editHW.end_exer_diff_level.value;
	if(start_exer_diff_level>end_exer_diff_level)
		{
			alert("Enter end difficulty level > start difficulty level.");
			return false;
		}
	var xmlhttp;
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    document.getElementById("tabloid").innerHTML=xmlhttp.responseText;
	  }
	xmlhttp.open("POST","selectquestions?topics="+topics+"&start_exer_diff_level="+start_exer_diff_level+"&end_exer_diff_level="+end_exer_diff_level,true);
	xmlhttp.send();
}
</script>
</head>
<body>
<body onload="hide()">

<% String userid= (String)session.getAttribute("userid");if (userid==null) response.sendRedirect("index.jsp"); %>
<% String token= (String)session.getAttribute("token"); %>
<% String exerciseid=request.getParameter("exerciseid"); %>
<div class="header-container">
	<div class="header">
		<form action="userLogout" method="post" align="right">
			<input type="submit" value="Logout" />
		</form>
		<a href="professorhome.jsp" class="back"> Home</a>
	</div>
</div>
<center>
<sql:setDataSource var="courses" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost:3306/gradiance"
     user="root"  password=""/>
<div class="container">
<div class="main">
		<h2>Select Questions</h2><hr/>
	<form name="editHW" method="post" action="editHW">
	<input type="hidden" value="<%=exerciseid%>" name="exerciseid"/>
	Enter Difficulty level range: 
	<select name="start_exer_diff_level">
		<sql:query dataSource="${courses}" var="result">
		Select * from difficultylevel;
		</sql:query>
			<c:forEach var="row" items="${result.rows}">
			<option value="${row.q_diff_level_id}"><c:out value="${row.q_diff_level}" />
			</c:forEach>
	</select> to 
	<select name="end_exer_diff_level">
		<sql:query dataSource="${courses}" var="result">
		Select * from difficultylevel;
		</sql:query>
			<c:forEach var="row" items="${result.rows}">
			<option value="${row.q_diff_level_id}"><c:out value="${row.q_diff_level}" />
			</c:forEach>
	</select>
	<br><br>
	Select topic: <select name="topics">
		<sql:query dataSource="${courses}" var="result">
		SELECT * from topics where topicid in (select topicid from topic_courselist where courseid =(select courseid from course where token = '<%=token %>'));
		</sql:query>
			<c:forEach var="row" items="${result.rows}">
			<option value="${row.topicid}"><c:out value="${row.topicname}" />
			</c:forEach>
	</select>
	<br>
	<input type="button" value="search" id="search" onclick="applyFilters()">
	<input type="button" value="reset" onclick="hide()" />
	<br>
	<table id="tabloid">
	</table>
	<hr>Previous selected questions:<hr>
	<table>
	<sql:query dataSource="${courses}" var="result">
		SELECT questionid,questiontext from questions where questionid in (select questionid from exercises_questions where exerciseid ='<%=exerciseid %>') group by questionid;
	</sql:query>
			<c:forEach var="row" items="${result.rows}">
			<tr><td align="center"><input type="checkbox" name="qid1" value="${row.questionid}"></td><td><c:out value="${row.questiontext}" /></td></tr>
			</c:forEach>
	</table>
	
	<input type=submit value="Edit Homework">
	</form>
	</div>
	</div>
</center>
</body>
</html>