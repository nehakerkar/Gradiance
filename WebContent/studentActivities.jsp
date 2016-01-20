<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="Style.css"/>
<title>Student Activities</title>
<script type="text/javascript">
function hide()
{
	document.getElementById("TAtext").style.display="none";
}
function TAValidate()
{
	if (document.addTA.TAid.value==""||document.addTA.TAid.value==" "||document.addTA.TAid.value==null)
	{
		document.getElementById("TAtext").style.display="inline";
		return false;
	}
	return true;
}
</script>
</head>
<body onload="hide()">
<center>
<% String token = (String)session.getAttribute("token"); %>
<div class="content">
		<div class="container">
			<div class="main">
<form name="addTA" method="post" action="addTA">
Enter TA id:<input type="text" name="TAid" maxlength="20">
<input type="submit" value="Submit" onclick="return TAValidate()"/>
<br/><p id="TAtext">Please enter a student id.</p>
</form>
</div>
</div>
</div>
</center>
</body>
</html>