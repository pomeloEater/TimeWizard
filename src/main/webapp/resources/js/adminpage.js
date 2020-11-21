function button_event(user_no){

	if(confirm('회원 아이디를 비활성화 하겠습니까?')==true){
		
		alert("비활성화를 성공하셨습니다.");
		//btnsub_+유저번호 의 id를 가진 버튼을 클릭해줌
		document.getElementById("btnsub_"+user_no).click();
		
	} else {
		
		alert("비활성화를 취소하셨습니다.");
		
	}
};