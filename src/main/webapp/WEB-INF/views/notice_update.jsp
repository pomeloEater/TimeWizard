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
<title>TimeWizard</title>
<link href="/timewizard/css/actionpage.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

	<h1>공지사항 수정</h1>
	
	<form action="./updateres" method="post">
		<input type="hidden" name="notice_no" value="${dto.notice_no }" />
		<input type="hidden" name="nowpage" value="${paging.nowpage }">
		<input type="hidden" name="cntPerpage" value="${paging.cntPerpage }">
		<table border="1">
			<tr>
				<th>제목</th>
				<td><input type="text" name="notice_title" value="${dto.notice_title }" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="60" name="notice_content">${dto.notice_content }</textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="button" value="취소" onclick="location.href='detail?notice_no=${dto.notice_no}&nowpage=${paging.nowpage }&cntPerpage=${paging.cntPerpage }'" />
					<input type="submit" value="수정" />
				</td>
			</tr>
		</table>
	</form>

</body>
</html>