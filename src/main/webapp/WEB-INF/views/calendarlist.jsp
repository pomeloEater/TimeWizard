<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>일정 목록 보기</h1>
	
	<form action="timewizard/calendar" method="post">
		<input type="hidden" name="command" value="muldel"/>
		<jsp:useBean id="calendar" class="com.minibean.timewizard.utils.calendar.CalendarUtils"/>
	
		<table border="1">
			
			<col width="50px">
			<col width="50px">
			<col width="300px">
			<col width="200px">
			<col width="100px">
			
			<tr>
				<th><input type="checkbox" name="all" onclick =""/></th>
				<th>번  호</th>
				<th>제  목 </th>
				<th>일  정</th>
				<th>작성일</th>
			</tr>
			<c:choose>
				<c:when test="${empty list }">
					<tr>
						<td colspan="5">---- 일정이 없습니다. ----</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${list }" var="dto">
						<tr>
							<td><input type="checkbox" name="chk" value="${dto.cal_no }"/></td>
							<td><input class="text-center"><a style="color : orange;" href="timewizard/calendar/calendardetail?cal_no=${dto.cal_no }">${dto.cal_title }</a></td>
							<td>
								<jsp:setProperty property="toDates" name="calendar" value="${dto.cal_mdate }"/>
								<jsp:getProperty property="toDates" name="calendar"/>
							</td>
							<td>
								<fmt:formatDate value="${dto.cal_regdate }" pattern="yyyy:mm:dd"/>
																			<!-- 혹시 오류 발생하면 mm을 MM으로 바꿔보자 -->
																			
								<!-- fmt=>는 무엇일까? 형식 지정해준대로 출력 ..어떻게 출력될까?
											 -->
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<tr>
				<td colspan="5">
					<input type="submit" value="삭제"/>
					<input type="button" value="돌아가기" onclick=""/>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>