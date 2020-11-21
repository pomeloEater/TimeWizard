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

<link rel="stylesheet" type="text/css" href="../resources/css/grouproom.css">
<link href="https://fonts.googleapis.com/css2?family=Source+Code+Pro&family=Source+Sans+Pro:wght@200;400&family=Staatliches&display=swap"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
window.onpageshow = function (event)
{
	if (event.persisted || (window.performance && window.performance.navigation.type == 2)) {
		alert("잘못된 접근 입니다.");
		location.href = "../grouplist";
	}

}
window.onunload = function(event) {

	disconnect();
};
</script>

<script type="text/javascript" src="https://cdn.jsdelivr.net/sockjs/latest/sockjs.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
<meta charset="UTF-8">
<title>채팅방: ${dto.group_title }</title>
</head>
<body>

	<c:choose>
		<c:when test="${empty dto.group_title }">
			방이 존재하지 않습니다.
			<script type="text/javascript">
				setTimeout(function() {
					// 3초 후 작동해야할 코드
					location.href = "../grouplist";
				}, 3000);
			</script>
		</c:when>
		<c:otherwise>
			<c:if test="${dto.group_client ge dto.group_su}">
				<script type="text/javascript">
					alert("인원수 초과.");
					location.href = "../grouplist";
				</script>
			</c:if>


			<c:if test="${!empty dto.group_pw }">
				<script type="text/javascript">
					var password = prompt("비밀번호를 입력하십시오.");
					if (password != '${dto.group_pw }') {
						alert("비밀번호가 틀렸습니다.");
						location.href = "../grouplist";
					}
				</script>
			</c:if>

			<div class="contentsection">
				<h1 id="title">${dto.group_title }</h1>
				<jsp:include page="/WEB-INF/views/rtcmulticonnection.jsp"></jsp:include>

				<input type="hidden" value="${dto.group_title }" id="rid">
				
				<div class="chat__area">
					<div class="buttons__area">
						<div class="chattext__div">
							<div class="buttons__div">
							</div>
							<div class="message_div">
								<input type="text" id="message" onkeyup="enterkey()"
									placeholder="채팅을 입력하십시오." />
								<input type="button" id="sendBtn" value="보내기" />
								<input type="hidden" id="nickname" placeholder="이름을 입력헤주십시오." value="${login.user_name }" readonly> 
							</div>
						</div>
						<div class="buttons__div" id="button_right">
							<input type="button" id="historyclear" value="기록삭제" onclick="textclear();">
							<input type="button" id="disconnect" value="종료" onclick="confirmDisconnect();" />
						</div>
					</div>
					<div id="textarea">
						<div id="messageArea"></div>
					</div>
				</div>
				<input type="hidden" value="${dto.group_no}" id="group_no">
			</div>
			<jsp:include page="friendlist2.jsp"></jsp:include>
			<script type="text/javascript" src="../resources/js/chat.js"></script>
			
		</c:otherwise>
	</c:choose>
</body>

</html>