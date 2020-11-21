<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 로그아웃 후 뒤로가기 금지 -->
<% response.setHeader("Pragma", "no-cache"); 
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Cache-Control", "no-store"); 
	response.setDateHeader("Expires", 0L); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방 만들기</title>

<link href="/timewizard/css/newroom.css" rel="stylesheet">>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@700&display=swap" rel="stylesheet">

</head>
<body>



	<form action="createres" method= "post">
			<div id="box" class="createbox">
				<div class="createtitle">채팅방 이름</div>
	       		<input type="text" name="group_title" id="name" placeholder="채팅방 제목을 입력해주세요" required autofocus>
	       	</div>
	       	
	       	 	<input type="hidden" name="user_id" id="name" placeholder="아이디를 입력해주세요" value="${login.user_id }">
	       		<input type="hidden" name="user_name" id="name" placeholder="이름을 입력해주세요" value="${login.user_name }">
	       	<div class="createbox">
	       	<div class="createpublic">접근제한 설정</div>
	       		<select name="group_public">
	       			<option value="공개">공개</option>
	       			<option value="비공개">비공개</option>
	       		</select>
	       	</div>
	       	<div class="createbox">
	       		<div class="createtitle">내용</div>
		       	<input type="text" name="group_content" id="name" placeholder="내용을 입력해주세요">
	       	</div>
	       	<div class="createbox">
	       		<div class="createtitle">비밀번호</div>
		       	<input type="text" name="group_pw" id="name" placeholder="비밀번호를 입력해주세요" maxlength="10">
	       	</div>
	       <div class="createbox">
	       		<div class="createclient">인원수</div>
		       	<input type="number" name="group_su" id="name" placeholder="인원수 최소 1명" min="1" max="10" value="1">
	       	</div>
	       	
	        <div class="createbox">
		        <button type="submit">생성하기</button>
		        <button onclick="location.href='grouplist'">돌아가기</button>
		    </div>
    </form>

</body>
</html>