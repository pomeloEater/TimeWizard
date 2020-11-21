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
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
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
					<input class="form-control" type="password" id="user_pw" name="user_pw" /><br/>
				</div>
				<div class="pwchangebox">
					<label class="control-label" for="newestPass">새 비밀번호(6~10자리) : </label>
					<input class="form-control" type="password" id="user_newestpw" name="user_newestpw" minlength="6" maxlength="10" /><br/>
				</div>
				<div class="pwchangebox">
					<label class="control-label" for="newestPassConfirm">새 비밀번호 확인 : </label>
					<input class="form-control" type="password" id="user_newestpw_check" name="user_newestpw_check" /><br/>
				</div>
				<div class="pwchangebox">
					<br/>비밀번호를 변경하시겠습니까?<br/><br/>
					<input id="disbtn" class="btn" type="submit" value="변경하기 " />
					<input type="button" onclick="location.href='mypage'" value="취소" />
				</div>
			<div>
				<c:if test="${msg == false}">
					비밀번호가 맞지 않습니다.
				</c:if>
			</div>
			</form>
		</div>
	</div>
</body>
</html>