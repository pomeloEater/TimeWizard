<%@page import="com.minibean.timewizard.model.dto.CalendarDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%  CalendarDto calDto = (CalendarDto)session.getAttribute("calDto"); %>

	<form action="/timewizard/calendar/" method="post">
		<input type="hidden" name="command" value="calupdate" />
		<input type="hidden" name="ca_no" value="${dto.cal_no }" />
			<table class="table" id="box_tb" style="width : 70%">
				<tr>
					<th class="table-active">제목</th>
					<td><input type="text" name="ca_title" value="${dto.cal_title }" /></td>
				</tr>
				<tr>
					<th>ID</th>
					<td>${dto.mb_id }</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea style="width:100%; height:300px; resize:none;" type="text" name="ca_content" rows="10" cols="70">${dto.ca_content }</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input class="btn btn-secondary mb-3" type="submit" value="수정" />
						<input class="btn btn-secondary mb-3" type="button" value="삭제" onclick="location.href='/timewizard/caldelete&cal_no=${dto.cal_no }'" />
						<input class="btn btn-secondary mb-3" type="button" value="취소" onclick="location.href='CalController.do?command=calendar'" />
					</td>	
				</tr>
				</table>
			</form>
	
</body>
</html>