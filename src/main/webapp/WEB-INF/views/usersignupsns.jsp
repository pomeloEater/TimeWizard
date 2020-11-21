<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TimeWizard</title>
<!-- <link rel="stylesheet" type="text/css" href="/timewizard/css/signup.css"> -->
<style type="text/css">
:root{
  --form-height:550px;
  --form-width: 900px;
  /*  Sea Green */
  --left-color: #9fdeaf;
  /*  Light Blue  */
  --right-color: #96dbe2;
  --text-color: #f0f4f5;
  --background-color: #263343;
	--accent-color: #ff6b6b;
	--color: #E0E0E0;
}

body, html{
  margin: 0;
  font-family: 'Helvetica Neue', sans-serif;
  letter-spacing: 0.5px;
  background-color: #263343;
}

a {
	text-decoration: none;
	color: inherit;
}


/* * * * * * * * * *  
 *    overlay      *
 * * * * * * * * * */

.overlaybox {
	display: flex;
	justify-content: center;
	width: 100%;
	height: 90vh;
}
.overlay {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 7%;
	width: 30%;
	background-color: white;
	border-radius: 10px;
}

.overlay .sign-up{
  /*  Width is 385px - padding  */
  --padding: 50px;
  width: calc(385px - var(--padding) * 2);
  height: 100%;
  display: flex;
  justify-content: center;
  flex-direction: column;
  align-items: center;
  padding: 0px var(--padding);
  text-align: center;
}

.overlay h1{
  margin: 0px 5px;
  font-size: 2.1rem;
  color: var(--dark-color);
}

.overlay p{
  margin: 20px 0px 30px;
  font-weight: 200;
}

#sign-up-form input {
  margin: 12px;
  font-size: 14px;
  padding: 15px;
  width: 260px;
  font-weight: 300;
  border: none;
  background-color: #e4e4e494;
  font-family: 'Helvetica Neue', sans-serif;
  letter-spacing: 1.5px;
  padding-left: 20px;
}

#sign-up-form input::placeholder{
  letter-spacing: 1px;
}


.small{
  font-size: 13px;
  color: grey;
  font-weight: 200;
  margin: 5px;
}

/* 
------------------------
      Buttons
------------------------
*/
.buttons__div {
	display: flex;
}

.control-button{
  cursor: pointer;
  display: block;
  margin-left: auto;
  margin-right: auto;
  width: 140px;
  height: 40px;
  font-size: 14px;
  text-transform: uppercase;
  background: none;
  border-radius: 20px;
  color: white;
  border: none;
  margin-top: 15px;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
}

.control-button:focus{
  outline:none;
}

.control-button:hover{
  outline:none;
  box-shadow: 0 3.2px 4px rgba(0, 0, 0, 0.3)
}

.control-button.up {
  background-color: var(--right-color);
}
.control-button.cancel {
  background-color: white;
  color: var(--right-color);
}

@media screen and (max-width: 1140px) {
	body, html {
		background-color: white;
	}
}
</style>
</head>
<body>
	<div class="overlaybox">
		<div class="overlay">
			<div class="sign-up" id="sign-up-info">
				<div class="title"><h1>Create Account</h1></div>
				<p class="small"> check your information:
				<div class="sign-up-form">
					<div>
						<form id="sign-up-form" action="signupresult" method="post">
							<input type="hidden" name="user_id" value="${snsinfo.user_id}" />
							<input type="hidden" name="user_pw" value="${snsinfo.user_pw}" />
							<input type="email" placeholder="Email" name="user_email" value="${snsinfo.user_email}" required="required" />
							<input type="text" placeholder="Name" name="user_name" value="${snsinfo.user_name}" required="required" />
						</form>
					</div>
					<div class="signbox">
						<div class="buttons__div">
							<button class="control-button up" form="sign-up-form">Sign Up</button>
							<button class="control-button cancel" onclick="location.href='./loginform'">Cancel</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>