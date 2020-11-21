<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TimeWizard :: timer</title>

<link href="https://fonts.googleapis.com/css2?family=Electrolize&display=swap" rel="stylesheet">
<link href="resources/css/timer.css" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/3049a69bf8.js" crossorigin="anonymous"></script>
<script src="resources/js/timer.js" defer></script>
<script type="text/javascript">



</script>

</head>

<style>



</style>

<body>

	<h1>TIMER</h1>
	
	<div id="timer_box">
		<div id="timer_time">
			<div id="timer">0m 0s</div>
		</div>
		<div id="timer_limit">
			<div id="timer_setting">Time Limit :</div>
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
















