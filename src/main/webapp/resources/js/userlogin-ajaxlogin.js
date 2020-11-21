$(function(){
		$("#loginchk").hide();
	});
	
function loginPrc(){
	var user_id = $("#user_id").val().trim();
	var user_pw = $("#user_pw").val().trim();
	var loginVal = {
			"user_id": user_id,
			"user_pw": user_pw
	}
	
	if (user_id == null || user_id == "" || user_pw == null || user_pw == "" ){
		alert("ID와 PW를 모두 작성해 주세요");
	} else {
		$.ajax({
			type: "post",
			url: "/timewizard/login/ajaxlogin",
			data: JSON.stringify(loginVal),
			contentType: "application/json",
			dataType: "json",
			success: function(msg){
				if (msg.check == true) {
					location.href = '/timewizard/main';
				} else {
					alert("ID 혹은 PW가 잘못 입력 되었습니다.");
				}
			},
			error: function(){
				alert("통신 실패");
			}
		});
	}
}