<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TimeWizard</title>

<link href="https://fonts.googleapis.com/css2?family=Josefin+Sans&display=swap" rel="stylesheet">
<link href="resources/css/fullpageTemplate.css" rel="stylesheet">
<link href="resources/css/fullpage.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullPage.js/2.6.6/jquery.fullPage.js" crossorigin="anonymous"></script>
<!-- <script src="resources/js/main.js"></script> -->
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<script src="resources/js/indexpage.js" type="text/javascript" defer></script>

</head>
<body>

	<div id="fullpage">

		<div class="section" id="p1">
			<div class="textbox">
				<span class="underline"><a>TIME WIZARD 1ST PLANNER</a></span>
			</div>
			<div class="bounce animated arrowbox">
				<a><i class="fas fa-arrow-alt-circle-down"></i></a>
			</div>
		</div>
		
		<div class="section" id="p2" style="background-image:url(resources/image/bg1.jpg)">
			<div class="start">
				<a class="title">플래너의 시작, TIWI와 함께</a>
				<a href="login/loginform" class="loginform">시작하러 가기</a>
			</div>
			<div class="middle">
				<a>하루의 시작 일주일의 스케줄 한달의 계획 모두 TIWI에서 도와드립니다</a>
			</div>
		</div>
		
		<div class="section" id="p5">
			<div class="backimg" style="background-image:url(resources/image/bg6.jpg)"></div>
			<div class="p5container">
				<div class="p5box" style="background-image: url(resources/image/indeximg5.jpg)">
					<div class="contentbox">Daily</div>
					<div class="hoverbox">
						<span class="hovertitle">오늘의 일정</span>
						<div class="hovertext"><p>하루의 일정을 계획하고 세워보세요<br>하루가 쌓여 목표를 이룰 수 있습니다!</p></div>
						<p><i class="far fa-hand-point-right"></i> Daily 설정하러 가기</p>
					</div>
				</div>
				<div class="p5box" style="background-image: url(resources/image/indeximg6.jpg)">
					<div class="contentbox">Week & Mon</div>
					<div class="hoverbox">
						<span class="hovertitle">한 주 그리고 한 달</span>
						<div class="hovertext"><p>주 단위, 달 단위로 목표를 설정하세요<br>당신의 장기적인 플랜을 응원합니다!</p></div>
						<p><i class="far fa-hand-point-right"></i> Week & Mon 설정하러 가기</p>
					</div>
				</div>
				<div class="p5box" style="background-image: url(resources/image/indeximg8.jpg)">
					<div class="contentbox">Group cam</div>
					<div class="hoverbox">
						<span class="hovertitle">화상스터디</span>
						<div class="hovertext"><p>집에서 혼자하는 공부가 지겨우신가요?<br>공간제약없이, 어디서든 함께 할 수 있는<br>TIWI만의 서비스를 누려보세요!</p></div>
						<p><i class="far fa-hand-point-right"></i> 화상스터디 하러 가기</p>
					</div>
				</div>
				<div class="p5box" style="background-image: url(resources/image/indeximg7.jpg)">
					<div class="contentbox">Map</div>
					<div class="hoverbox">
						<span class="hovertitle">스터디 룸 찾기</span>
						<div class="hovertext"><p>직접만나 스터디하고싶은 분들에게 추천!<br>스터디카페 위치를 알려드립니다</p></div>
						<p><i class="far fa-hand-point-right"></i> 스터디 룸 찾으러 가기</p>
					</div>
				</div>
			</div>
		</div>

		<div class="section" id="p3">
			<div class="backimg" style="background-image:url(resources/image/bg2.jpg)"></div>
			<p class="p3title">
				TIWI STORY
			</p>
			<p class="p3main">
				Have you ever had a failure in what you planned?<br/>
				Or is it difficult to know what kind of plan should I approach the goals I have set?<br/>
				We thought. Magic to solve this problem!<br/>
				Time wizard presents effective plans to save and not waste your time.<br/>
				Start your perfect life with Time Wizard using the services and programs provided!
			</p>
			<div class="p3box">
				<a href="login/loginform" class="p3btn">
					GO TIWI
				</a>
			</div>
		</div>
		
		<div class="section" id="p4">
			<div class="minibeanbox">
				<a class="minibean" href="https://github.com/pomeloEater" style="background-image:url(resources/image/minibean2.png)"><span>박진희</span></a>
				<a class="minibean" href="https://github.com/mingyeungAA" style="background-image:url(resources/image/minibean1.png)"><span>배민경</span></a>
				<a class="minibean" href="https://github.com/sanheekim" style="background-image:url(resources/image/minibean6.png)"><span>김산희</span></a>
			</div>
			<div class="minibeanbox">
				<a class="minibean" href="https://github.com/AbelJung" style="background-image:url(resources/image/minibean5.png)"><span>정형빈</span></a>
				<a class="minibean" href="https://github.com/wnaudqls" style="background-image:url(resources/image/minibean3.png)"><span>주명빈</span></a>
				<a class="minibean" href="https://github.com/yoonyongmin" style="background-image:url(resources/image/minibean4.png)"><span>윤용민</span></a>
			</div>

		</div>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	  
	  // fullpage customization
	  $('#fullpage').fullpage({
	    sectionSelector: '.section',
	    navigation: true,
	    slidesNavigation: true,
	    css3: true,
	    controlArrows: false    
	  });

	 /*  $("#btn").on("click", function(event){
	    var offset = $("#p2").offset();
	    $("html body").animate({scrollTop:offset.top}, 1000);

	  $('div').remove('#fp-nav');


	  });
	 */
	  $('#p2').hover(function() {
	    $('.arrowbox').removeClass('bounce animated');
	  });

	  $('#p1').hover(function() {
	    $('.arrowbox').addClass('bounce animated');
	  });


	});


</script>
</html>