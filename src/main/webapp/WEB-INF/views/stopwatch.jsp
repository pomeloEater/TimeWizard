<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TiWi :: stopwatch timer</title>

<link href="https://fonts.googleapis.com/css2?family=Electrolize&display=swap" rel="stylesheet">
<link href="resources/css/stopwatch.css" rel="stylesheet">
<link href="resources/css/timer.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<script src="resources/js/stopwatch.js" defer></script>
<script src="resources/js/timer.js" defer></script>

</head>

<style>
	body {
		margin: 0;
		background-color: #273c75;
	}
</style>
<body>

	<div id="stopwatch_box">
		<div id="stopwatch_time">
			<div id="time" class="time">00:00:00</div>
		</div>
		<div id="stopwatch_menu">
			<a><i id="startbtn" class="fas fa-play-circle"></i></a>
			<a><i id="pausebtn" class="fas fa-pause-circle"></i></a>
			<a><i id="stopbtn" class="fas fa-stop-circle"></i></a>
		</div>
	</div>
	
	<div id="timer_box">
		<div id="timer_time">
			<div id="timer">00:00:00</div>
		</div>
		<div id="timer_limit">
			<div id="timer_setting">Set </div>
		</div>
		<div id="timer_menu">
			<i id="timer_hour" class="fas fa-plus-circle" onclick="hours()"></i>
			<i id="timer_min" class="fas fa-plus-square" onclick="mins()"></i>
			<i id="timer_start" class="fas fa-play-circle" onclick="start()"></i>
			<i id="timer_reset" class="fas fa-stop-circle" onclick="reset()"></i>
		</div>
	</div>

</body>
</html>
