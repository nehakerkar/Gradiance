<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% String token= (String)session.getAttribute("token"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Class Information</title>
<link rel="stylesheet" href="Style.css"/>
<script type="text/javascript">
function showReport()
{
	if(document.selectuser.userid.selectedIndex==0)
		{
			document.getElementById("tabloid").innerHTML="";
		}
	else
		{
	var token = "<%=token%>";
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
	    }
	  }
	xmlhttp.open("POST","viewReport?userid="+document.selectuser.userid.value+"&token="+token,true);
	xmlhttp.send();
		}
}
function hide()
{
	document.getElementById("tabloid").innerHTML=" ";
}
</script>
</head>
<body onload="hide()">
<% String userid= (String)session.getAttribute("userid");if (userid==null) response.sendRedirect("index.jsp"); %>
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
SELECT COUNT(*) AS CLASS_ROLL FROM enrollment WHERE token='<%=token%>';
</sql:query>
<c:forEach var="row" items="${result.rows}">
	Number of enrolled students: <c:out value="${row.CLASS_ROLL}" />
</c:forEach>
<br>
<form name="selectuser">
<sql:query dataSource="${courses}" var="result">
SELECT userid FROM enrollment WHERE token='<%=token%>';
</sql:query>
<select name="userid" onchange="showReport()">
<option selected="selected">Select
<c:forEach var="row" items="${result.rows}">
<option value="${row.userid}"><c:out value="${row.userid}" />
</c:forEach>
</select>
</form>

<table id="tabloid">
</table>
</div>
</div>
</div>
</center>
</body>
</html>