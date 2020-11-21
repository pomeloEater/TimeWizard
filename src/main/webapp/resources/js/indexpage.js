window.onload = function() {
	const p5box = document.querySelectorAll('.p5box');
	const contentbox = document.querySelectorAll('.contentbox');
	const hoverbox = document.querySelectorAll('.hoverbox');
	const hovertext = document.querySelectorAll('.hovertext');

	const x = window.matchMedia("screen and (min-width: 1140px)")



	if (matchMedia("screen and (min-width: 1140px)").matches) {
		for(let i=0 ; i<p5box.length ; i++) {
			p5box[i].addEventListener("mouseover", function() {
				contentbox[i].style = 'margin-top:25vh';
				hoverbox[i].style = 'height:20vh';
				hovertext[i].style = 'height:10vh';
			});

			p5box[i].addEventListener("mouseout", function() {
				contentbox[i].style = 'margin-top:35vh';
				hoverbox[i].style = 'height:10vh';
				hovertext[i].style = 'height:0vh';
			});

			p5box[i].addEventListener("click", function() {
				location.href='login/loginform';
			});
		}
	} else {
		for(let i=0 ; i<p5box.length ; i++) {
			p5box[i].addEventListener("mouseover", function() {
				contentbox[i].style = 'margin-top:10vh';
				hoverbox[i].style = 'height:20vh';
				hovertext[i].style = 'height:10vh';
			});

			p5box[i].addEventListener("mouseout", function() {
				contentbox[i].style = 'margin-top:20vh';
				hoverbox[i].style = 'height:10vh';
				hovertext[i].style = 'height:0vh';
			});
			
			p5box[i].addEventListener("click", function() {
				location.href='login/loginform';
			});
		}
	}
}