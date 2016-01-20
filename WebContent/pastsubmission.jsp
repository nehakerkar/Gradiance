<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Past Submission</title>
	</head>
	<body>
		<%
		if ((String)session.getAttribute("userid")==null) response.sendRedirect("index.jsp");
		%>
		<form method="post" action="" name="submission" id="submission">
			<sql:setDataSource var="questions" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/gradiance" user="root"  password=""/>
			<c:set var="userid" scope="session" value="${sessionScope.userid}" />
			<c:set var="pastexerciseid" scope="session" value="${sessionScope.pastexerciseid}" />
			<c:set var="pastattemptnum" scope="session" value="${sessionScope.pastattemptnum}" />
			<sql:query dataSource="${questions}" var="result1">
				SELECT qlist,answerlist FROM submission WHERE userid="${userid}" AND exerciseid="${pastexerciseid}" AND attemptnum="${pastattemptnum}";
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
						<c:forTokens var="token1" items="${row.qlist}" delims=" " varStatus="tokenstat1">
							<c:forTokens var="token2" items="${token1}" delims=":" varStatus="tokenstat2">
								<c:choose>
									<c:when test="${tokenstat2.first}">
										<c:set var="questionid" scope="session" value="${token2}"/>
									</c:when>
									<c:when test="${tokenstat2.last}">
										<c:forTokens var="token3" items="${token2}" delims="," varStatus="tokenstat3">
											<sql:query dataSource="${questions}" var="answerdata">
												SELECT * FROM answers WHERE answerid="${token3}";
											</sql:query>
											<c:forEach var="individualanswer" items="${answerdata.rows}">
												<c:set var="flag" scope="session" value="0"/>
												<c:forTokens var="atoken1" items="${row.answerlist}" delims=" " varStatus="atokenstat1">
													<c:forTokens var="atoken2" items="${atoken1}" delims="," varStatus="atokenstat2">
														<c:if test="${atokenstat2.last}">
															<c:if test="${atoken2==individualanswer.answerid}">
																<c:set var="flag" scope="session" value="1"/>
															</c:if>
														</c:if>
													</c:forTokens>
												</c:forTokens>
												<tr>
												<c:choose>
													<c:when test="${flag==1}">
														<td align="center"><input type ="radio" name="${qno}" value="${token3}" disabled checked/></td>
														<td align="left"><b><c:out value="${individualanswer.answertext}"/></b></td>
														<c:set var="answertype" scope="session" value="${individualanswer.answertype}"/>
														<c:if test="${answertype=='false'}">
														</tr>
														<tr>
														<td colspan="2" align="center"><c:out value="${individualanswer.explanation}"/></td>
														</c:if>
													</c:when>
													<c:otherwise>
														<td align="center"><input type ="radio" name="${qno}" value="${token3}" disabled/></td>
														<td align="left"><c:out value="${individualanswer.answertext}"/></td>
													</c:otherwise>
												</c:choose>
												</tr>
											</c:forEach>
										</c:forTokens>
									</c:when>
									<c:otherwise>
										<c:set var="parameterid" scope="session" value="${token2}"/>
										<sql:query dataSource="${questions}" var="questiondata">
											SELECT * FROM questions WHERE questionid="${questionid}" AND parameterid="${parameterid}";
										</sql:query>
										<c:forEach var="individualquestion" items="${questiondata.rows}">
											<c:set var="qno" scope="session" value="${qno+1}" />
											<c:set var="qhint" scope="session" value="${individualquestion.explanation}" />
											<tr>
											<td align="center"><c:out value="${qno}" /></td>
											<td align="left"><c:out value="${individualquestion.questiontext}"/></td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</c:forTokens>
							<tr>
							<td colspan="2" align="center"><c:out value="${qhint}"/></td>
							</tr>
						</c:forTokens>
					</c:forEach>
				</table><br/>
			</center>
		</form>
		<center><a href='showexercises.jsp' >Back to exercises menu</a></center>
		<hr>
	</body>
</html>