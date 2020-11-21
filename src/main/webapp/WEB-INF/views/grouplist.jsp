<%@page import="com.minibean.timewizard.model.dto.ChatDto"%>
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
<link rel="stylesheet" type="text/css"
	href="resources/css/grouplist.css">
<link
	href="https://fonts.googleapis.com/css2?family=Source+Code+Pro&family=Source+Sans+Pro:wght@200;400&family=Staatliches&display=swap"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/3049a69bf8.js"
	crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/timewizard/js/grouplist.js" defer></script>

<script type="text/javascript">



</script>


<meta charset="UTF-8">
<title>TimeWizard</title>
</head>
<body>

	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

<!-- 	<nav class="fixedtop">
		<div class="logo">
			<a class="titlelogo" href="main"><img alt=""
				src="resources/image/027-star 2.png"></a> <a class="titlename"
				href="main"><img alt="" src="resources/image/TIME WIZARD.png"></a>
		</div>

		<div class="menu">
			<div id="searchArea">
				<input type="text" id="search" placeholder="아이디 또는 방이름을 입력하세요" class="group_title"/>
				<button id="searchBtn" onclick="searchRoom();">
					<a><i class="fas fa-search"></i></a>
				</button>
				<button id="searchBtn" onclick="reset();">
					초기화
				</button>
			</div>
			<div class="createroom">
				<input type="button" value="만들기"
					onclick="location.href='groupnewroom'">
			</div>
		</div>
	</nav> -->
	
	<section class="contentsection">
	<div class="menu">
			<div id="searchArea">
				<input type="text" id="search" placeholder="아이디 또는 방이름을 입력하세요" onkeyup="enterkey();" />
				<button class="searchBtn" onclick="searchRoom();">
					<a><i class="fas fa-search"></i></a>
				</button>
				<button class="searchBtn" onclick="reset();">
					<a><i class="fas fa-sync"></i></a>
				</button>
			</div>
			<div class="createroom">
				<input type="button" value="만들기"
					onclick="location.href='groupnewroom'">
			</div>
		</div>
		<div class="contentmain">
			<c:choose>
				<c:when test="${empty list }">
					<tr>
						<td>아무것도 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="dto" items="${list }">
						<div class="grouproom">
							<div class="groupimg">
							</div>
							<div class="grouptitle">
								<span class="group2">${dto.group_title }</span>
							</div>
							<div class="groupmain">
								<span class="groupid">${dto.user_name }</span>
							</div>
						</div>
						<div style="width: 1rem"></div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
	</section>
	
	<jsp:include page="friendlist.jsp"></jsp:include>
</body>
</html>