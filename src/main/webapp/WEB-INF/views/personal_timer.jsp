<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>timer :: TIWI</title>
<script src="https://kit.fontawesome.com/3914a9940d.js"
	crossorigin="anonymous"></script>
</head>
<body>
	<div class="table">
		<div class="row">
			<div class="times">
				<div class="time">
					<input type="number" id="hour" value="00" min="00" max="99" />
					<div class="buttons__minus__plus">
						<button class="plus">
							<i class="fas fa-plus"></i>
						</button>
						<button class="minus">
							<i class="fas fa-minus"></i>
						</button>
					</div>
				</div>
				<div class="colon">:</div>
				<div class="time">
					<input type="number" id="minute" value="00" min="0" max="99" />
					<div class="buttons__minus__plus">
						<button class="plus">
							<i class="fas fa-plus"></i>
						</button>
						<button class="minus">
							<i class="fas fa-minus"></i>
						</button>
					</div>
				</div>
				<div class="colon">:</div>
				<div class="time">
					<input type="number" id="second" value="00" min="0" max="99" />
					<div class="buttons__minus__plus">
						<button class="plus">
							<i class="fas fa-plus"></i>
						</button>
						<button class="minus">
							<i class="fas fa-minus"></i>
						</button>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<button id="startpause">Start</button>
			<button id="reset">Reset</button>
		</div>
	</div>
</body>
<script>
const audio = new Audio("/timewizard/audio/timer_sound_freesfx.mp3");
const buttons = document.querySelectorAll(".buttons__minus__plus");
for(let button of buttons){
    button.addEventListener("click",function(e){
        let target;
        let numberValue = 0;
        if (e.target.getAttribute("class").indexOf("plus") == 0){
            target = e.target.parentElement.previousElementSibling;
            numberValue = Number(target.value) < 99 ? Number(target.value) + 1 : Number(target.value);
            target.value = numberValue < 10 ? "0" + numberValue : numberValue;
        } else if (e.target.getAttribute("class").indexOf("plus") == 7){
            target = e.target.parentElement.parentElement.previousElementSibling
            numberValue = Number(target.value) < 99 ? Number(target.value) + 1 : Number(target.value);
            target.value = numberValue < 10 ? "0" + numberValue : numberValue;
        } else if (e.target.getAttribute("class").indexOf("minus") == 0){
            target = e.target.parentElement.previousElementSibling;
            numberValue = Number(target.value) > 0 ? Number(target.value) - 1 : Number(target.value);
            target.value = numberValue < 10 ? "0" + numberValue : numberValue;
        } else if (e.target.getAttribute("class").indexOf("minus") == 7) {
            target = e.target.parentElement.parentElement.previousElementSibling;
            numberValue = Number(target.value) > 0 ? Number(target.value) - 1 : Number(target.value);
            target.value = numberValue < 10 ? "0" + numberValue : numberValue;
        }
    });
}

const numbers = document.querySelectorAll("[type=number]");
for(const number of numbers){
    number.addEventListener("keyup", function(e){
        Number(number.value) > 99 ? number.value = 99 : number.value = number.value;
        Number(number.value) < 0 ? number.value = 00 : number.value = number.value;
    });
}

let seconds = 0, minutes = 0, hours = 0, fullseconds = 0, timer;
function buildTimer() {
    fullseconds--;
    seconds = Math.trunc(fullseconds%60);
    minutes = Math.trunc(fullseconds/60%60);
    hours = Math.trunc(fullseconds/60/60%60);
    second.value = (seconds < 10 ? "0" + seconds.toString(): seconds);
    minute.value = (minutes < 10 ? "0" + minutes.toString(): minutes);
    hour.value = (hours < 10 ? "0" + hours.toString(): hours);
    document.querySelector("title").textContent = "timer :: " + hour.value + ":" + minute.value + ":" + second.value;
    seconds--;
    if (seconds < 0) {
        seconds = 60;
        minutes--;
        if (minutes < 0) {
            minutes = 60;
            hours--;
        }
    }
    if (fullseconds == 0){
        clearTimeout(timer);
        console.log("* alarm sound from Acoustic Bass Tick Tock Clock Accent of FreeSFX(https://freesfx.co.uk/)");
        audio.play();
        startpause.textContent = "Start";
		pauseTimer();
    }
}
function startTimer(){
    clearTimeout(timer);
    fullseconds = Number(second.value) + Number(minute.value) * 60 + Number(hour.value) * 60 * 60;
    timer = setInterval(buildTimer, 1000);
    return false;
}
function pauseTimer(){
    clearTimeout(timer);
    return false;
}
startpause.onclick = function() {
	if (this.textContent === "Start") {
		this.textContent = "Pause";
		startTimer();
	} else {
		this.textContent = "Start";
		pauseTimer();
	}
};

reset.onclick = function() {
	startpause.textContent = "Start";
	pauseTimer();
	seconds = 0;
	minutes = 0;
	hours   = 0;
	
	hour.value = "00";
	minute.value = "00";
	second.value = "00";
};
</script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@700&display=swap');
:root {
  /*color*/
  --color-white: #ffffff;
  --color-black: #212121;
  --color-gray: #f4f4f4;
  --color-dark-gray: #dddddd;

  /*font size*/
  --font-large: 36px;
  --font-title: 25px;
  --font-regular: 16px;
  --font-small: 12px;

  /*font weight*/
  --weight-bold: 700;
  --weight-regular: 500;
  --weight-thin: 300;

  /*Size*/
  --size-border-radius: 13px;
}
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
input {
    background-color: inherit;
    color: inherit;
    border: 0px transparent;
    width: 80.08px;
}
button {
    cursor: pointer;
    border: 1px solid #ccc;
    color: #fff;
    background: transparent;
    transition: all ease 300ms;
    outline: 0;
}
#startpause, #reset {
    margin: 0 5px;
    padding: 10px 30px;
    border-radius: 8px;
}
#startpause:hover, #reset:hover {
  color: #333;
  background: #fff;
}
input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
.times {
    display: table;
    margin: 0 auto;
}
.time {
    display: table-cell;
}
input[type="number"], .colon {
    text-align: center;
    font-family: 'Orbitron', sans-serif;
    font-size: 48px;
}
.buttons__minus__plus {
    display: flex;
    flex-direction: row;
    justify-content: center;
}
.plus, .minus {
    background: #444;
    border-color: #333;
}
.plus:hover, .minus:hover {
    background: #555;
    border-color: #555;
}
.plus:active, .minus:active {
    background: #fff;
    color: #333;
    border-color: #fff;
}
</style>
</html>