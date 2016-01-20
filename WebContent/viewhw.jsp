<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="Style.css"/>
<title>View homework</title>
</head>
<body onload="hide()">
<% String userid= (String)session.getAttribute("userid");if (userid==null) response.sendRedirect("index.jsp"); %>
<% String token= (String)session.getAttribute("token"); %>
<% String exerciseid = request.getParameter("exerciseid"); %>
<% String td =  (String)session.getAttribute("type_description");%>
<div class="header-container">
	<div class="header">
		<form action="userLogout" method="post" align="right">
			<input type="submit" value="Logout" />
		</form>
		<%if(td.equalsIgnoreCase("professor")){ %>
		<a href="professorhome.jsp" class="back"> Home</a>
		<%} else{ %>
		<a href="tahome.jsp" class="back"> Home</a>
		<%} %>
	</div>
</div>
<center>
<sql:setDataSource var="courses" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost:3306/gradiance"
     user="root"  password=""/>
<div class="content">
<div class="container">
<div class="main">
		<sql:query dataSource="${courses}" var="result">
		Select estartdate,eenddate,max_retry_count,exer_diff_level,points_per_question,negative_points,estartdate,scoringtype,number_qt from exercises e,scoretype s where exerciseid=<%=exerciseid%> and e.scoretypeid=s.scoretypeid;
		</sql:query>
			<c:forEach var="row" items="${result.rows}">
			Start Date: <c:out value="${row.estartdate}" /><br>
			End Date: <c:out value="${row.eenddate}" /><br>
			Maximum retry allowed: <c:out value="${row.max_retry_count}" /><br>
			Difficulty level: <c:out value="${row.exer_diff_level}" /><br>
			Points per correct Answer: <c:out value="${row.points_per_question}" /><br>
			Points per incorrect answer: <c:out value="${row.negative_points}" /><br>
			Scoring type: <c:out value="${row.scoringtype}" /><br>
			Number of questions: <c:out value="${row.number_qt}"></c:out><br>
			<sql:query dataSource="${courses}" var="result1">
		Select topicname from topics where topicid=(Select topicid from exercises where exerciseid=<%=exerciseid%>);
		</sql:query>
			<c:forEach var="row1" items="${result1.rows}">
			Topic name : <c:out value="${row1.topicname}"></c:out>
			</c:forEach>
			</c:forEach>
			<hr>

<sql:query dataSource="${courses}" var="result1">
Select * from questions where questionid IN (Select questionid from exercises_questions where exerciseid=<%=exerciseid%>) group by questionid;
</sql:query>
 <center>
 <c:set var="qno" scope="session" value="0" />
<table border="1" width="100%">
<tr>
   <th width="30px">Q.No.</th>
   <th>Question</th>
</tr>
<c:forEach var="row" items="${result1.rows}">
 <c:set var="qno" scope="session" value="${qno+1}" />
<tr>
   <td align="center"><c:out value="${qno}" /></td>
   <td align="left"><c:out value="${row.questiontext}"/></td>
</tr>

<sql:query dataSource="${courses}" var="result2">
Select * from answers where questionid = "${row.questionid}";
</sql:query>
<tr>
      <th width="40 px">Answer Value</th>
   	  <th>Answer</th>
      <th width="30 px">P Id</th>
</tr>
<c:forEach var="row2" items="${result2.rows}">
<tr>
   <td align="center"><c:out value="${row2.answertype}"/></td>
   <td align="center"><c:out value="${row2.answertext}"/></td>
   <td align="center"><c:out value="${row2.parameterid}"/></td>
</tr>
</c:forEach>
<tr><td></td><td></td><td></td></tr>
</c:forEach>
</table>	
</div>
</div>
</div>
</center>
</body>
</html>