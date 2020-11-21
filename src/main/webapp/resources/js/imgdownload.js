/* html2canvas - div 영역 스크린샷 */
html2canvas(document.querySelector("#test")).then(function(canvas) {
	canvas.setAttribute("id", "mycanvas");
	canvas.setAttribute("style", "display:none");
	document.body.appendChild(canvas);
	download();
});

function download() {
	var image = document.getElementById("mycanvas")
						.toDataURL("image/png")
						.replace("image/png", "image/octet-stream");
	var download = document.getElementById("download")
							.setAttribute("href", image);
							
}