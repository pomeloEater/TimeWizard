<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TimeWizard</title>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<style>

:root {
    --text-color: #f0f4f5;
    --background-color: #263343;
	--accent-color: #ff6b6b;
	--color: #E0E0E0;
}

body {
	margin: 0;
	background-color: var(--background-color);
}

.signupbox {
	display: flex;
	justify-content: center;
	align-items: center;
}

.signupmenu {
	display: flex;
	width: 30%;
	height: 90vh;
	border: 1px solid var(--color);
	border-radius: 10px;
	background-color: white;
	justify-content: center;
	margin-top: 5vh;
}

.signuptitle {
	width: 100%;
	text-align: center;
	justify-content: center;
	align-items: center;
}

.signuptext {
	font-size: 24px;
	font-weight: bold;
	color: var(--background-color);
}

.signuptext2 {
	color: #95a5a6;
}

.contentbox input[type=text] {
	background-color: var(--color);
	width: 80%;
	height: 2rem;
	border: 0px;
	padding-left: 12px;
}

#email_auto_code{
	background-color: var(--color);
	width: 55%;
	height: 2rem;
	border: 0px;
	padding-left: 12px;
}

.contentbox input[type=email] {
	background-color: var(--color);
	width: 55%;
	height: 2rem;
	border: 0px;
	padding-left: 12px;
}

.contentbox input[type=password] {
	background-color: var(--color);
	width: 80%;
	height: 2rem;
	border: 0px;
	padding-left: 12px;
}

.chkbox input[type=button] {
	background-color: #96DBE2;
	color: white;
	width: 30%;
	height: 2rem;
	border: 0px;
	border-radius: 25px;
	cursor: pointer;
	margin-bottom: 0.5rem;
}


input[type=button]{
	background-color: #96DBE2;
	color: white;
	width: 25%;
	height: 2rem;
	border: 0px;
	border-radius: 25px;
	cursor: pointer;
	margin-bottom: 0.5rem;
}


input[type=submit] {
	background-color: #96DBE2;
	color: white;
	width: 25%;
	height: 2rem;
	border: 0px;
	border-radius: 25px;
	cursor: pointer;
	margin-top: 0.5rem;
}

.signuptitle div {
	padding: 8px;
}


@media screen and (max-width: 1140px) {
	.signupmenu {
		width: 80%;
	}
	
	.signuptext {
		font-size: 20px;
	}
	
	.signuptext2 {
		font-size: 12px;
	}
	
	.contentbox input[type=text] {
		height: 1.5rem;
	}
	
	.contentbox input[type=password] {
		height: 1.5rem;
	}
	
	.contentbox input[type=email] {
		height: 1.5rem;
	}
	
	.chkbox input[type=button] {
		width: 50%;
		height: 1.5rem;
		margin-bottom: 0.5rem;
	}
	
	.chkbox input[type=submit] {
		width: 50%;
		height: 1.5rem;
		margin-top: 0;
	}
	
	#email_auto_code {
		height: 1.5rem;
	}
	
	#idc {
		font-size: 12px;
	}
	
	#pw_text {
		font-size: 12px;
	}
	
}

</style>
<script>
//아이디 중복체크 입니다.
$(document).ready(function() {
	$('input[name=user_id]').blur(function() {
		var idCheck = $('input[name=user_id]').val();
			$.ajax({

				url : 'idcheck?user_id=' + idCheck,
				type : 'get',

				success : function(data) {
					var idPass;
					var idRegex = /^[A-Za-z0-9]{4,12}$/;
					var idRegex2 = /[a-zA-Z0-9]/;
					var han = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
					var han2 = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{4,12}$/;
					var color;
					var ans;
					if (data == 1) {
						ans = '이미 존재하는 아이디입니다.';
						color = 'red';
						idPass = false;
					} else {
						if(idRegex.test(idCheck) && !han.test(idCheck)){
						$('#idc').empty();
							
						}else if((han.test(idCheck) && han2.test(idCheck))
								|| (idRegex.test(idCheck))
								|| ((idCheck.search(idRegex2) >= 0 && idCheck.search(han) >= 0)) && idCheck.length >= 4){
							ans = '아이디는 영문, 숫자만 가능합니다.';
							color = 'red';
							idPass = false;
						}else{
							ans = '아이디는 4-12자 이내로 입력해주세요.';
							color = 'red';
							idPass = false;
						}
					}
					
					//#은 id
					$('#idc').text(ans);
					$('#idc').css('color', color);
					
				}
			})
		
	});
	
	//이메일!!
	$("#user_email").keyup(function(){
		
		let user_email = $("#user_email").val().trim();
		var emailjung = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		if(user_email == ""){
			$("#email_text").html('이메일을 입력해주세요.');
			$("#email_text").css('color','red');
			$("#email_button").attr("disabled",true);
		
		}else if(emailjung.test(user_email)){
			$("#email_text").empty();
			$("#email_button").attr("disabled",false);
			
			$("#email_button").click(function(){
				$.ajax({
					url : "./emailSend?user_email="+ user_email,
					type : "get",
					
					success : function(data){
								alert("이메일이 발송되었습니다. 인증번호를 확인 후 입력하여주십시오.");
								$("#email_auto_code").focus(); 
								email_check_code(data);
								
					}, 	error : function(e){
						alert("이메일 인증에 실패하셨습니다.")
					}
				})
			})
		}else{
			$("#email_text").html('알맞은 이메일형식이 아닙니다.');
			$("#email_text").css('color','red');
			$("#email_button").attr("disabled",true);
		}
	});
	
	$(".username").keyup(function(){
		var username = $(".username").val();
		if(username == ""){
			$(".name_text").text("이름을 입력해주세요.").css("color","red");
			$(".control_button_in").attr("disabled", true);
		}else{
			$(".control_button_in").attr("disabled", false);
		}
	});
});


// 비밀번호 체크
	$(function() {
		$("input").keyup(function() {
			var pwd1 = $("#pwd1").val().trim();
			var pwd2 = $("#pwd2").val().trim();
			
			let num = /[0-9]/g;
			let eng = /[a-z]/ig;
			let spe = /[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi;
			let blank = /₩s/;
			
			//두 비밀번호가 같으면!!!
			if ((pwd1 == pwd2) && pwd1 != "") {
				//두 비밀번호가 같아도, 길이가 6보다 작고 12보다 크면, 다시 입력하게
				if(pwd1.length < 6 || pwd1.length > 10 || pwd2.length < 6 || pwd2.length > 10){
					$("#pw_text").html('6~10자 이내로 입력해주세요.');
					$("#pw_text").css('color','red');
					$("#submit").attr("disabled", "disabled");
				
				//두 비밀번호가 같아도,영문, 숫자, 특수문자 중 2가지 이상 혼합하여 입력해주세요
				}else if((pwd1.search(num) < 0 && pwd1.search(eng) < 0) 
						|| (pwd1.search(eng) < 0 && pwd1.search(spe) < 0) 
						|| (pwd1.search(spe) < 0 && (pwd1.search(num) < 0))){
					$("#pw_text").html('영문, 숫자, 특수문자 중 2가지 이상 혼합하여 입력해주세요.');
					$("#pw_text").css('color','red');
				
				//두 비밀번호가 같다면 && 길이가 6-10자 이내
				}else{ 
					$("#pw_text").html('비밀번호가 일치합니다.');
					$("#pw_text").css('color','#ddd');
					
					$("#submit").attr("disabled", "disabled");
				}
			
			//두 비밀번호가 다르면,
			}else if((pwd1 != pwd2) && pwd2 != ""){  
				$("#pw_text").html('비밀번호가 일치하지 않습니다.');
				$("#pw_text").css('color','red');
				
				$("#submit").attr("disabled", "disabled");
					
			}
			//비밀번호가 입력이 안됐을때,
			else if(pwd1 == "" || pwd2 == ""){
				$("#pw_text").html('비밀번호를 입력해주세요.');
				$("#pw_text").css('color','red');
				
			}
			
		});
	});
	
function email_check_code(data){
	
	$("#email_auto_code_button").click(function(){
		var email_code_pw_check = $("#email_auto_code").val();

		if(email_code_pw_check == ""){
			$("#email_check").text("인증번호를 입력해주세요!").css("color","red");
		}
		else {
			if(email_code_pw_check == data){
				$("#email_check").text("인증번호가 맞습니다.").css("color","#ddd");
				$(".control_button_in").attr("disabled",false);
			}
		}
	})
}

</script>
</head>
<body>

	<section class="signupbox">
		<div class="signupmenu">
			<form class="signuptitle" action="signupresult" method="post">
				<p class="signuptext">Create Account</p>
				<p class="signuptext2">or user your email for registration:</p>
				<div class="contentbox">


					<input type="text" placeholder="아이디(4~12자리)" name="user_id" class="user_id" required="required" autofocus />
					<div id="idc"></div>

				</div>
				<div class="contentbox">
					<input type="password" placeholder="비밀번호(6~10자리)" name="user_pw" id="pwd1" required="required"/>
				</div>
				<div class="contentbox">
					<input type="password" placeholder="비밀번호 확인" name="pw_check" id="pwd2" required="required"/>
					<div id="pw_text"></div>
				</div>
				<div class="contentbox">
					<input type="email" placeholder="이메일" name="user_email" id="user_email" required="required" />
					<input type="button" value="인증번호"  id="email_button"/>
					<div id="email_text"></div>
				</div>			
				<div class="contentbox">
					<input type="text" placeholder="인증번호 입력" id="email_auto_code" class="code_check" required="required"/>
					<input type="button" value="인증번호 확인" id="email_auto_code_button"/>
					<div id="email_check"></div>
				</div>
				<div class="contentbox">
					<input type="text" placeholder="이름 or 닉네임" name="user_name" class="username" required="required"/>
					<div class="name_text"></div>
				</div>
				<input type="submit" value="SIGN UP" class="control_button_in"/>
			</form>
		</div>
	</section>
	
</body>
</html>