<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TimeWizard</title>
<script src="https://rtcmulticonnection.herokuapp.com/dist/RTCMultiConnection.min.js"></script>
<script src="https://cdn.webrtc-experiment.com/RecordRTC.js"> </script>
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
<script src="https://www.webrtc-experiment.com/getHTMLMediaElement.js"></script>
<script src="https://rtcmulticonnection.herokuapp.com/socket.io/socket.io.js"></script>
<link rel="stylesheet" href="/timewizard/css/group-rtc.css">
</head>
<%
	UserInfoDto login = (UserInfoDto)session.getAttribute("login");
	String user_id = (login.getUser_id().length() > 8)? login.getUser_id().substring(0,8):login.getUser_id();
	int user_no = login.getUser_no();
	String user_photo = login.getUser_photo();
%>
<body>
	<div class="webrtc__part">
		<div class="videos__area">
			<div class="local__video__area"></div>
		</div>
		<div class="modals__area">
			<div class="modal__area"></div>
			<div class="modal__area"></div>
		</div>
		<!-- personal daily hui css와 modal 부분 동일 -->
	</div>
    <script type="text/javascript">
	let link = window.location.href;
	let user_id = "<%=user_id%>";
	let user_photo = "<%=user_photo%>";
    let roomid = "${dto.group_title}"; 
   	
    window.onload = function () {
	   	let buttons_div_first = document.getElementsByClassName("buttons__div")[0];
	   	let button = document.createElement("button");
	   	button.setAttribute("type","button");
	   	button.setAttribute("id","enter-quit-button");
	   	button.textContent = "Enter";
	   	buttons_div_first.appendChild(button);
	   	
	   	let enter_quit_button = document.querySelector("#enter-quit-button");
	   	enter_quit_button.addEventListener("click", () => {
    		if (enter_quit_button.textContent == 'Enter'){
    			startRecording();
    			enter_quit_button.textContent = "Quit";
    		} else if (enter_quit_button.textContent == 'Quit'){
    			stopRecording();
    			enter_quit_button.textContent = "Enter";
    		}
    	});
    }
    </script>
	<script type="text/javascript" src="/timewizard/js/group-rtc.js"></script>
</body>
</html>