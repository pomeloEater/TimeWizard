<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%

	int year= Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int lastDay = Integer.parseInt(request.getParameter("lastDay"));
	
	Calendar cal = Calendar.getInstance();
	
	int hour = cal.get(Calendar.HOUR_OF_DAY);
	int min  = cal.get(Calendar.MINUTE);
	
%>

<body>

	<h1>일정 작성하기</h1>

	<form action="calendar">
		<input type="hidden" name="command" value="insertcal" />

		<table border="1">
			
			<tr>
				<th>일정</th>
				<td><select name="year">
						<!-- 오늘 날짜 기준으로 +,-5년까지 가지고 올 수 있게 -->
						<%
							for (int i = year - 5; i <= year + 5; i++) {
						%>
						<!-- 이조건을 쓰는 이유는 2020이 셀렉티트 될 수 있게 -->
						<option value="<%=i%>" <%=(year == i) ? "selected" : ""%>><%=i%></option>
						<%
							}
						%>
				</select>년 <select name="month">
						<%
							for (int i = 1; i < 13; i++) {
						%>
						<option value="<%=i%>" <%=(month == i) ? "selected" : ""%>><%=i%></option>
						<%
							}
						%>
				</select>월 <select name="date">
						<%
							for (int i = 1; i <= lastDay; i++) {
						%>
						<option value="<%=i%>" <%=(date == i) ? "selected" : ""%>><%=i%></option>
						<%
							}
						%>
				</select>일 <select name="hour">
						<%
							for (int i = 1; i < 23; i++) {
						%>
						<option value="<%=i%>" <%=(hour == i) ? "selected" : ""%>><%=i%></option>
						<%
							}
						%>
				</select>시 <select name="min">
						<%
							for (int i = 1; i <= 59; i++) {
						%>
						<option value="<%=i%>" <%=(min== i) ? "selected" : ""%>><%=i%></option>
						<%
							}
						%>
				</select>분</td>
			</tr>
			<tr>
				<th>제 목</th>
				<td><input type="text" name="cal_title" /></td>
			</tr>
			<tr>
				<th>내 용</th>
				<td><textarea rows="10" cols="50" name="cal_content"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
				<input type="submit" value="일정 작성" /> <input type="button" value="취소" /></td>
			</tr>


		</table>
	</form>


</body>
</html>