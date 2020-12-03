<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TimeWizard</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link href="/timewizard/css/actionpage.css" rel="stylesheet">
<link href="/timewizard/css/userpwchange.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<script>
$(document).ready(function(){
	
	toggle = document.getElementsByClassName("toggle")[0];
	toggle.addEventListener("load", togglenone());
	
	$('#user_pw').blur(function(){
		let user_no = ${login.user_no};
		var user_pw = $("#user_pw").val();
		var pwVal = {
				"user_no":user_no,
				"user_pw":user_pw
		}

		$.ajax({
			type: "post",
			url: "/timewizard/checkpw",
			data: JSON.stringify(pwVal),
			contentType: "application/json",
			dataType: "json",
			success: function(data){
				if(data.check == true){
					$("#icon").css("color","blue");
					toggle.addEventListener("load", toggleblock());
				}else{
					alert("비밀번호가 틀렸습니다. 다시 입력해주세요!");
					$("#user_pw").focus();
					$("#icon").css("color","red");
				}
			},
			error: function(data){
				alert("통신실패ㅜㅠㅠ");
			}
		});
	});
	function togglenone(){
		toggle.style.display = "none";
	}
	function toggleblock(){
		toggle.style.display = "block";
	}
	let new_pw;
	let new_pw_check;
	$("#newPW").keyup(function(){
		new_pw = $("#newPW").val().trim();
		let pw = $("#user_pw").val().trim();

		let num = /[0-9]/g;
		let eng = /[a-z]/ig;
		let spe = /[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi;
		let blank = /₩s/;
		
		if(new_pw == pw){
			$(".newPw_text").text("기존 비밀번호와 같습니다.");
			$("#updatebtn").attr("disabled", "disabled");
		}else if(new_pw.length < 6 || new_pw.length > 12){
			$(".newPw_text").text("6~12자 이내로 입력해주세요.");
			$("#updatebtn").attr("disabled", "disabled");
		}else if((new_pw.search(num) < 0 && new_pw.search(eng) < 0)
				|| (new_pw.search(eng) < 0 && new_pw.search(spe) < 0)
				|| (new_pw.search(spe) < 0 && (new_pw.search(num) < 0))){
			$(".newPw_text").text("영문, 숫자, 특수문자 중 2가지 이상 혼합하여 입력해주세요.");
			$("#updatebtn").attr("disabled", "disabled");
		}else{
			$(".newPw_text").text("");
			$("#updatebtn").attr("disabled", "disabled");
		}
	});
	//새 비밀번호 확인 부분
	$("#newPW_check").keyup(function(){
		new_pw = $("#newPW").val().trim();
		new_pw_check = $("#newPW_check").val().trim();
		if(new_pw != "" || new_pw_check != ""){
			if(new_pw == new_pw_check){
				$(".newPW_check_text").text("사용가능한 비밀번호입니다.");
				$("#updatebtn").attr("disabled", false);
			}else{
				$(".newPW_check_text").text("비밀번호를 다시 입력해주세요.");
				$("#updatebtn").attr("disabled", "disabled");
			}
		}
	})
});


</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

	<div class="userpwchangebox">
		<div class="middlebox">
			<form action="userpwchangeres" method="post" class="update_form">
			<input type="hidden" name="user_no" value="${dto.user_no}">
				<div class="pwchangebox">
					<label class="control-label" for="userId">아이디 : </label>
					<input class="form-control" type="text" id="user_id" value="${dto.user_id }" readonly="readonly"/>
				</div>
				<div class="pwchangebox">
					<label class="control-label" for="userName">성명 : </label>
					<input class="form-control" type="text" id="user_name"  value="${dto.user_name }" readonly="readonly"/>
				</div>
				<div class="pwchangebox">
					<label class="control-label" for="userPass">패스워드 : </label>
					<input class="form-control" type="password" id="user_pw" autofocus="autofocus" />
					<i id="icon" class="fas fa-exclamation-triangle"></i>
				</div>
				<div class="toggle">
					<div class="pwchangebox">
						<label class="control-label" for="newestPass">새 비밀번호 : </label>
						<input type="password" id="newPW" class="newPW" name="user_pw" placeholder="6~10자 " required="required"/>
						<div class="newPw_text"></div>
					</div>
					<div class="pwchangebox">
						<label class="control-label" for="newestPassConfirm">새 비밀번호 확인 : </label>
						<input type="password" id="newPW_check" class="newPW_check" required="required"/>
						<div class="newPW_check_text"></div>
					</div>
					<div class="pwchangebox">
						<input id="updatebtn" class="btn" type="submit" value="변경하기 "/>
						<input type="button" onclick="location.href='mypage'" value="취소" />
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>