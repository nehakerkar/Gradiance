<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="Style.css"/>
		<title>Assignments/Exercises</title>
	</head>
	<script>
	function tokenvalidate () {
		var radios = document.getElementsByName("eid");
		var formValid = false;

		var i = 0;
		while (!formValid && i < radios.length) {
			if (radios[i].checked) formValid = true;
			i++;		
		}

		if (!formValid) alert("Please select an Exercise.");
		return formValid;
	}
	function pastvalidate () {
		var radios = document.getElementsByName("submissioneid");
		var formValid = false;

		var i = 0;
		while (!formValid && i < radios.length) {
			if (radios[i].checked) formValid = true;
			i++;		
		}

		if (!formValid) alert("Please select a Submission.");
		return formValid;
	}
	</script>
	<body>
		<%
		if ((String)session.getAttribute("userid")==null) response.sendRedirect("index.jsp");
		%>
		<div class="header-container">
			<div class="header" align="right">
				<form action="userLogout" method="post">
					<input type="submit" name="logout" value="Logout" align="right"/>
				</form>
			</div>
		</div>
		<div class="content">
		<form method="post" action="showexercises" name="selectE" id="selectE">
			<sql:setDataSource var="exercises" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/gradiance" user="root"  password=""/>
			<c:set var="uid" scope="session" value="${sessionScope.userid}" />
			<jsp:useBean id="current" class="java.util.Date" />
			<%!
			String getDate()
			{
				java.util.Date theDate = new java.util.Date();
				String newstring = new java.text.SimpleDateFormat("yyyy-MM-dd").format(theDate);
				return newstring;
			}
			%>
			<sql:query dataSource="${exercises}" var="result1">
				Select * from exercises where token IN (SELECT token FROM enrollment WHERE userid="${uid}" AND token='<c:out value="${sessionScope.token}"></c:out>') AND eenddate >= '<%= getDate()%>' AND estartdate <= '<%= getDate()%>';
			</sql:query>
			<center>
			<div class="container">
				<div class="main">
				<h2>Open Assignments/Exercises</h2><hr/>
				<table border="0" width="500px">
					<tr>
						<th>Select</th>
						<th>Course Token</th>
						<th>Assignment/Exercise</th>
					</tr>
					<c:forEach var="row" items="${result1.rows}">
						<tr>
							<td align="center"><input type ="radio" id="eid" name="eid" value="${row.exerciseid}"/></td>
							<td align="center"><c:out value="${row.token}" /></td>
							<td align="center"><c:out value="${row.exerciseid}"/></td>
						</tr>
					</c:forEach>
				</table><br/>
				<input type="submit" value="Attempt" onclick="return tokenvalidate(this)"></center>
				</div>
			</div>
		</form>
		<form method="post" action="pastsubmission" name="selectsubmission" id="selectsubmission">
			<div class="container">
				<div class="main">
				<h2>Previous Submissions</h2><hr/>
				<sql:query dataSource="${exercises}" var="result2">
					Select * from submission where userid="${uid}" AND exerciseid IN (Select exerciseid from exercises where token='<c:out value="${sessionScope.token}"></c:out>');
				</sql:query>
				<center>
				<table border="0" width="500px">
					<tr>
						<th>Select</th>
						<th>Assignment/Exercise</th>
						<th>Attempt No</th>
						<th>Score</th>
					</tr>
					<c:forEach var="row2" items="${result2.rows}">
						<tr>
							<td align="center"><input type ="radio" id="submissioneid" name="submissioneid" value="${row2.exerciseid},${row2.attemptnum}"/></td>
							<td align="center"><c:out value="${row2.exerciseid}" /></td>
							<td align="center"><c:out value="${row2.attemptnum}" /></td>
							<td align="center"><c:out value="${row2.score}"/></td>
						</tr>
					</c:forEach>
				</table><br/>
				<input type="submit" value="View" onclick="return pastvalidate(this)"></center>
				</div>
			</div>
		</form>
		</div>
	</body>
</html>