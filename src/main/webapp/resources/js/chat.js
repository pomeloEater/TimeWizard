var sock;
var nickname = document.getElementById("nickname").value;
var client;
var rid = document.getElementById("rid").value;
var messageArea = document.getElementById("messageArea");
var group_no = document.getElementById("group_no").value;
function disconnect(){
	client.send("/publish/chat/disconnect", {}, JSON.stringify({chat_title: rid, type:'LEAVE', user_id: nickname}));
	client.subscribe("/subscribe/chat/room/"+rid, function (chat) {
	        var val = JSON.parse(chat.body);
	        $("#messageArea").prepend(content.user_id+": "+ content.chat_content+ "<br>");
	    });
	document.getElementById("disconnect").style.display="none";
	client.disconnect();
	location.href="../grouplist"
}

	//handler에서 정해준 서버 겅로로 설정

	// SockJS로 연결한 웹소켓 주소에 Stomp을 씌움

	// sock의 이벤트

	
 

$("#sendBtn").click(function() {
	sendMessage();
	$('#message').val('')
});



// 메시지 전송
function sendMessage() {
	msg = document.getElementById("message");
    client.send('/publish/chat/message', {}, JSON.stringify({group_no:group_no , chat_title: rid, type:'CHAT', user_id: nickname , chat_content: msg.value}));
	msg.value = '';
}

function enterkey() {
	//keyCode: 입력한 코드(13번 == enter)
	if (window.event.keyCode == 13) {
		sendMessage();
	}
}

function connect(){
	client.connect({}, function(){
		 // 3. send(path, header, message)로 메시지를 보낼 수 있다.
	    client.send("/publish/chat/join", {}, JSON.stringify({chat_title: rid, type:'ENTER', user_id: nickname})); 
	    // 4. subscribe(path, callback)로 메시지를 받을 수 있다. callback 첫번째 파라미터의 body로 메시지의 내용이 들어온다.
	    client.subscribe("/subscribe/chat/room/"+rid, function (chat) {
	        var val = JSON.parse(chat.body);
	        $("#messageArea").append(val.user_id+": "+ val.chat_content+ "<br>")
	    });
		 client.subscribe("/subscribe/chat/join/"+rid, function (chat) {
	        var val = JSON.parse(chat.body);
	        $("#messageArea").append(val.conntent+ "<br>");
			
	    });
	})
 document.getElementById("disconnect").style.display="inline";
}
function textclear(){
	$("#messageArea").empty();
	
}