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
<link href="/timewizard/css/actionpage.css" rel="stylesheet">
<link href="/timewizard/css/userpwchange.css" rel="stylesheet">

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
				console.log(data);
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
	})
	function togglenone(){
		toggle.style.display = "none";
	}
	function toggleblock(){
		toggle.style.display = "block";
	}
});

</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

	<div class="userpwchangebox">
		<div class="middlebox">
			<form action="userpwchangeres" method="post">
			<input type="hidden" name="user_no" value="${dto.user_no}">
				<div class="pwchangebox">
					<label class="control-label" for="userId">아이디 : </label>
					<input class="form-control" type="text" id="user_id" name="user_id" value="${dto.user_id }" readonly="readonly"/>
				</div>
				<div class="pwchangebox">
					<label class="control-label" for="userName">성명 : </label>
					<input class="form-control" type="text" id="user_name" name="user_name" value="${dto.user_name }" readonly="readonly"/>
				</div>
				<div class="pwchangebox">
					<label class="control-label" for="userPass">패스워드 : </label>
					<input class="form-control" type="password" id="user_pw" name="user_pw" />
					<i id="icon" class="fas fa-exclamation-triangle"></i>
				</div>
				<div class="toggle">
					<div class="pwchangebox">
						<label class="control-label" for="newestPass">새 비밀번호(6~10자리) : </label>
						<input class="form-control" type="password" id="user_newestpw" name="user_newestpw" required="required"/>
					</div>
					<div class="pwchangebox">
						<label class="control-label" for="newestPassConfirm">새 비밀번호 확인 : </label>
						<input class="form-control" type="password" id="user_newestpw_check" name="user_newestpw_check" required="required"/>
					</div>
					<div class="pwchangebox">
						<input id="disbtn" class="btn" type="submit" value="변경하기 " />
						<input type="button" onclick="location.href='mypage'" value="취소" />
					</div>
					<div>
						<c:if test="${msg == false}">
							비밀번호가 맞지 않습니다.
						</c:if>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>