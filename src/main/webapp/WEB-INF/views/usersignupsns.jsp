<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TimeWizard</title>
<link rel="stylesheet" type="text/css" href="/timewizard/css/signup.css">
</head>
<body>
	<div class="overlaybox">
		<div class="overlay">
			<div class="sign-up" id="sign-up-info">
				<div class="title"><h1>Create Account</h1></div>
				<p class="small"> check your information:
				<div id="sign-up-form">
					<form id="sign-up-form" action="signupresult" method="post">
						<input type="hidden" name="user_id" value="${snsinfo.user_id}" />
						<input type="hidden" name="user_pw" value="${snsinfo.user_pw}" />
						<input type="email" placeholder="Email" name="user_email" value="${snsinfo.user_email}" required="required" />
						<input type="text" placeholder="Name" name="user_name" value="${snsinfo.user_name}" required="required" />
					</form>
				</div>
				<div class="signbox">
					<div class="buttons__div">
						<input type="submit" class="control-button up" form="sign-up-form" value="Sign Up" />
						<button class="control-button cancel" onclick="location.href='./loginform'">Cancel</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>