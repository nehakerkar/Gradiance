<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="Style.css"/>
<title>Add new homework</title>
<script>
function hide()
{
	document.selectquestions.topics.selectedIndex=0;
	document.getElementById("tabloid").innerHTML=" ";
	document.getElementById("parameters").style.display="none";
	document.getElementById("addqt").style.display="none";
	document.getElementById("bonusaddedtext").style.display="none";
	document.getElementById("bonusparam").style.display="none";
}

function applyFilters()
{
	var topics = document.selectquestions.topics.value;
	var start_exer_diff_level = document.selectquestions.start_exer_diff_level.value;
	var end_exer_diff_level = document.selectquestions.end_exer_diff_level.value;
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
	    {
	    document.getElementById("tabloid").innerHTML=xmlhttp.responseText;
	    if(xmlhttp.responseText=="")
	    	document.getElementById("addqt").style.display="none";
	    else
	    	document.getElementById("addqt").style.display="inline";
	    }
	  }
	xmlhttp.open("POST","selectquestions?topics="+topics+"&start_exer_diff_level="+start_exer_diff_level+"&end_exer_diff_level="+end_exer_diff_level,true);
	xmlhttp.send();
	
}

function showParameters()
{
	var checkboxes = document.getElementsByName("qid");
    var formValid = false;

    var i = 0;
    while (!formValid && i < checkboxes.length) {
        if (checkboxes[i].checked) formValid = true;
        i++;        
    }

    if (!formValid) 
    	{
    	alert("Please select a question.");
    	return false;
    	}
    	else
	document.getElementById("parameters").style.display="inline";
    return true;
}

function validatehw()
{
	if(document.selectquestions.estartdate.value==null||document.selectquestions.estartdate.value==""||document.selectquestions.estartdate.value==" ") {
		alert("Enter a start date.");
		return false;
	}
	if(document.selectquestions.eenddate.value==null||document.selectquestions.eenddate.value==""||document.selectquestions.eenddate.value==" ") {
		alert("Enter an end date.");
		return false;
	}
	if((new Date(document.selectquestions.estartdate.value)) > (new Date(document.selectquestions.eenddate.value)))
	{
		alert("Enter start date less than end date.");
		return false;
	}
	if(document.selectquestions.max_retry_count.value==null||document.selectquestions.max_retry_count.value==""||document.selectquestions.max_retry_count.value==" "||document.selectquestions.max_retry_count.value==0) {
		alert("Enter maximum retry count.");
		return false;
	}
	if(document.selectquestions.points_per_question.value==null||document.selectquestions.points_per_question.value==""||document.selectquestions.points_per_question.value==" ") {
		alert("Enter points per correct answer..");
		return false;
	}
	if(document.selectquestions.negative_points.value==null||document.selectquestions.negative_points.value==""||document.selectquestions.negative_points.value==" ") {
		alert("Enter negative points per incorrect answer");
		return false;
	}
	if(document.selectquestions.scoretype.selectedIndex==0) {
		alert("Select a score type.");
		return false;
	}
	var checkboxes = document.getElementsByName("qid");
    var formValid = false;

    var i = 0;
    while (!formValid && i < checkboxes.length) {
        if (checkboxes[i].checked) formValid = true;
        i++;        
    }

    if (!formValid) alert("Please select a question.");
    return formValid;
}
function showBonus()
{
	if(document.selectquestions.bonuscheck.checked==true)
		{
		document.getElementById("bonusparam").style.display="inline";
		}
	else
		{
		document.getElementById("bonusparam").style.display="none";
		}
}
function validatebonus()
{
	if(document.selectquestions.bcount.value=="" || document.selectquestions.bcount.value==" "||document.selectquestions.bcount.value==null||document.selectquestions.bpoint.value==""||document.selectquestions.bpoint.value==" "||document.selectquestions.bpoint.value==null)
		alert("Please enter both values.");
	else
		document.getElementById("bonusaddedtext").style.display="inline";
}
</script>
</head>
<body onload="hide()">

<% String userid= (String)session.getAttribute("userid");if (userid==null) response.sendRedirect("index.jsp"); %>
<% String token= (String)session.getAttribute("token"); %>
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
	<form name="selectquestions" method="get" action="selectquestions">
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
	<input id="addqt" type="button" value="Add questions" onclick="return showParameters()">
	
	<hr>
	<div id="parameters">
	Enter start date in yyyy-mm-dd format : <input type="text" name="estartdate"><br>
	Enter end date in yyyy-mm-dd format : <input type="text" name="eenddate"><br>
	Enter maximum retry count : <input type="text" name="max_retry_count"><br>
	Enter points per correct answer : <input type="text" name="points_per_question"><br>
	Enter negative points per wrong answer : <input type="text" name="negative_points"><br>
	Score type: <select name="scoretype">
		<option selected="selected">Select
		<sql:query dataSource="${courses}" var="result">
		Select * from scoretype;
		</sql:query>
			<c:forEach var="row" items="${result.rows}">
			<option value="${row.scoretypeid}"><c:out value="${row.scoringtype}" />
			</c:forEach>
	</select>	
	</div><br>
	Do you wish to give bonus points to first few students scoring full marks on first attempt?<input type="checkbox" name="bonuscheck" onchange="showBonus()"/><br>
	<div id="bonusparam">
	Enter first 'x' number of students:<input type="text" name="bcount"/><br>
	Bonus points: <input type="text" name="bpoint"/><br>
	<input type="button" value="Add to exercise" onclick="validatebonus()"/><p id="bonusaddedtext"><b>Added!</b></p>
	</div>
	<br>
		<input type="hidden" name="valueconfirm" value=""/>
	<input type="submit" value="Add homework" onclick="return validatehw()">
	</form>
</div>
</div>
</center>
</body>
</html>