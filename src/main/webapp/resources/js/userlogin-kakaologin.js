window.addEventListener('DOMContentLoaded', ()=>{
    Kakao.cleanup();
    Kakao.init('8ba76a6026ec5b6b73ff1f95270d8845');
    let state = Math.random().toString(36).substr(2,11);
    sessionStorage.setItem('oauth_state_k', state);
	const kakaobtn = document.getElementById("kakao-login-btn");
	kakaobtn.addEventListener("click", () =>{
		Kakao.Auth.login({
			success: function(authObj){
				Kakao.API.request({
					url: '/v2/user/me',
					success: function(res){
						const xhr = new XMLHttpRequest();
						xhr.open('POST','/timewizard/login/kakaocallback');
						xhr.setRequestHeader('Content-type','application/json');
						xhr.send(JSON.stringify(res));
						xhr.onreadystatechange = function (e){
							if (xhr.readyState == 4 && xhr.status == 200){
								window.location.replace(xhr.responseText);
							}
						}
					},
					fail: function(err){
						console.log(err);
					},
				})
			},
			fail : function(err){
				console.error(err);
			}
		})
	});
});