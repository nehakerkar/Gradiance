<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="Style.css"/>
		<title>GRADIANCE LOGIN</title>
		<script type="text/javascript">
			function hide()
			{
				document.getElementById("usertext").style.display="none";
				document.getElementById("pwdtxt").style.display="none";
			}
			function validate(validatelogin)
			{
				document.getElementById("usertext").style.display="none";
				document.getElementById("pwdtxt").style.display="none";
				if(document.login.userid.value==null||document.login.userid.value==""||document.login.userid.value==" ")
				{
					document.getElementById("usertext").style.display="inline";
					return false;
				}
				if(document.login.password.value==null||document.login.password.value==""||document.login.password.value==" ")
				{
					document.getElementById("pwdtxt").style.display="inline";
					return false;
				}
				return true;
			}
		</script>
	</head>
	<body onload="hide()">
	<center>
		<form method="post" action="validatelogin" name="login" id="login">
			<div class="container">
				<div class="main">
					<h2>Gradiance Login</h2><hr/>
					User ID: <input type="text" name="userid"><note id="usertext"><b>Please enter a user name.</b></note><br>
					Password:<input type="password" name="password" size="20" maxlength="20" /><note id="pwdtxt"><b>Please enter a password.</b></note><br>
					<center><input type="submit" value="Submit" onclick="return validate(this)"/></center><br>
					<p>Not a member yet? Register <a href="registration.jsp">here</a></p>
				</div>
			</div>
		</form>
	</center>
	</body>
</html>