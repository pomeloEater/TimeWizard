<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@700&display=swap" rel="stylesheet">
<script src="/timewizard/js/tab.js" defer></script>

<style>

	.sectionbar {
		font-family: 'Gothic A1';
	}

</style>

</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

	<section class="sectionbar">
		<div class="main_box">
			<div class="tab_box">
				<div class="tab active" onclick="openTab(event, 'con1')">
					<span>Daily</span>
				</div>
				<div class="tab" onclick="openTab(event, 'con2')">
					<span>Weekly & Monthly</span>
				</div>
			</div>
			<div class="content_box">

				<div id="con1" class="content on">
					<jsp:include page="/WEB-INF/views/personal_daily.jsp" flush="true"></jsp:include>
				</div>
				<div id="con2" class="content">
					<jsp:include page="/WEB-INF/views/personal_weekmonth.jsp" flush="true"></jsp:include>
					<jsp:include page="/WEB-INF/views/calendar.jsp" flush="true"></jsp:include>
					
				</div>
			</div>
		</div>
	</section>

	<jsp:include page="friendlist.jsp"></jsp:include>

</body>
</html>
