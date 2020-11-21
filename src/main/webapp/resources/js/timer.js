var Hcount = 0;
var Mcount = 0;
var Htime = 0;
var Mtime = 0;
var min = "";
var sec = "";

function hours() {
	var hourtime = 3600;
	Hcount++;
	Htime = Hcount*hourtime;
	
	console.log(Hcount);
	console.log(Htime);
	
	document.getElementById("timer_setting").innerHTML = "Set " + ((Htime/60) + (Mtime/60));
	
}

function mins() {
	var mintime = 600;
	Mcount++;
	Mtime = Mcount*mintime;
	
	console.log(Mcount);
	console.log(Mtime);
	
	document.getElementById("timer_setting").innerHTML = "Set " + ((Htime/60) + (Mtime/60));
	
}

function start() {
	var time = Htime+Mtime;
	var x = setInterval(function () {
		min = parseInt(time/60);
		sec = time%60;
		
		$('#timer_start').attr('onclick', null);
		$('#timer_hour').attr('onclick', null);
		$('#timer_min').attr('onclick', null);
		document.getElementById("timer").innerHTML = min + ":" + sec;
		time--;

		if (time < 0) {
			alert("종료되었습니다")
			clearInterval(x);
			document.getElementById("timer").innerHTML = "타이머를 다시 맞춰주세요";
		}
	}, 1000);

	if (time == 0) {
		alert("시간을 설정하세요");
		clearInterval(x);
		document.getElementById("timer").innerHTML = "00:00";
	}

// 타이머가 시작되면 "시작"을 "일시정지"로 바꿈
// 일시정지 누르면 "시작"으로 바꿔야함
// document.getElementById("timer_start").innerHTML = "RE";

	$(document).ready(function() {
		$("#timer_reset").click(function() {
		    clearInterval(x);
		    document.getElementById("timer").innerHTML = "00:00";
		    document.getElementById("timer_setting").innerHTML = "Set ";
        });
    })
}

function reset() {
	Hcount = 0;
	Mcount = 0;
	Htime = 0;
	Mtime = 0;
	
	$('#timer_start').attr('onclick', 'start()');
	$('#timer_hour').attr('onclick', 'hours()');
	$('#timer_min').attr('onclick', 'mins()');

	document.getElementById("timer_setting").innerHTML = "Set ";
}