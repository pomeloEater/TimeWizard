<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
}

/* header */
h1 {
  font-size: 3em;
  font-family: 'Orbitron', sans-serif;
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

/* center content horizontally and vertically */
.table {
  display: table;
  width: 100%;
  height: 100%;
}
.cell {
  display: table-cell;
  vertical-align: middle;
  text-align: center;
}
</style>
<body>
<div class="table">
  <div class="cell">
    <h1>
      <span id="hour">00</span>:<span id="minute">00</span>:<span id="second">00</span>
    </h1>
    
    <button id="start-pause">Start</button>
    <button id="reset">Reset</button>
    <button id="quit">Quit</button>
  </div>
</div>
<script type="text/javascript">
let startpause   = document.getElementById("start-pause"),
seconds = 0,
minutes = 0,
hours = 0,
timer;
let starttime = "";
let endtime = "";
let todo_no = 0;
console.log(window.name);
function quitTimer(starttime, endtime){
	const xhr = new XMLHttpRequest();
	xhr.open("POST", "/timewizard/stopwatch/update");
	xhr.setRequestHeader("Content-type","application/json");
	const data = {
			todo_no: todo_no,
			todo_complete: "Y",
			todo_starttime: starttime,
			todo_endtime: endtime,
			todo_date: starttime
	};
	xhr.send(JSON.stringify(data));
	xhr.onreadystatechange = () => {
		if (xhr.readyState == 4 && xhr.status == 200 && Number(xhr.responseText) == 1){
			window.close();
			console.log("clear");
			window.open('','_self').close();
			console.log("clear?")
			showDailyList(pageDate.toString());
		}
	}
	closeFirstModal();
	closeSecondModal();
}

function buildTimer() {
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
}

function startTimer() {
	clearTimeout(timer);
	timer = setInterval(buildTimer, 1000);
	return false;
}
function stopTimer() {
	clearTimeout(timer);
	return false;
}

startpause.onclick = function() {
	if (this.textContent === "Start") {
		this.textContent = "Pause";
		startTimer();
	} else {
		this.textContent = "Start";
		stopTimer();
	}
};

reset.onclick = function() {
	stopTimer();
	seconds = 0;
	minutes = 0;
	hours   = 0;
	
	hour.textContent = "00";
	minute.textContent = "00";
	second.textContent = "00";
};
</script>
</body>
</html>