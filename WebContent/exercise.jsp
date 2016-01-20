<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Exercise</title>
	</head>
	<body>
		<%
		if ((String)session.getAttribute("userid")==null) response.sendRedirect("index.jsp");
		%>
		<form method="post" action="exercise" name="submission" id="submission">
			<sql:setDataSource var="questions" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/gradiance" user="root"  password=""/>
			<c:set var="eid" scope="session" value="${sessionScope.exerciseid}" />
			<sql:query dataSource="${questions}" var="result1">
				Select questionid from exercises_questions where exerciseid="${eid}" ORDER BY RAND();
			</sql:query>
			<center>
				<c:set var="qno" scope="session" value="0" />
				<c:set var="qlist" scope="session" value="" />
				<table border="1" width="80%">
					<tr>
					<th>Q.No.</th>
					<th>Question</th>
					</tr>
					<c:forEach var="row" items="${result1.rows}" varStatus="rowstat">
						<c:set var="qno" scope="session" value="${qno+1}" />
						<tr>
							<sql:query dataSource="${questions}" var="questiondata">
								SELECT * FROM questions WHERE questionid=${row.questionid} ORDER BY RAND() LIMIT 1;
							</sql:query>
							<c:forEach var="individualquestion" items="${questiondata.rows}">
								<td align="center"><c:out value="${qno}" /></td>
								<td align="left"><c:out value="${individualquestion.questiontext}"/></td>
								<c:set var="qlist" value="${qlist}${rowstat.first ? '' : ' '}${individualquestion.questionid}:${individualquestion.parameterid}:" />
								</tr>
								<sql:update dataSource="${questions}" var="viewcreate">
									CREATE OR REPLACE VIEW answerlist AS (SELECT * FROM answers WHERE questionid="${individualquestion.questionid}" AND parameterid="${individualquestion.parameterid}" AND answertype='true' ORDER BY RAND() LIMIT 1) UNION (SELECT * FROM answers WHERE questionid="${individualquestion.questionid}" AND parameterid="${individualquestion.parameterid}" AND answertype='false' ORDER BY RAND() LIMIT 3);
								</sql:update>
								<sql:query dataSource="${questions}" var="result2">
									SELECT answerid, answertext FROM answerlist ORDER BY RAND();
								</sql:query>
								<c:forEach var="row2" items="${result2.rows}" varStatus="row2stat">
								<tr>
									<c:set var="qlist" value="${qlist}${row2stat.first ? '' : ','}${row2.answerid}" />
									<td align="center"><input type ="radio" name="${qno}" value="${individualquestion.questionid},${individualquestion.parameterid},${row2.answerid}"/></td>
									<td align="left"><c:out value="${row2.answertext}"/></td>
								</tr>
								</c:forEach>
							</c:forEach>
					</c:forEach>
				</table><br/>
				<input type="hidden" id="thisField" name="finalqc" value="${qno}">
				<input type="hidden" id="thisField" name="questionlist" value="${qlist}">
				<input type="submit" value="Submit Answers" onclick="return validate(this)">
			</center>
		</form>
		<hr>
	</body>
</html>