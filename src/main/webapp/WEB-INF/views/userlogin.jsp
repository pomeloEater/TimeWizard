<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TimeWizard</title>

<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@900&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//enter누르면 login넘어감~!
	$("#user_pw").keyup(function(event){
		if(event.keyCode == 13){
			$("#submit_go").click();
		}
	})
})

	
	$(function(){
		$("#loginchk").hide();
	});
	
	function loginPrc(){
		var user_id = $("#user_id").val().trim();
		var user_pw = $("#user_pw").val().trim();
		var loginVal = {
				"user_id": user_id,
				"user_pw": user_pw
		}
		
		if (user_id == null || user_id == "" || user_pw == null || user_pw == "" ){
			alert("ID와 PW를 모두 작성해 주세요");
		} else {
		
			$.ajax({
				type: "post",
				url: "/timewizard/login/ajaxlogin",
				data: JSON.stringify(loginVal),
				contentType: "application/json",
				dataType: "json",
				success: function(msg){
					if (msg.check == true) {
						location.href = '/timewizard/main';
					} else {
						alert("ID 혹은 PW가 잘못 입력 되었습니다.");
					}
				},
				error: function(){
					alert("ID 혹은 PW가 잘못 입력 되었습니다.");
				}
			});
		}
	}

</script>

<style type="text/css">
/* :root{
  --form-height:550px;
  --form-width: 900px;
  --left-color: #9fdeaf;
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
.overlaybox {
	height: 90vh;
}
.container{
  width: var(--form-width);
  height: var(--form-height);
  position: relative;
  margin: auto;
  box-shadow: 2px 10px 40px rgba(22,20,19,0.4);
  border-radius: 10px;
  margin-top: 50px;
}
.overlay .sign-in, .overlay .sign-up{
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
}
.overlay p{
  margin: 20px 0px 30px;
  font-weight: 200;
}

.switch-button, .control-button{
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
}
.switch-button{
  border: 2px solid;
}
.control-button{
  border: none;
  margin-top: 15px;
}
.switch-button:focus, .control-button:focus{
  outline:none;
}
.control-button.up{
  background-color: var(--left-color);
}
.control-button.in{
  background-color: var(--right-color);
}
.social-media-buttons{
  display: flex;
  justify-content: center;
  width: 100%;
  margin: 15px;
}
.social-media-buttons .icon{
  width: 40px;
  height: 40px;
  border: 1px solid #dadada;
  border-radius: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 10px 7px;
}
.small{
  font-size: 13px;
  color: grey;
  font-weight: 200;
  margin: 5px;
}
.social-media-buttons .icon svg{
  width: 25px;
  height: 25px;
}
#sign-in-form input, #sign-up-form input{
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
#sign-in-form input::placeholder{
  letter-spacing: 1px;
}
.forgot-password{
  font-size: 12px;
  display: inline-block;
  border-bottom: 2px solid #efebeb;
  padding-bottom: 3px;
}
.forgot-password:hover{
  cursor: pointer;
}
.sns {
	display: flex;
	padding: 12px;
}
.login_logo {
	display: flex;
	padding: 4px;
	cursor: pointer;
	border: 1px solid var(--color);
	border-radius: 50%;
	width: 30px;
	height: 30px;
	margin-left: 4px;
	margin-right: 4px;
	justify-content: center;
	align-items: center;
}
#naver {
	font-family: 'Montserrat';
	color: green;
}
.kakao {
	color: #fed330;
}
.icon {
	justify-content: space-around;
	font-size: 18px;
}
a {
	text-decoration: none;
}
.overlaybox {
	display: flex;
	justify-content: center;
	width: 100%;
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
@media screen and (max-width: 1140px) {
	body, html {
		background-color: white;
	}
}
 */
 
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

/* .container{
  width: var(--form-width);
  height: var(--form-height);
  position: relative;
  margin: auto;
  box-shadow: 2px 10px 40px rgba(22,20,19,0.4);
  border-radius: 10px;
  margin-top: 50px;
} */

.overlay .sign-in, .overlay .sign-up{
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

#sign-in-form input {
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

#sign-in-form input::placeholder{
  letter-spacing: 1px;
}


.small{
  font-size: 13px;
  color: grey;
  font-weight: 200;
  margin: 5px;
}

.forgot-password{
  font-size: 12px;
  display: inline-block;
  border-bottom: 2px solid #efebeb;
  padding-bottom: 3px;
}

.forgot-password:hover{
  cursor: pointer;
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
}

.control-button{
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

.control-button.in {
  background-color: var(--right-color);
}
.control-button.up {
  background-color: white;
  color: var(--right-color);
}


/* * * * * * * * * *  
 *       sns       *
 * * * * * * * * * */


.sns {
	display: flex;
	padding: 12px;
}

.login_logo {
	display: flex;
	padding: 4px;
	cursor: pointer;
	border: 1px solid var(--color);
	border-radius: 50%;
	width: 30px;
	height: 30px;
	margin-left: 4px;
	margin-right: 4px;
	justify-content: center;
	align-items: center;
	transition: 0.2s ease-in-out;
}
.login_logo:hover {
	border: 1px solid white;
}

.icon {
	color: var(--dark-color);
	justify-content: space-around;
	font-size: 18px;
}

#google:hover {
	/* background-color: #ea4335; */
	background-color: #4285f4;
}
#google:hover i {
	color: #ffffff;
}

#naver {
	font-family: 'Montserrat';
}
#naver:hover {
	background-color: #1ec800;
}
#naver:hover span {
	color: #ffffff;
}

#kakao-login-btn i {
	margin-left: 3px;
    margin-top: -1px;
}
#kakao-login-btn:hover {
	background-color: #ffeb00;
}
#kakao-login-btn:hover i {
	color: #3c1e1e;
}

/* 이 범위 코드가 있는게 나을지 없는게 나을지? */

#google i {
	color: #4285f4;
}
#naver {
	color: #1ec800;
}
#kakao-login-btn i {
	color: #ffeb00;
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
			<div class="sign-in" id="sign-in-info">
				<div class="title"><h1>Sign In</h1></div>
				<div class="sns">
 					<a href="${google_url}" class="login_logo" id="google">
						<i class="fab fa-google icon google"></i>
					</a>
					<a href="${naver_url}" class="login_logo" id="naver">
						<span class="naver_logo icon naver">N</span>
					</a>
					<a id="kakao-login-btn" class="login_logo" id="kakao">
						<i class="fab fa-kaggle icon kakao"></i>
					</a>
				</div>
				<p class="small"> or user your account:
				<div id="sign-in-form">
					<div>
						<input type="text" placeholder="Id" name="user_id" id="user_id" autofocus="autofocus"/>
						<input type="password" placeholder="Password" name="user_pw" id="user_pw"/><br/>
					</div>
					<div class="signbox">
						<p class="forgot-password"><a href="/timewizard/findform">Forgot your id or password?</a></p>
						<div class="buttons__div">
							<button id="submit_go" class="control-button in" onclick="loginPrc();">Sign In</button>
							<button class="control-button up" onclick="location.href='./signup'">sign up</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		window.addEventListener('DOMContentLoaded', ()=>{
		    Kakao.cleanup();
		    Kakao.init('8ba76a6026ec5b6b73ff1f95270d8845');
		    let state = Math.random().toString(36).substr(2,11);
		    sessionStorage.setItem('oauth_state_k', state);
			const kakaobtn = document.getElementById("kakao-login-btn");
			kakaobtn.addEventListener("click", () =>{
				Kakao.Auth.login({
					success: function(authObj){
						Kakao.API.request({
							url: '/v2/user/me',
							success: function(res){
								const xhr = new XMLHttpRequest();
								xhr.open('POST','/timewizard/login/kakaocallback');
								xhr.setRequestHeader('Content-type','application/json');
								xhr.send(JSON.stringify(res));
								xhr.onreadystatechange = function (e){
									if (xhr.readyState == 4 && xhr.status == 200){
										window.location.replace(xhr.responseText);
									}
								}
							},
							fail: function(err){
								console.log(err);
							},
						})
					},
					fail : function(err){
						console.error(err);
					}
				})
			});
		});
	</script>
</body>
</html>