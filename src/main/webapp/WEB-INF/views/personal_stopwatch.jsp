<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>stopwatch :: TIWI</title>
</head>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;600;700;800;900&display=swap');
/* globals */
html, body {
  height: 100%;
  overflow: hidden;
}

/* background */
body {
  color: #fff;
  background: #333;
  margin: 0;
  height: 100vh;
}

/* header */
h1 {
  font-size: 3em;
  font-family: 'Orbitron', sans-serif;
  margin: 0.3em;
}

/* buttons */
button {
  cursor: pointer;
  margin: 0 5px;
  padding: 10px 30px;
  background: transparent;
  border: 1px solid #ccc;
  border-radius: 8px;
  outline: 0;
  color: #fff;
  transition: all ease 300ms;
}
button:hover {
  color: #333;
  background: #fff;
}
button#timer {
	float: right;
	margin-right: 20vh;
}
/* center content horizontally and vertically */
.table {
  display: table;
  width: 100%;
  height: 90vh;
  margin-top: 5vh;
}
.row {
  display: table-row;
  text-align: center;
}
</style>
<body>
<div class="table">
	<div class="row">
		<button id="timer">Timer</button>
	</div>
  <div class="row">
	<h1>
		<span id="hour">00</span>:<span id="minute">00</span>:<span id="second">00</span>
	</h1>
  </div>
  <div class="row">
	<button id="startpause">Start</button>
	<button id="reset">Reset</button>
	<button id="save">Save</button>
  </div>
</div>
<script type="text/javascript">
let seconds = 0,
minutes = 0,
hours = 0,
stopwatch;
let starttime = null;
let endtime = null;
let todo_no = window.name.split("_")[1];


function quitStopwatch(starttime, endtime){
	let starttimeForJSON = starttime.getFullYear() + "-" + Number(starttime.getMonth() + 1) + "-" + starttime.getDate() + " " + starttime.getHours() + ":" + starttime.getMinutes();
	let endtimeForJSON = endtime.getFullYear() + "-" + Number(endtime.getMonth() + 1) + "-" + endtime.getDate() + " " + endtime.getHours() + ":" + endtime.getMinutes();
	const xhr = new XMLHttpRequest();
	xhr.open("POST", "/timewizard/stopwatch/update");
	xhr.setRequestHeader("Content-type","application/json");
	const data = {
			todo_no: todo_no,
			todo_complete: "Y",
			todo_starttime: starttimeForJSON,
			todo_endtime: endtimeForJSON,
			todo_date: starttime
	};
	xhr.send(JSON.stringify(data));
	xhr.onreadystatechange = () => {
		if (xhr.readyState == 4 && xhr.status == 200 && Number(xhr.responseText) == 1){
			let today = new Date();
			let todaydate = "" + today.getFullYear() + (today.getMonth() < 9 ? "0" + (today.getMonth()+1): (today.getMonth()+1)) + (today.getDate() < 10 ? "0" + today.getDate() : today.getDate());
			opener.closeFirstModal();
			opener.closeSecondModal();
			opener.showDailyList(todaydate);
			window.close();
			window.open('','_self').close();
		}
	}
}

function buildStopwatch() {
	seconds++
	if (seconds >= 60) {
		seconds = 0;
		minutes++;
		if (minutes >= 60) {
			  minutes = 0;
			  hours++;
		}
	}
	second.textContent = (seconds < 10 ? "0" + seconds.toString(): seconds);
	minute.textContent = (minutes < 10 ? "0" + minutes.toString(): minutes);
	hour.textContent = (hours < 10 ? "0" + hours.toString(): hours);
	document.querySelector("title").textContent = "stopwatch :: " + hour.textContent + ":" + minute.textContent + ":" + second.textContent;
}

function startStopwatch() {
	clearTimeout(stopwatch);
	if (starttime == null){
		starttime = new Date();
	}
	stopwatch = setInterval(buildStopwatch, 1000);
	return false;
}
function pauseStopwatch() {
	clearTimeout(stopwatch);
	endtime = new Date();
	return false;
}
let i = 1;
timer.onclick = function(){
	window.open('/timewizard/timer', 'timer_' + i,'width=340, height=170, left=' + (50 * i) + ', top='+ (297 + 50 * (i - 1)) +', status=no, resizable=no');
	++i;
};

startpause.onclick = function() {
	if (this.textContent === "Start") {
		this.textContent = "Pause";
		startStopwatch();
	} else {
		this.textContent = "Start";
		pauseStopwatch();
	}
};

reset.onclick = function() {
	startpause.textContent = "Start";
	pauseStopwatch();
	starttime = null;
	endtime = null;
	seconds = 0;
	minutes = 0;
	hours   = 0;
	
	hour.textContent = "00";
	minute.textContent = "00";
	second.textContent = "00";
};

save.onclick = function() {
	startpause.textContent = "Start";
	pauseStopwatch();
	if (starttime == null){
		window.close();
		window.open('','_self').close();
	} else if (endtime == null){
		endtime = new Date();
	}
	quitStopwatch(starttime, endtime);
};

</script>
</body>
</html>