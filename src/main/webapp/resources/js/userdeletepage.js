function confirmUserDelete(){
	let modal__area = document.getElementsByClassName("modal__area")[0];
	modal__area.innerHTML = "";
	
	let modal__overlay = document.createElement("div");
	modal__overlay.setAttribute("class","modal__overlay");
	modal__overlay.setAttribute("onclick","closeFirstModal();");
	let modal__delete = document.createElement("div");
	modal__delete.setAttribute("class","modal__delete");
	
	let form = document.createElement("form");
	form.setAttribute("action","userdeleteres");
	form.setAttribute("method","post");
	let input_hidden = document.createElement("input");
	input_hidden.setAttribute("type","hidden");
	input_hidden.setAttribute("name","user_no");
	input_hidden.setAttribute("value",userno);
	form.appendChild(input_hidden);
	
	let div_deletebox1 = document.createElement("div");
	div_deletebox1.setAttribute("class","deletebox");
	let label1 = document.createElement("label");
	label1.setAttribute("class","control-label");
	label1.setAttribute("for","userId");
	label1.textContent = "아이디";
	let input1 = document.createElement("input");
	input1.setAttribute("class","form-control");
	input1.setAttribute("type","text");
	input1.setAttribute("id","user_id");
	input1.setAttribute("name","user_id");
	input1.setAttribute("value", userid);
	input1.setAttribute("readonly","readonly");
	div_deletebox1.appendChild(label1);
	div_deletebox1.appendChild(input1);
	
	let div_deletebox2 = document.createElement("div");
	div_deletebox2.setAttribute("class","deletebox");
	let label2 = document.createElement("label");
	label2.setAttribute("class","control-label");
	label2.setAttribute("for","userPass");
	label2.textContent = "패스워드";
	let input2 = document.createElement("input");
	input2.setAttribute("class","form-control");
	input2.setAttribute("type","password");
	input2.setAttribute("id","user_pw");
	input2.setAttribute("name","user_pw");
	div_deletebox2.appendChild(label2);
	div_deletebox2.appendChild(input2);
	
	let div_deletebox3 = document.createElement("div");
	div_deletebox3.setAttribute("class","deletebox");
	let label3 = document.createElement("label");
	label3.setAttribute("class","control-label");
	label3.setAttribute("for","userName");
	label3.textContent = "성명";
	let input3 = document.createElement("input");
	input3.setAttribute("class","form-control");
	input3.setAttribute("type","text");
	input3.setAttribute("id","user_name");
	input3.setAttribute("name","user_name");
	input3.setAttribute("vlaue", username);
	input3.setAttribute("readonly","readonly");
	div_deletebox3.appendChild(label3);
	div_deletebox3.appendChild(input3);
	
	let div_deletebox4 = document.createElement("div");
	div_deletebox4.setAttribute("class","deletebox");
	let button_success = document.createElement("button");
	button_success.setAttribute("class","btn btn-success");
	button_success.setAttribute("type","submit");
	button_success.setAttribute("id","submit");
	button_success.textContent = "회원탈퇴";
	let button_cancel = document.createElement("button");
	button_cancel.setAttribute("class","cancel");
	button_cancel.setAttribute("type","button");
	button_cancel.setAttribute("onclick","location.href='mypage'");
	button_cancel.textContent = "취소";
	div_deletebox4.appendChild(button_success);
	div_deletebox4.appendChild(button_cancel);
	
	let div = document.createElement("div");
	form.appendChild(div_deletebox1);
	form.appendChild(div_deletebox2);
	form.appendChild(div_deletebox3);
	form.appendChild(div_deletebox4);
	form.appendChild(div);
	
	modal__delete.appendChild(form);
	modal__area.appendChild(modal__overlay);
	modal__area.appendChild(modal__delete);
}

function closeFirstModal(){
	let modal__area = document.getElementsByClassName("modal__area")[0];
	modal__area.innerHTML = "";
}