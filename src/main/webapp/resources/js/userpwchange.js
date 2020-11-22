let toggle;
let icon;

//로딩 후 바로 적용됨
window.onload = function(){
	toggle = document.getElementsByClassName("toggle")[0];
	icon = document.getElementById("icon");
	
	toggle.addEventListener("load", togglenone());
	
	
}
//현재 비밀번호가 일치하지 않으면 none
function togglenone(){
	toggle.style.display = "none";
	
}
function toggleblock(){
	toggle.style.display="display";
}


