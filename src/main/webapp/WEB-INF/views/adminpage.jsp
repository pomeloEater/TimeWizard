<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 로그아웃 후 뒤로가기 금지 -->
<% response.setHeader("Pragma", "no-cache"); 
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Cache-Control", "no-store"); 
	response.setDateHeader("Expires", 0L); 
%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<link href="/timewizard/css/actionpage.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="resources/css/adminpage.css">
<script src="resources/js/adminpage.js" defer></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<form action="admindelete" method="post" name="userbye">
	<div class="adminbox" id="userlist">
		<table>
		<colgroup>
			<col width="50"/>
			<col width="100"/>
			<col width="100"/>
			<col width="100"/>
			<col width="200"/>
			<col width="100"/>
			<col width="200"/>
			<col width="100"/>
			<col width="150"/>
			<col width="150"/>
		</colgroup>
				<tr>
					<td id="title" colspan="10" align="center"><h1>회원 목록 조회</h1>
				</tr>
				<tr>
					<td align="center">번    호</td>
					<td align="center">I   D</td>
					<td align="center">P   W</td>
					<td align="center">이     름</td>
					<td align="center">이 메 일</td>
					<td align="center">활 성 화</td>
					<td align="center">가입날짜</td>
					<td align="center">등     급</td>
					<td align="center">등급변경</td>
					<td align="center">강제탈퇴</td>
				</tr>
				<c:forEach var="dto" items="${list }">
				<tr>
					<td align="center">${dto.user_no }</td>
					<td align="center">${dto.user_id }</td>
					<td align="center">${dto.user_pw }</td>
					<td align="center">${dto.user_name }</td>
					<td align="center">${dto.user_email }</td>
					<td align="center">${dto.user_active }</td>
					<td align="center"><fmt:formatDate pattern="yyyy-MM-dd" value="${dto.user_regdate }" /></td>
					<td align="center">${dto.user_role }</td>
					<td align="center"><a href="adminrole?user_no=${dto.user_no }">등급변경</a></td>
					<c:choose>
						<c:when test="${dto.user_active eq 'N' }">
						<td align="center"><input type="button" value="강제탈퇴" id="disablebtn" class="btn btn-primary" onclick="button_event();" value="${dto.user_no }" disabled="disabled" /></td>
						</c:when>
						<c:otherwise>
						<td align="center">
						<!-- submit의 id에 삭제할 유저번호를 넣어서 구별 -->
						<input type="submit" id="btnsub_${dto.user_no }" name="user_no"  
						class="btn btn-primary" value="${dto.user_no }" hidden=""/>
						<!-- 버튼 이벤트에 유저번호 넣어서 전송 -->
						<input type="button" value="강제탈퇴" id="disablebtn" onclick="button_event(${dto.user_no });" class="btn btn-primary"/>
	
						</td>
						
						</c:otherwise>
					</c:choose>
				</tr>
				</c:forEach>
		</table>
	</div>
	</form>
</body>
</html>