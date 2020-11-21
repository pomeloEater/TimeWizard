<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
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
<title>Time Wizard Map</title>

<link
	href="https://fonts.googleapis.com/css2?family=Source+Code+Pro&family=Source+Sans+Pro:wght@200;400&family=Staatliches&display=swap"
	rel="stylesheet">
<link href="/timewizard/css/actionpage.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="resources/css/tiwimap.css">
<script src="resources/js/tiwimap.js" defer></script>

</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<section class="contentsection">
		<div style="height: 10vh;"></div>
		<div class="map_wrap">
			<div class="anchorwrap">
				<span class="closebtn" onclick='closeNav()'>
				<i class="fa fa-angle-double-left fa-5" aria-hidden="true"></i>
				</span>
				<span class="openmenu" onclick='openNav()'>
				<i class="fa fa-angle-double-right fa-5" aria-hidden="true"></i>
				</span>
	       	</div>
			<div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden; color: black; border-radius: 30px;"></div>
			<div id="menu_wrap" class="bg_white">
				<div class="option">
					<div>
						<input type="hidden" value="강남역 스터디룸" id="keyword" size="15"
							onsubmit="searchPlaces()">
					</div>
				</div>
				<hr>
				<ul id="placesList"></ul>
				<div id="pagination"></div>
			</div>
		</div>
	</section>
	<jsp:include page="friendlist.jsp"></jsp:include>
	<script type="text/javascript"
		src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=112d3ea1d6f9c231c512b356cb5c03ce&libraries=services,clusterer"></script>
</body>
</html>