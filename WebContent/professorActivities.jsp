<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="Style.css"/>
<title>Professor Activities</title>
<script type="text/javascript">
function hide()
{
	document.getElementById("TAtext").style.display="none";
	document.getElementById("remTAtext").style.display="none";
}
function TAValidate()
{
	if (document.addTA.TAid.value==""||document.addTA.TAid.value==" "||document.addTA.TAid.value==null)
	{
		document.getElementById("remTAtext").style.display="none";
		document.getElementById("TAtext").style.display="inline";
		return false;
	}
}
function remValidate()
{
if (document.remTA.TAid.value==""||document.remTA.TAid.value==" "||document.remTA.TAid.value==null)
	{
		document.getElementById("TAtext").style.display="none";
		document.getElementById("remTAtext").style.display="inline";
		return false;
	}
	return true;
}
function validateDeleteHW()
{
	document.deletehw.valueconfirm.value="";
	var checkboxes = document.getElementsByName("radioexercise");
    var formValid = false;
	var i = 0;
    while (!formValid && i < checkboxes.length) {
        if (checkboxes[i].checked) formValid = true;
        i++;        
    }

    if (!formValid) 
    	alert("Please select a homework to delete.");
    else
    	document.deletehw.valueconfirm.value="delete";
    return formValid;
}
function validateViewHW()
{
	document.deletehw.valueconfirm.value="";
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
    	document.deletehw.valueconfirm.value="view";
    return formValid;
}
function validateEditHW()
{
	var checkboxes = document.getElementsByName("radioexercise");
    var formValid = false;
	var i = 0;
    while (!formValid && i < checkboxes.length) {
        if (checkboxes[i].checked) 
        	{
        	formValid = true;
        	break;
        	}
        i++;        
    }
    if (!formValid) 
    	alert("Please select a homework to edit.");
    else
    	window.location="/Gradiance/editHW.jsp?exerciseid="+checkboxes[i].value;
    return formValid;
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
		<sql:query dataSource="${courses}" var="result">
		SELECT userid from teaching_assistant where token='<%=token %>';
		</sql:query>
		<div class="container">
			<div class="main">
			<h2>TAs for course <%=token %></h2><hr/>
				<table border="0" width="500px">
				<tr>
					<th>TA Id:</th>
				</tr>
				<c:forEach var="row" items="${result.rows}">
					<tr>
						<td align="center"><c:out value="${row.userid}"/></td>
					</tr>
				</c:forEach>
				</table>
			</div>
		</div>
		
<div class="container">
<div class="main">
		<h2>Add a TA</h2><hr/>
<form name="addTA" method="post" action="addTA">
Enter TA id:<input type="text" name="TAid" maxlength="20">
<input type="submit" value="Add TA" onclick="return TAValidate()"/>
<br/><p id="TAtext">Please enter a student id.</p>
</form>
</div>
</div>

<div class="container">
<div class="main">
<h2>Remove a TA</h2><hr/>
<form name="remTA" method="post" action="remTA">
Enter TA id:<input type="text" name="TAid" maxlength="20">
<input type="submit" value="Remove TA" onclick="return remValidate()"/>
<br/><p id="remTAtext">Please enter a student id.</p>
</form>
</div>
</div>

<div class="container">
<div class="main"><!-- View the class roll and HW attempts and grades of all students.-->
<h2>View the class roll and HW attempts and grades of all students</h2><hr/>
<button onclick="window.location.href='/Gradiance/viewReport.jsp'">Click to view report</button>
</div>
</div>

<div class="container">
<div class="main">
		<h2>Add or Modify a HW</h2><hr/>
		<form name="deletehw" action="selectquestions">
		<sql:query dataSource="${courses}" var="result">
		Select * from exercises where token='<%=token%>' and userid='<%=userid %>'
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
<input type="submit" value="Delete a homework" onclick="return validateDeleteHW()">
<input type="button" value="Edit a homework" onclick="return validateEditHW()" class="modifyhw">
</form>
<button onclick="window.location.href='/Gradiance/searchquestions.jsp'">Add a homework</button>
</div>
</div>

<div class="container">
<div class="main">
		<h2>Top 5 difficult questions</h2><hr/>
		<sql:query dataSource="${courses}" var="result">
		Select t.qid,qcount,questiontext from topq t, questions q where t.qid=q.questionid and t.qid in (select distinct questionid from questions where topicid in(select topicid from topic_courselist where courseid in(select courseid from course where token='<%=token%>'))) group by t.qid order by qcount DESC LIMIT 5;
		</sql:query>
				<table border="0" width="1000px">
				<tr>
					<th width="100 px">Question Id</th>
					<th width="800 px">Question</th>
					<th width="100 px">Wrong Counter</th>
				</tr>
				<c:forEach var="row" items="${result.rows}">
					<tr>
						<td align="center"><c:out value="${row.qid}"/></td>
						<td align="center"><c:out value="${row.questiontext}"/></td>
						<td align="center"><c:out value="${row.qcount}"/></td>
					</tr>
				</c:forEach>
				</table>
</div>
</div>
</center>
</body>
</html>