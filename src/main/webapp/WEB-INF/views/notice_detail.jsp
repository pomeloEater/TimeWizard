<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 로그아웃 후 뒤로가기 금지 -->
<% response.setHeader("Pragma", "no-cache"); 
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Cache-Control", "no-store"); 
	response.setDateHeader("Expires", 0L); 
%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TimeWizard</title>

<link
	href="https://fonts.googleapis.com/css2?family=Source+Code+Pro&family=Source+Sans+Pro:wght@200;400&family=Staatliches&display=swap"
	rel="stylesheet">
<link href="resources/css/noticedetail.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/timewizard/js/backbtn.js" defer></script>
<link href="/timewizard/css/actionpage.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<!-- <script src="js/bootstrap.min.js"></script> -->

<style type="text/css">
 
/*여기에 css 3개 추가했고 noticedetail.css에 추가한 부분은 주석으로 표시함 */

	
 a:link { color: brown; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: blue; text-decoration: underline;}

/* 
 .form-control :focus{
 	outline : none;
 } */

	
	#notice-content{
		height : 80%;
	}
	
	.wrap_reply{
		padding: 30px;
    	border-top: 1px solid #ccc;
   		background: #fafafa;
	}
	
	
/* 	
	button{
	
		appearance: push-button;
    	user-select: none;
    	white-space: pre;
   		align-items: flex-start;
   		text-align: center;
    	cursor: default;
    	color: -internal-light-dark(black, white);
    	background-color: -internal-light-dark(rgb(239, 239, 239), rgb(59, 59, 59));
    	box-sizing: border-box;
    	padding: 1px 6px;
    	border-width: 2px;
    	border-style: outset;
   	 	border-color: -internal-light-dark(rgb(118, 118, 118), rgb(133, 133, 133));
   	 	border-image: initial;
} */
	

</style>
<script type="text/javascript">
	
	var user_id ='${login.user_id}';
	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>


<%
	UserInfoDto UDto = (UserInfoDto)session.getAttribute("login");
	System.out.println("user role in header : " + UDto.getUser_role());
%>
	
<div class="mainsection">
	<table id="title">
	<%
		//로그인 되어있고 ADMIN, USER일 때만 보이게!
		if(UDto != null){
			if(UDto.getUser_role().equals("ADMIN")){
	%>
		<colgroup>
			<col width="500" />
			<col width="100" />
			<col width="200" />
			<col width="50" />
		</colgroup>
		<tr>
			<th>${dto.notice_title }</th>
			<th>운영자 YM</th>	
			<th>${dto.notice_regdate }</th>
			<th class="update" onclick="location.href='update?notice_no=${dto.notice_no }'"><i class="fas fa-wrench"></i></th>
		</tr>
	<%
		} else {
	%>
		<colgroup>
			<col width="500" />
			<col width="100" />
			<col width="200" />
		</colgroup>
		<tr>
			<th>${dto.notice_title }</th>
			<th>운영자 YM</th>
			<th>${dto.notice_regdate }</th>
		</tr>
	<%
			}
		}
	%>
	
	</table>
	
	<div id="content">
		<div id="notice-content">
			${dto.notice_content }
		</div>
		
		<!-- Reply Form {s} -->
		
		<form class="re_input">
		<div class="my-3 p-3 bg-white rounded shadow-sm" > 
			<form:form name="form" id="form" role="form" modelAttribute="replyDto" method="post">
			<input type="hidden" id="nno" value="${dto.notice_no }"/>
				
				<div class="row">
					<p style= "font : gulim">Reply</p>
					<br><br>
					<div class="col-sm-10">
						<form:textarea path="reply_content" id="reply_content" class="form-control" rows="5" cols="70" style="resize: none;"
						placeholder="댓글을 입력해주세요." ></form:textarea>
							<input type="hidden" class="form-control" id="user_no" value="${login.user_no }">	
							<input type="hidden" id="user_id" value="${login.user_id }"/>
							<input type="hidden" id="reply_regdate" value="${replyDto.reply_regdate }"/>
							<input type="hidden" id="user_name" value="${replyDto.user_name }">
						<button type="button" class="btn btn-sm btn-primary" id="insertReplyBtn">댓글 저장 </button>
					</div>
					<div class="col-sm-2">

					
					</div>

				</div>

				</form:form>

			 </div>
			</form>
			

			<!-- Reply Form {e} -->

			

			<!-- Reply List {s}-->

			<div style="padding-top: 10px">

				<h5> L i s t </h5>
				<div class="wrap_reply" >
					<p id="replyList"></p>
				</div>	
			</div> 

			<!-- Reply List {e}-->
	<script src="js/notice_reply.js"></script>
	<script src="js/replyedit.js"></script>
		</div>
</div>	
	
<div class="backbtn"><i class="fas fa-arrow-left"></i></div>


<%--   <div id="comment_state">
		<div id="comment_total">전체 댓글 ()개</div>
		<div id="comment_toggle">댓글 창 닫기▲</div>
	</div>
	
	<br/>
	
	<table id="commentlist_box">
		<c:choose>
			<c:when test="${empty list }">
				<tr>
					<th colspan="4">----------작성된 댓글이 없습니다----------</th>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${list }" var="dto">
					<tr>
						<td>${dto.notice_no }</td>
						<td>(작성자 ID)</td>
						<td></td>
						<td><a>X</a></td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	
	<br/>
	
	<form class="" method="post" action="/reply/replylist">
	<div id=comment>
		<div id="comment_box">
			<input type="text" placeholder="※욕설이나 비방 등 게시판 운영정책에 어긋나는 게시물 등록시 게시물 삭제 및 글쓰기 제한등의 불이익을 받을 수 있습니다."
			 id="comment_text" />
			<button id="comment_button"><a class="textOn">Comment</a><a class="imgOn"><i class="fas fa-check"></i></a></button>
		</div>
	</div> --%>

</body>
</html>


















