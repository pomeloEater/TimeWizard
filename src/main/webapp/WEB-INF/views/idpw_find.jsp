<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID / PW FIND</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
	padding-left: 5px;
}

.contentbox input[type=email] {
	background-color: var(--color);
	width: 64%;
	height: 2rem;
	border: 0px;
	padding-left: 5px;
}

.chkbox input[type=button] {
	background-color: #96DBE2;
	color: white;
	width: 25%;
	height: 2rem;
	border: 0px;
	border-radius: 25px;
	cursor: pointer;

}

.chkbox input[type=submit] {
	background-color: #96DBE2;
	color: white;
	width: 30%;
	height: 2rem;
	border: 0px;
	border-radius: 25px;
	cursor: pointer;
	margin-top: 0.5rem;
}

.signuptitle div {
	padding: 6px;
}

input[type=button]{
	background-color: #96DBE2;
	color: white;
	width: 15%;
	height: 2rem;
	border: 0px;
	border-radius: 25px;
	cursor: pointer;
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
	
	.contentbox input[type=email] {
		height: 1.5rem;
	}
	
	.chkbox input[type=button] {
		width: 50%;
		height: 1.5rem;

	}
	
	.chkbox input[type=submit] {
		width: 50%;
		height: 1.5rem;
		margin-top: 0;
	}
	
	.email_check_id {
		font-size: 12px;
	}
	
	.id_check {
		font-size: 12px;
	}
	
}
</style>
<script>
$(document).ready(function() {
	//아이디 찾기 아작스
	function submitId(){
		$(".findid_button").click(function(){
			
			var user_email_id = $(".user_email_id").val();
			var url = "/timewizard/findID?user_email="+user_email_id;
			$.ajax({
				type: "POST",
				url: url,
				success: function(data){
					
					$(".id_result").text("Your ID : "+data.user_id);
				},
				error: function(data){
					alert("아이디 찾기 통신 실패ㅠㅠㅠ");
				}
			});
		});
	}
		
		//아이디 찾기
		//이메일 유효성
		$(".user_email_id").blur(function(){
			let user_email = $(".user_email_id").val(); 
			let emailjung = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			if(user_email == ""){
				$(".email_check_id").html('이메일을 입력해주세요.');
				$(".email_check_id").css('color','red');
				$(".email_button_id").attr("disabled",true);
				$(".findid_button").attr("disabled",true);
				
			}else if(emailjung.test(user_email)){
				$(".email_check_id").empty();
				$(".email_button_id").attr("disabled",false);
				
				//인증번호 버튼
				$(".email_button_id").click(function(){
					
					$.ajax({
						url : "/timewizard/login/emailSend?user_email="+ user_email,
						type : "get",
						
						success : function(data){
									alert("이메일이 발송되었습니다. 인증번호를 확인 후 입력하여주십시오.");
									$(".email_code_id ").focus();
									email_check(data);
									submitId();
									
						}, 	error : function(e){
							alert("이메일 인증에 실패하셨습니다.")
						}
					})
				})
			
			}else{
				$(".email_check_id").html('알맞은 이메일 형식이 아닙니다.');
				$(".email_check_id").css('color','red');
				$(".email_button_id").attr("disabled",true);
				$(".findid_button").attr("disabled",true);
			}
		});
});

//아이디 찾기
//이메일 인증 번호 확인
function email_check(data){

	$(".email_code_id").keyup(function(){
		var email_code_id = $(".email_code_id").val();

		if(email_code_id == ""){
			$(".email_code_text_id").text("인증번호를 입력해주세요!").css("color","red");
		}
		else {
			if(email_code_id == data){
				$(".email_code_text_id").text("인증번호가 맞습니다.").css("color","#ddd").fadeOut(1000);
				$(".findid_button").attr("disabled",false);
			}
		}
	})
}
//////////////////
//비밀번호//
$(document).ready(function() {
	function submitPW(){
		$(".findpw_button").click(function(){
			var useremail = $(".user_email_pw").val();
			var user_id = $(".user_id").val();
			var url = "/timewizard/findPW?user_email="+useremail+"&user_id="+user_id;
			$.ajax({
				type: "POST",
				url: url,
				success: function(data){
					$(".pw_result").text("Your PassWord : "+data.user_pw);
				},
				error: function(data){
					alert("아이디 찾기 통신 실패ㅠㅠㅠ");
				}
			});
		});
	}
	
	//이메일 유효성
	$(".user_email_pw ").keyup(function(){
		var user_email_pw = $(".user_email_pw").val(); 
		let emailjung = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		
		if(user_email_pw == ""){
			$(".email_check_pw ").html('이메일을 입력해주세요.').css('color','red');
			$(".email_button_pw ").attr("disabled",true);
			$(".findpw_button  ").attr("disabled",true);
			
		}else if(emailjung.test(user_email_pw)){
			$(".email_check_pw ").empty();
			$(".email_button_pw ").attr("disabled",false);
			
			//인증번호 버튼
			$(".email_button_pw ").click(function(){
				
				$.ajax({
					url : "/timewizard/login/emailSend?user_email="+ user_email_pw,
					type : "get",
					
					success : function(data){
								alert("이메일이 발송되었습니다. 인증번호를 확인 후 입력하여주십시오.");
								$(".email_code_pw").focus();
								email_check_pw(data);
								submitPW();
								
					}, 	error : function(e){
						alert("이메일 인증에 실패하셨습니다.")
					}
				})
			})
		
		}else{
			$(".email_check_pw ").html('알맞은 이메일 형식이 아닙니다.');
			$(".email_check_pw ").css('color','red');
			$(".email_button_pw").attr("disabled",true);
			$(".findpw_button  ").attr("disabled",true);
		}
	});
	
	//아이디 유효성
	$(".user_id").blur(function(){
		let userid = $(".user_id").val();
		if(userid == ""){
			$(".id_check").text("아이디를 입력해주세요!").css("color","red");
		}else{
			$(".id_check").empty();
		}
	})
	

});
 
//비밀번호 찾기
//이메일 인증 번호 확인
function email_check_pw(data){
	
	//인증번호 입력창에 쓰면
	$(".email_code_pw").keyup(function(){
		var email_code_pw_check = $(".email_code_pw").val();

		if(email_code_pw_check == ""){
			$(".email_code_text_pw ").text("인증번호를 입력해주세요!").css("color","red");
		}
		else {
			if(email_code_pw_check == data){
				$(".email_code_text_pw ").text("인증번호가 맞습니다.").css("color","#ddd").fadeOut(1000);
				$(".findpw_button  ").attr("disabled",false);
			}
		}
	})
}
</script>
</head>
<body>
<section class="signupbox">
		<div class="signupmenu">
			<div class="signuptitle">
				<p class="signuptext">Find Your ID or PW</p>
				<p class="signuptext2">Find Your ID</p>
				<div class="contentbox">
					<input type="email" placeholder="이메일을 입력해주세요." name="user_email" class="user_email_id" required="required">
					<input type="button" class="email_button_id" value="인증번호">
					<div class="email_check_id"></div>
				</div>
				<div class="contentbox">
					<input type="text" placeholder="인증번호를 입력해주세요." class="email_code_id" required="required">
					<div class="email_code_text_id"></div>
				</div>
				<input type="button" value="찾기" class="findid_button">
				<h4 class="id_result"></h4>
				<p class="signuptext2">Find Your PW</p>
				<div class="contentbox">
					<input type="text" placeholder="아이디를 입력해주세요." name="user_id" class="user_id" required="required">
					<div class="id_check"></div>
				</div>
				<div class="contentbox">
					<input type="email" placeholder="이메일을 입력해주세요." name="user_email" class="user_email_pw " required="required">
					<input type="button" class="email_button_pw" value="인증번호">
					<div class="email_check_pw"></div>
				</div>
				<div class="contentbox">
					<input type="text" placeholder="인증번호를 입력해주세요."  class="email_code_pw" required="required">
					<div class="email_code_text_pw"></div>
				</div>
				<input type="button" value="찾기" class="findpw_button">
				<h4 class="pw_result"></h4>
			</div>
		</div>
	</section>
	
</body>
</html>