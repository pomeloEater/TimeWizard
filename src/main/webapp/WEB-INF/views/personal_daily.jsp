<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("UTF-8");%>
<%response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TimeWizard</title>
<!-- <link rel="stylesheet" href="/timewizard/css/personal_daily.css"> -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="/timewizard/css/personal_daily_hui.css">
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script src="https://d3js.org/d3.v5.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="/timewizard/js/personal_daily.js"></script>
<script type="text/javascript" src="/timewizard/js/personal_daily-hashtag.js"></script>
</head>
<body>
<%
	UserInfoDto linked = (UserInfoDto) session.getAttribute("linked");
	UserInfoDto login = (UserInfoDto) session.getAttribute("login");
%>
	<div id="daily__part">
		<div class="daily__area">
			<div class="date__area">
				<div class="date__status">
					<div class="date__change"><i class="fas fa-caret-square-left"></i></div>
					<div class="date__change"><i class="far fa-caret-square-left"></i></div>
					<div class="date date__month">월</div>
					<div class="date date__day">일</div>
					<div class="date__change"><i class="far fa-caret-square-right"></i></div>
					<div class="date__change"><i class="fas fa-caret-square-right"></i></div>
					
					<button id="kakao-link-btn" type="button" onclick="dailyLink()">kakao share</button>
					<a id="download" download="daily_download.JPG">
						<button id="downloadbtn" type="button" onClick="download()">daily download</button>
					</a>
				</div>
				
			</div>
			<div class="contents__area">
				<div class="list__area">
					<div id="todo__list">date's todo-list
					</div>
				</div>
				<div class="heatmap__area">
					<div id="heatmap"></div>
					<div id="tooltip__area"></div>
				</div>
			</div>
		</div>
		<div class="modals__area">
		    <div class="modal__area"></div>
			<div class="modal__area"></div>
		</div>
	</div>
	
	<script type="text/javascript">
	let linkedUserNo = <%=linked.getUser_no()%>;
	const loginUserNo = <%=login.getUser_no()%>;
	</script>

<script type="text/javascript" src="/timewizard/js/sharekakao.js"></script>
</body>
</html>