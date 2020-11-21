<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>

<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Source+Code+Pro&family=Source+Sans+Pro:wght@200;400&family=Staatliches&display=swap"
	rel="stylesheet">

<link href="/timewizard/css/header.css" rel="stylesheet">

<link href="/timewizard/css/actionpage.css" rel="stylesheet">
<script src="/timewizard/js/header.js" defer></script>
</head>
<body>

<%
	UserInfoDto login = (UserInfoDto)session.getAttribute("login");
	int user_no = login.getUser_no();
	String user_distinct = login.getUser_distinct();
	System.out.println("user role in header : " + login.getUser_role());
%>

	<nav class="navbar">
		<div class="nav_logo">

			<a href="/timewizard/user/<%=user_distinct %>">
				<div class="logo_svg">
					<img class="text" alt="star" src="/timewizard/image/logo_star.svg" />
					<img class="accent" alt="star" src="/timewizard/image/logo_star_accent.svg" />
				</div>
				<span class="logo_text">Time Wizard</span>
			</a>

			<!-- 메인페이지로 -->
		</div>
		<ul class="nav_menu">
			<li><a href="/timewizard/user/<%=user_distinct %>"><i
					class="far fa-calendar-check"></i></a></li>
			<!-- Group메뉴 -->
			<li><a href="/timewizard/grouplist"><i class="fas fa-users"></i></a></li>
			<!-- Off-line 메뉴 -->
			<li><a href="/timewizard/tiwimap"><i
					class="fas fa-binoculars"></i></a></li>
			<li><a href="/timewizard/notice_list"><i class="fas fa-chalkboard-teacher"></i></a></li>
			<li><a href="http://pf.kakao.com/_ZxnJxfK/chat"><i class="far fa-paper-plane"></i></a></li>
		</ul>

		<ul class="nav_icon">
			<%
			//로그인 되어있고 ADMIN, USER일 때만 보이게!
			if(login.getUser_role().equals("ADMIN")){
			%>
					<li><a href="/timewizard/adminpage">${login.user_name }</a></li>
					<li><a href="/timewizard/logout">Logout</a></li>
			<%
			} else {
			%>
					<li><a href="/timewizard/mypage">${login.user_name }</a></li>
					<li><a href="/timewizard/logout">Logout</a></li>
			<%
			}
			%>
		</ul>

		<a href="#" class="nav_toggle"> <i class="fas fa-bars"></i>
		</a>
	</nav>

</body>
</html>