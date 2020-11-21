var connection = new RTCMultiConnection();
var remoteUserId = 'xyz';
var name = document.getElementById('nickname').value;
var openbutton = document.getElementById('btn-open-room');
var joinbutton = document.getElementById('btn-join-room');
var sharebutton = document.getElementById('share-room');

//this line is VERY_important 중계해줄 서버 주소(시그널 서버)
//connection.socketURL = 'https://192.168.1.17:9001/';
//var link = window.location.href.split("command=stream")[0];
var link = window.location.href.split("command=stream")[0];
connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';
/*

ICE: 	Interacitve Connectivity Establishment의 약어이고, 
		STUN과 TURN을 활용해서 두 단말이 서로 통신할 수 있는 최적의 경로를 
		찾을 수 있도록 도와주는 프레임워크임

STUN:	Session Traversal Utilities for NAT의 약어이며, 
	  	 상대방 클라이언트에 이 정보를 전달해 주며 이를 통해 P2P 연결을 성립시키는 역할을 함

TURN: 	Traversal Using Relay around NAT의 약어이고, 
	  	STURN서버를 이용한 연결이 실패했을경우에 사용됨
		공인 IP로 돌아가는 TURN 서버를 이용해
		각 클라이언트가 보내는 데이터를 다른 클라이언트에게 보내주는 작업을 실시하여 P2P 연결을 성립시켜줌
		즉, STUN/TURN 서버는 중계자 역할과 비슷하다.
	
Signaling: 서로 다른 네트워크에 있는 Client들은 서로를 연결하기 위해서
			각 클라이언트의 위치와 미디어 포맷 협의가 필요하는데,
			이러한 프로세스를 진행해주는게 Signaling임

Signaling 서버 : 두 클라이언트 사이에서 서로의 Signaling 정보를 전달 할 수 있는 서버가 필요하며
				어떠한 통신 방법이든 상관 없음
				Signaling 서버는 클라이언트에서 오는 정보를 다른 클라이언트로 전달하는 역할만 수행함
*/


//ice서버 초기화

connection.iceServers = [];

//stun server 설정
connection.iceServers.push({
	urls: 'stun:stun.l.google.com:19302'
});

//turn server 설정
connection.iceServers.push({
	url: 'turn:numb.viagenie.ca',
	credential: 'muazkh',
	username: 'webrtc@live.com'
});

// 음성,비디오 활성화
connection.session = {
	audio: true,
	video: true
};
//클라이언트에게 오디오를 활성화 할지, 비디오를 활성화 할지 제안함 
connection.sdpConstraints.mandatory = {
	OfferToReceiveAudio: true,
	OfferToReceiveVideo: true
};

var localvideo = document.getElementById('localvideo');
var remotevideo = document.getElementById('remotevideo');
var maxClient = document.getElementById('maxClient');
//최대인원(방 개설인원 포함)
//connection.maxParticipantsAllowed = 2;
if(maxClient){
	if((maxClient.value == null || maxClient.value == '')
	&&connection.maxParticipantsAllowed >= 100){
		
	/*connection.maxParticipantsAllowed = prompt("최대인원을 설정하세요.");*/
	while(isNaN(connection.maxParticipantsAllowed)){
		connection.maxParticipantsAllowed = prompt("최대인원을 다시 설정하세요.");
	}
		console.log("최대인원수: "+connection.maxParticipantsAllowed);
	}
}

//maxClient.value = connection.maxParticipantsAllowed;
connection.extra = {
//이름, 지역, 유저의 id를 불러오는 곳
	fullName: name
}

connection.onstream = function(event) {
	var h2 = document.createElement("h2");
	var video = event.mediaElement;
	//화면 생성
	video.id = event.streamid;
	
	//video 객체 생성 해주는 명렁어
	if (event.type == 'local') {
		//자기 자신의 화면일 경우
		var div = document.createElement('div');
		localvideo.appendChild(div);
		//localvideo에 div 상속
		div.appendChild(video);
		//localvideo의 자식요소로 추가
		
		//h2.HTML 값을 위에 connection.extra의 fullName 값을 넣음
		div.appendChild(h2);
		//div에 h2 상속
		console.log("이름: "+name);
		console.log(connection.maxParticipantsAllowed);
		while(name == null || name == ''  || name == ' ' || name == undefined){
			event.extra.fullName = prompt("이름을 입력하세요.");
			if(event.extra.fullName != null || event.extra.fullName != ''  || event.extra.fullName != ' ' || event.extra.fullName != undefined){
				name = event.extra.fullName;
				false;
			}
		}
			h2.innerHTML = event.extra.fullName;
		
   		 //window.open(broadUrl);
	}
	if (event.type == 'remote') {
		var div = document.createElement('div');
		//상대방 비디오 화면일 경우
		div.id = event.streamid;
		remotevideo.appendChild(div);
		//remotevideo에 div 상속
		div.appendChild(video);
		//remotevideo의 자식요소로 추가
		h2.innerHTML = event.extra.fullName;
		//h2.HTML 값을 위에 connection.extra의 fullName 값을 넣음
		//왜 사람마다 다른 이름이 나오냐면 위에서 따로 입력해서 값을 받기 때문
		div.appendChild(h2);
		//div에 h2 상속
	}
};
connection.onstreamended = function(event) {
	//stream이 끝낫을때 (유저가 접속을 끊었을때)
    var div = document.getElementById(event.streamid);
	//해당 div의 streamid를 찾음
    if (div && div.parentNode) {
	//div와 div의 부모가 있으면
        div.parentNode.removeChild(div);
	//해당 자식요소를 삭제
    }
};
var roomid = document.getElementById("roomid");
//방이름 설정

if(openbutton){
openbutton.onclick = function() {
	//btn-open-room 클릭시
	this.disabled = true;
	console.log(roomid.value);
	//비활성화
	if (roomid.value == null || roomid.value == '') {
		//방이름이 없거나 null값일 경우
		alert('방이름을 다시 입력하세요.');
		this.disabled = false;
		return;
	} else {
		//방 열기(혹은 존재할 경우, 접속하기)
		connection.openOrJoin(roomid.value, function(isRoomCreated, roomid, error){
			if(error){
				//오류발생시
				alert("다음과 같은 이유로 방을 생성할 수 없습니다.\n오류: " + error);
				document.getElementById('btn-open-room').disabled = false;
				//버튼 활성화
				return;
			}
			var div = document.querySelector('#localvideo>div');
			var div2 = document.createElement('div');
			var broadUrl = link+'?command=watch&roomid=' + roomid;
			/*var a = document.createElement('a');
			a.setAttribute('href', broadUrl, "id", "share");
			div.appendChild(a);*/
			var a = '<input type="text"value="'+broadUrl+'" id="share" hidden>';
			div.appendChild(div2);
			div2.innerHTML = a;
		});
		//일정시간마다 반복해주는 setInterval 함수 단위는 mill
		setInterval(function(){
		
			var clnum = document.querySelector('#clientnumber');
				connection.getAllParticipants().forEach(function(participantId) {
				    var user = connection.peers[participantId];
					var hisFullName  = user.extra.fullName;
					var hisUID = user.userid;
					
				});
				 var numberOfUsers = connection.getAllParticipants().length;
					clnum.innerHTML = "최대 인원수: "+(connection.maxParticipantsAllowed) + "<br>인원수: " +(numberOfUsers+1)+"명";
				},5000);
	}
	
	};
}
if(joinbutton){
joinbutton.onclick = function() {
	//btn-join-room 클릭시
	this.disabled = true;
	//비활성화
	if (roomid.value == null || roomid.value == '') {
		alert('방이름을 다시 입력하세요.');
		this.disabled = false;
		return;
	} else {
		//방 참가
		connection.join(roomid.value, function(isRoomJoined, roomid, error){
			if(error){
				document.getElementById('btn-join-room').disabled = false;
				alert("해당 오류로 인해 접속할 수 없습니다.\n오류: "+error);
				/*
					var localvideo = document.getElementById("localvideo");
					var video = document.querySelector('#localvideo div')
				
					if(localvideo && localvideo.childNodes){
						localvideo.removeChild(video);
				}*/

				return;	
			}
			//일정시간마다 반복해주는 setInterval 함수 단위는 mill
			setInterval(function(){
				connection.getAllParticipants().forEach(function(participantId) {
				    var user = connection.peers[participantId];
				    //자신을 제외한 현재 연결한 객체들을 저장함
				});
					var clnum = document.querySelector('#clientnumber');
					var numberOfUsers = connection.getAllParticipants().length;
					clnum.innerHTML = "구경꾼들: " + numberOfUsers +"명";;
				},1000);
			});
		}
	
	
	};
}
if(sharebutton){
	sharebutton.onclick = function(){
		var share = document.getElementById('share');
		if(!share){
		alert("먼저 방을 만들고 진행하세요");
		}else{
			share.hidden = "";
			//숨김속성 삭제
		 	share.select();
			//share 선택
		 	document.execCommand("Copy");
			//복사명령을 내림
			alert("주소가 복사되었습니다.");
			
			share.hidden = "hidden";
			//그리고 다시 숨김
		}
	};
}
(function() {
    var params = {},
        r = /([^&=]+)=?([^&]*)/g;

    function d(s) {
        return decodeURIComponent(s.replace(/\+/g, ' '));
    }
    var match, search = window.location.search;
    while (match = r.exec(search.substring(1)))
        params[d(match[1])] = d(match[2]);
    window.params = params;
})();

 // auto join room
if(params.roomid) {
    // 파라미터로 받은 방의 이름값이 있을경우
	joinbutton.disabled = true;
	//참가버튼 비활성화
	roomid.value = params.roomid;
	//파라미터로 받은 roomid의 값을 input roomid의 값에다 쳐박아둠
	roomid.disabled = true;
	//그리고 비활성화
    connection.join(params.roomid,function(isRoomJoined, roomid, error){
	//받은 파라미터 값으로 join 시도
			if(error){
				document.getElementById('btn-join-room').disabled = false;
				alert("해당 오류로 인해 접속할 수 없습니다.\n오류: "+error);
				/*
					var localvideo = document.getElementById("localvideo");
					var video = document.querySelector('#localvideo div')
				
					if(localvideo && localvideo.childNodes){
						localvideo.removeChild(video);
				}*/
				connection.closeSocket();
				return;
			}//일정시간마다 반복해주는 setInterval 함수 단위는 mill
			setInterval(function(){
				
				connection.getAllParticipants().forEach(function(participantId) {
				    var user = connection.peers[participantId];
					var hisUID = user.userid;

				});
				 
					var clnum = document.querySelector('#clientnumber');
					var numberOfUsers = connection.getAllParticipants().length;
					clnum.innerHTML = "구경꾼들: " + numberOfUsers +"명";;
				},1000);
	
		});
}







