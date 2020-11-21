<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Role Change</title>
<link href="/timewizard/css/actionpage.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="resources/css/adminrole.css">
<script src="resources/js/adminrole.js" defer></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
<form action="adminroleres" method="post">
	<input type="hidden" name="user_no" value="${dto.user_no}">
	<table border="1">
		<col width="50" />
		<col width="100" />
		<col width="200" />
		<tr>
			<td id="title" colspan="5">회원등급 변경</td>
		</tr>
		<tr>
			<th>회원번호</th>
			<th>I   D</th>
			<th>등      급</th>
		</tr>
		<tr>
			<td>${dto.user_no }</td>
			<td>${dto.user_id }</td>
			<td>
				<input type="radio" name="user_role" value="ADMIN" <c:if test="${dto.user_role eq 'ADMIN' }">checked</c:if>>
				<label for="radio1">관리자</label>
				<input type="radio" name="user_role" value="USER" <c:if test="${dto.user_role eq 'USER' }">checked</c:if>>
				<label for="radio2">일반회원</label>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<input class="btn" type="submit" value="변경 완료" />
				<input class="btn" type="button" value="목록" onclick="location.href='adminpage'" />
			</td>
		</tr>
	</table>
</form>

</body>
</html>