var time = 0;
var starFlag = true;
$(document).ready(function(){
	buttonEvt();
});

function init(){
	document.getElementById("time").innerHTML = "00:00:00";
}

function buttonEvt(){
	//변수설정
	var hour = 0;
	var min = 0;
	var sec = 0;
	var timer;

	// start btn
	$("#startbtn").click(function(){

		if(starFlag){
			$("#pausebtn").css("color","#FAED7D")
			$("#stopbtn").css("color","#FAED7D")
			this.style.color = "white";
			starFlag = false;
	
			if(time == 0){
				init();
			}

			timer = setInterval(function(){
				time++;
	
				min = Math.floor(time/60);
				hour = Math.floor(min/60);
				sec = time%60;
				min = min%60;
	
				var th = hour;
				var tm = min;
				var ts = sec;
				if(th<10){
					th = "0" + hour;
				}
				if(tm < 10){
					tm = "0" + min;
				}
				if(ts < 10){
					ts = "0" + sec;
				}
	
				document.getElementById("time").innerHTML = th + ":" + tm + ":" + ts;
			
			}, 1000);
		}
	});

	// pause btn
	$("#pausebtn").click(function(){
		if(time != 0){
			$("#startbtn").css("color","#FAED7D")
			$("#stopbtn").css("color","#FAED7D")
			this.style.color = "white";
			clearInterval(timer);
			starFlag = true;
		}
	});

// stop btn
	$("#stopbtn").click(function(){
		if(time != 0){
			$("#pausebtn").css("color","#FAED7D")
			$("#startbtn").css("color","#FAED7D")
			this.style.color = "white";
			clearInterval(timer);
			starFlag = true;
			time = 0;
			init();
		}
	});
}