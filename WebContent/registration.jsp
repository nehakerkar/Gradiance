<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Gradiance-Registration</title>
		<link rel="stylesheet" href="Style.css"/>
		<script language="javascript">
		function userTypeSelect(){
			if (document.register.usertype.value=="Student") {
				document.getElementById("studylevel").style.display="inline";
			}
			if (document.register.usertype.value=="Professor") {
				hide();
			}
			if (document.register.usertype.value=="Select") {
				hide();
			}
		}
		function hide()
		{
			document.getElementById("studylevel").style.display="none";
		}
		function validate(register) {
			if(document.register.userId.value==null||document.register.userId.value==""||document.register.userId.value==" ") {
				alert("Enter your UserId");
				return false;
			}
			if(document.register.fname.value==null||document.register.fname.value==""||document.register.fname.value==" ") {
				alert("Enter your First Name");
				return false;
			}
			if(document.register.lname.value==null||document.register.lname.value==""||document.register.lname.value==" ") {
				alert("Enter your Last Name");
				return false;
			}
			if(document.register.email.value==null||document.register.email.value==""||document.register.email.value==" ") {
				alert("Enter your Email Id");
				return false;
			}
			if(document.register.passwd1.value==null||document.register.passwd1.value==""||document.register.passwd1.value==" ") {
				alert("Password is Empty");
				return false;
			}
			if(document.register.passwd2.value!=document.register.passwd1.value)
			{
				alert("Confirm Password and Password have Different Values");
				return false;
			}
			if(document.register.usertype.selectedIndex==0)
			{
				alert("Please select your usertype!");
				return false;
			}
			if(document.register.usertype.selectedIndex==1 && document.register.studylevel.selectedIndex==0)
			{
				alert("Please select studylevel!");
				return false;
			}
		}
		</script>
	</head>
	<body onload="hide()">
		<div class="content">
		<form name="register" id="register" action="register" method="post">
			<div class="container">
				<div class="main">
					<h2>User Registration.</h2><hr/>
					User ID : <input type="text" name="userId" size="20"/><br>
					First Name:<input type="text" name="fname" size="20"/><br>
					Last Name:<input type="text" name="lname"  size="20" /><br>
					Email id:<input type="text" name="email" size="20"/><br>
					Password:<input type="Password" name="passwd1" size="20" /><br>
					Confirm Password:<input type="password" name="passwd2" size="20" /><br>
					Select one of the user types:
					<select name="usertype" size="1" onchange="userTypeSelect()">
						<option selected="selected">Select
						<option value="Student">Student
						<option value="Professor">Professor
					</select><br>
					<div id="studylevel">
						<br>
						Select your study level
						<select name="studylevel" size="1">
							<option selected="selected">Select
							<option value="Grad">Grad
							<option value="Undergrad">Undergrad
						</select>
						<br>
					</div>
					<br>
					<input type="submit" value="Submit" onclick="return validate(this)"/></center>
				</div>
			</div>
		</form>
		</div>
	</body>
</html>