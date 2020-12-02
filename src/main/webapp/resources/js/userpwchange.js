let pw;
let pw_check;

function pw_change(){
	pw = document.getElementsByClassName("newPW")[0].val();
	pw_check = document.getElementsByClassName("newPW_check")[0].val();
	console.log("pw : "+pw);
	console.log("pw_chekc : "+pw_check);
	$.ajax({
		url: "/timewizard/pw_check?user_pw="+pw,
		type: "post",
		success: function(data){
			if(pw != pw_check){
				$(".newPW_text").text("비밀번호가 서로 다릅니다.").css("color","red");
			}else{
				if(data){
					$(".newPW_text").text("기존 비밀번호와 같습니다.").css("color","red");
				}else{
					document.getElementsByClassName("update_form")[0].submit();
				}
			}
		},
		error: function(data){
			alert("통신실패!!!ㅠㅠ");
			return false;
		}
	});
}


