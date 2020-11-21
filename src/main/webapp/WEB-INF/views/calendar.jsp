<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@page import="org.springframework.stereotype.Service"%>
<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@page import="com.minibean.timewizard.utils.calendar.CalendarUtils"%>
<%@page import="com.minibean.timewizard.model.biz.CalendarBizImpl"%>
<%@page import="com.minibean.timewizard.model.biz.CalendarBiz"%>
<%@page import="com.minibean.timewizard.model.dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="com.minibean.timewizard.model.dao.CalendarDao"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.1.0/main.min.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.1.0/main.min.js"></script>
 <style type="text/css">
	:root {
	    --text-color: #f0f4f5;
	    --background-color: #263343;
	    --accent-color: #ff6b6b;
	    --point-color: #96DBE2;
		--color: #E0E0E0;
	}

	a{ text-decoration : none;}
	
	.clist > p { font-size : 5px; margin : 1px; background-color : skyblue; }
	
	
	#calendar{
		border-collapse : collapse;
		border : 1px solid var(--color);
		width: 100%;
	}
	
	#calendar th{
		width : 80px;
		border : 1px solid var(--color);
		background-color: var(--background-color);
		color: var(--color);
	}
	
	#calendar td{
		width : 80px;
		height : 80px;
		border : 1ps solid gray;
		text-align : left;
		vertical-align : top;
		position : relative;
	}
	
	.cpreview{
		position : absolute;
		top : -30px;
		left :  10px;
		background-color :  skyblue;
		width : 40px;
		height : 40px;
		text-align : center;
		line-height : 40px;
		border-radius:40px 40px 40px 1px;
	}


body {
	margin: 40px 10px;
	padding: 0;
	font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
}

@media screen and (max-width: 1140px) {
}

</style>

<script type="text/javascript" src ="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		let cal = new Calendar();
		let year = cal.year;
		let month = cal.month;
		let day = cal.day;

		$.ajax({
			type: "post",
			url : "/timewizard/cal/"+cal,
			success: function(data){
				console.log(data);
			}
				
		})
	});

	function isTwo(n){
		return (n.length<2)?"0"+n:n; //isTwo메소드와 동일한 내용
	}
	
	//이걸 사용하는 경우는 PersonalweekmonthController에서 확인
	$(function(){
		$(".countview").hover(
			function(){
				//마우스 커서 갖다 댔을떄
				var aCountView = $(this);
				var year = $(".y").text().trim(); //=>table .caption에 span태그에 붙어있었음
				var month = $(".m").text().trim();
				var dDate = aCountView.text().trim(); //손가락 갖다댄 곳이 '일'이므로 일에 해당
				
				var yyyyMMdd = year + isTwo(month) + isTwo(dDate);
			
				$.ajax({
					type:"post",
					url:"countajax.do",
					data:"user_no=${login.user_no}&yyyyMMdd="+yyyyMMdd,
					dataType:"json", //==>요청 했을때 응답되는 데이터가 제이슨 형태(문자열이 제이슨 형태라면 => json객체로 자동으로 파싱해줄 것임)
					async:false, //=> 동기로 처리
					success:function(msg){
						var count = msg.calcount;
						
						//aCountView는 div 밑에 a태그에 해당
						aCountView.after("<div class='cpreview'>"+count+"</div>");
					},
					
					error:function(){
						alert("서버 통신 실패!");
					}
				});
			},
			function(){
				//커서 치웠을 때
				$(".cpreview").remove();
				
			}
		);
	});


</script>

</head>
<body>

	<% 
	//하 이거도 이상한게 내가 컨트롤러에서 이거 다 생성한 내용들인데
	// 이걸 지우면 에러가 발생해버려서
	// 그치츠
	UserInfoDto login = (UserInfoDto)session.getAttribute("login");
	Calendar cal = Calendar.getInstance();
	List<CalendarDto> clist =(List<CalendarDto>)request.getAttribute("clist");
	
	
	
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH)+1;

	String paramYear = request.getParameter("paramYear");
	String paramMonth = request.getParameter("paramMonth");
	System.out.print("paramYear: "+paramYear);
	
	
	if(paramYear !=null){
		year = Integer.parseInt(paramYear);
	}
	
	if(paramMonth!=null){
		month = Integer.parseInt(paramMonth);
	}
	
	
	if(month>12){
		year++;
		month = 1;
	}
	
	if(month < 1){
		year--;
		month =12;
	}
	
	//달력!
	
	//힌트
	//현재 년도, 현재월 , 1일 셋팅
	cal.set(year,month-1, 1);
	
	//1일의 요일
	int dayOfweek = cal.get(Calendar.DAY_OF_WEEK);
							// Day_OF_WEEK
							// => SUN ~ SAT =>1,2,3,4,5,6,7
							//
	
	//마지막 요일
	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	int user_no = login.getUser_no();
	
	//달력에 일정 표현
	// CalendarBiz  @Service
	
	// 자바단에서 getViewList에 관련 된 기능을 구현하는 클래스(혹은 매소드)를 따로 만들어서 호출해보자.
	

	
	
%>

	<table id="calendar" border="1">
		<caption><!-- 테이블 제목 만들어줌 -->
			<a href="calendar.jsp?year=<%=year-1%>&month=<%=month%>">◀◀</a> <!-- 년도를 바꿈 -->
			<a href="calendar.jsp?year=<%=year%>&month=<%=month-1 %>">◁</a>  <!-- 월을 바꿔줌 -->
		
			<span class="y"><%=year %></span>년
			<span class="m"><%=month %></span>월
			
			<a href="calendar.jsp?year=<%=year %>&month=<%=month+1%>">▷</a>
			<a href="calendar.jsp?year=<%=year+1 %>&month=<%=month%>">▶▶</a>
		</caption>
		<tr>
			<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>
		</tr>
		<tr>		
<%
		//공백 만들기
		for(int i=1; i< dayOfweek; i++){
			out.println("<td>&nbsp;</td>");
		}

		for(int i=1; i<=lastDay; i++){
			
%>
			<td>

					<!-- counterView는 에이작스 -->
				<a class="" href="../calendar/calendarlist/<%=year %>/<%=month %>/<%=i %>" style="color:<%=CalendarUtils.fontColor(i, dayOfweek)%>"><%=i %></a>
				<a href="../calendar/calinsert?year=<%=year %>&month=<%=month %>&date=<%=i%>&lastDay=<%=lastDay%>">

					<i class="fas fa-pencil-alt"></i>
				</a>
			
				<div class="clist">
					<a href="../calendar/caldetail?cal_no=${calDto.cal_no }"><%=CalendarUtils.getViewTitle(i, clist) %></a><!-- p태그 생성 -->
				</div>
				
			</td>
<%
			if((dayOfweek-1 + i)%7==0){
				out.print("</tr><tr>");
			}
		}
		
		//뒤쪽 공백
		for(int i = 0; i < (7-(dayOfweek-1 + lastDay)%7)%7; i++){
			out.print("<td>&nbsp;</td>");
		}
		
%>
		</tr>
	</table>




	
	

</body>
</html>