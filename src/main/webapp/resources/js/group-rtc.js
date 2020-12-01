let localContainer = document.querySelector("div.local__video__area");
let videoContainer = document.querySelector("div.videos__area");
let opened = false;

let recordRTC;
let worker;
//let workerPath = 'https://localhost:8443/timewizard/js/ffmpeg_asm.js';
let workerPath = 'https://qclass.iptime.org:8443/timewizard/js/ffmpeg_asm.js';

let connection = new RTCMultiConnection();
connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';
connection.iceServers = [{
    'urls': [
    'stun:stun.l.google.com:19302',
    'stun:stun1.l.google.com:19302',
    'stun:stun2.l.google.com:19302',
    ]
}];
connection.iceServers.push({
    url: 'turn:numb.viagenie.ca',
    credential: 'muazkh',
    username: 'webrtc@live.com'
});
connection.session = {
 video: true
};
connection.sdpConstraints.mandatory = {
		OfferToReceiveAudio: true,
		OfferToReceiveVideio: true
};
connection.mediaConstraints = {
    video: {
        width: {
            ideal: 1920
        },
        height: {
            ideal: 1080
        },
        frameRate: 30
    },
    audio: true
}
connection.extra = {user_id: user_id, user_photo: user_photo};

/* delete confirm modal */
function closeFirstModal(){
	let modalArea = document.getElementsByClassName("modal__area")[0];
	modalArea.innerHTML = "";
}

function confirmDisconnect(){
	closeFirstModal();

	let modalArea = document.getElementsByClassName("modal__area")[0];
	
	let overlay_div = document.createElement("div");
	overlay_div.setAttribute("class","modal__overlay");
	overlay_div.setAttribute("onclick","closeFirstModal();");
	
	let close_div = document.createElement("div");
	close_div.setAttribute("class","modal__close");
	
	let close_button = document.createElement("button");
	close_button.setAttribute("type","button");
	close_button.setAttribute("class","button__times");
	close_button.setAttribute("onclick","closeFirstModal();");
	let times = document.createElement("i");
	times.setAttribute("class", "fas fa-times");
	close_button.appendChild(times);
	
	let except_button_div = document.createElement("div");
	except_button_div.setAttribute("class","close");

	let title_img = document.createElement("img");
	title_img.setAttribute("class","img__caution");
	title_img.setAttribute("src","/timewizard/image/logo_star_accent.svg");
	
	let content_div = document.createElement("div");
	
	let buttons_div = document.createElement("div");
	buttons_div.setAttribute("class","buttons__cell")
	
	let yes_button = document.createElement("button");
	yes_button.setAttribute("type","button");
	yes_button.setAttribute("class","button__close");
	yes_button.textContent = "네"
	yes_button.setAttribute("onclick","disconnect();");
	
	let no_button = document.createElement("button");
	no_button.setAttribute("type","button");
	no_button.setAttribute("class","button__cancel");
	no_button.textContent = "아니오"
		
	if (opened) {
		content_div.textContent = "영상을 저장 후 종료하시겠습니까?";
		// 마이페이지에서 다운로드 받을 수 있다는 안내문구를 넣고 싶은데 br은 싫고...흠
		yes_button.setAttribute("onclick","uploadRecording();");
		no_button.setAttribute("onclick","stopRecording(); disconnect();")
	} else {
		content_div.textContent = "종료하시겠습니까?";
		yes_button.setAttribute("onclick","disconnect();")
		no_button.setAttribute("onclick","closeFirstModal();");
	}
	
	buttons_div.appendChild(yes_button);
	buttons_div.appendChild(no_button);
	except_button_div.appendChild(title_img);
	except_button_div.appendChild(content_div);
	except_button_div.appendChild(buttons_div);
	close_div.appendChild(close_button);
	close_div.appendChild(except_button_div);
	modalArea.appendChild(overlay_div);
	modalArea.appendChild(close_div);
	
}

/* RecordRTC PART */
function startRecording(){
	connection.openOrJoin(roomid, function(isRoomCreated, roomid, error){
		if (error){
			alert("오류가 발생하여 방을 생성할 수 없습니다.\n오류: " + error);
			return;
		}
	});
	
	navigator.mediaDevices.getUserMedia({video:true})
	.then(function(stream){
		window.recordRTC = RecordRTC(stream, {type:'video'});
		window.recordRTC.startRecording();
		opened = true;
	})
	.catch(function(err){
		alert("오류가 발생하여 영상을 저장할 수 없습니다.\n"+err);
	});
}

function stopRecording(){
	opened = false;
	
	window.recordRTC.stopRecording(); // 종료시에 모달창이 떠서 그냥 끌 건지 저장 처리를 할지 선택??
	connection.closeSocket();
	connection.getAllParticipants().forEach(function(participantid){
		connection.disconnectWith(participantid);
	});
	connection.attachStreams.forEach(function(localStream) {
		localStream.stop();
	});
	connection.closeSocket();
}

function uploadRecording(){
	let modalArea = document.getElementsByClassName("modal__area")[0];
	modalArea.innerHTML = "";
	
	let overlay_div = document.createElement("div");
	overlay_div.setAttribute("class","modal__overlay");
	let close_div = document.createElement("div");
	close_div.setAttribute("class","modal__close");
	let except_button_div = document.createElement("div");
	except_button_div.setAttribute("class","close");
	let title_img = document.createElement("img");
	title_img.setAttribute("class","img__caution");
	title_img.setAttribute("src","/timewizard/image/logo_star_accent.svg");
	let content_div = document.createElement("div");
	content_div.textContent = "잠시만 기다려주세요";
	except_button_div.appendChild(title_img);
	except_button_div.appendChild(content_div);
	close_div.appendChild(except_button_div);
	modalArea.appendChild(overlay_div);
	modalArea.appendChild(close_div);
	
	window.recordRTC.stopRecording(function(url) {
		convertStreams(window.recordRTC.getBlob());
	});
}

function convertStreams(videoBlob) {
    let blobResult;
    let buffersReady;
    
    var fileReader = new FileReader();
    fileReader.onload = function() {
        blobResult = this.result;
        postMessage();
    };
    fileReader.readAsArrayBuffer(videoBlob);

    if (!worker) {
        worker = processInWebWorker();
    }

    worker.onmessage = function(event) {
        var message = event.data;
        if (message.type == "ready") {
            if (buffersReady)
                postMessage();
        } else if (message.type == "done") {
            var result = message.data[0];
            var blob = new File([result.data], 'test.mp4', {
                type: 'video/mp4'
            });

            uploadBlob(blob);
        }
    };
    var postMessage = function() {
        worker.postMessage({
            type: 'command',
            arguments: '-i video.webm -filter:v setpts=0.5*PTS -an -strict -2 output.mp4'.split(' '),
            files: [
                {
                    data: new Uint8Array(blobResult),
                    name: 'video.webm'
                }
            ]
        });
    };
}

function processInWebWorker() {
    let blob = URL.createObjectURL(new Blob(['importScripts("' + workerPath + '");var now = Date.now;function print(text) {postMessage({"type" : "stdout","data" : text});};onmessage = function(event) {var message = event.data;if (message.type === "command") {var Module = {print: print,printErr: print,files: message.files || [],arguments: message.arguments || [],TOTAL_MEMORY: message.TOTAL_MEMORY || false};postMessage({"type" : "start","data" : Module.arguments.join(" ")});postMessage({"type" : "stdout","data" : "Received command: " +Module.arguments.join(" ") +((Module.TOTAL_MEMORY) ? ".  Processing with " + Module.TOTAL_MEMORY + " bits." : "")});var time = now();var result = ffmpeg_run(Module);var totalTime = now() - time;postMessage({"type" : "stdout","data" : "Finished processing (took " + totalTime + "ms)"});postMessage({"type" : "done","data" : result,"time" : totalTime});}};postMessage({"type" : "ready"});'], {
        type: 'application/javascript'
    }));

    let worker = new Worker(blob);
    URL.revokeObjectURL(blob);
    return worker;
}

function uploadBlob(blob){
	let xhr = new XMLHttpRequest();
	let formData = new FormData();
	formData.append("file",blob);
	xhr.open("POST", "/timewizard/file/upload");
	xhr.send(formData);
	console.log("UPLOAD COMPLETE!");
	/* answer을 받아서 true가 되면 성공 메세지 띄우기! */
	xhr.onreadystatechange = () => {
		if (xhr.readyState == 4 && xhr.status == 200){
			if (JSON.parse(xhr.responseText).result == true){
				disconnect();
			}
		}
	}
}

connection.onstream = function(event){
	let existing = document.getElementById(event.streamid);
	if (existing && existing.parentNode) {
		existing.parentNode.removeChild(existing);
    }

    event.mediaElement.removeAttribute("src");
    event.mediaElement.removeAttribute("srcObject");
    event.mediaElement.muted = true;
    event.mediaElement.volume = 0;
	
    let video = document.createElement("video");

    try {
        video.setAttributeNode(document.createAttribute("autoplay"));
        video.setAttributeNode(document.createAttribute("playsinline"));
    } catch (e) {
        video.setAttribute("autoplay", true);
        video.setAttribute("playsinline", true);
    }

    video.volume = 0;
    
    try {
        video.setAttributeNode(document.createAttribute("muted"));
    } catch (e) {
        video.setAttribute("muted",true);
    }
    
    video.srcObject = event.stream;
    
	let mediaElement = document.createElement("div");
	mediaElement.setAttribute("class","media__container");
	let mediaElement_user = document.createElement("div");
	mediaElement_user.setAttribute("class","media__user__status");
	let userid_div = document.createElement("div");
	userid_div.setAttribute("class","user__id");
	userid_div.textContent = event.extra.user_id;
	
	
	let userphoto_img = document.createElement("img");
	let event_photo = (event.extra.user_photo == "null") ? "3J1kUZfY.jpg" : event.extra.user_photo;
	userphoto_img.setAttribute("src","/timewizard/image/" + event_photo);
	userphoto_img.setAttribute("class","user__photo");
	mediaElement_user.appendChild(userphoto_img);
	mediaElement_user.appendChild(userid_div);
	mediaElement.appendChild(mediaElement_user);
	mediaElement.appendChild(video);
	
	/* zoom mode, pip mode etc */
	
	// width 수정
	// connection.videosContainer 설정 안함
	// var width = parseInt(connection.videosContainer.clientWidth / 3) - 20;
	
    if (event.type == 'local'){
        localContainer.appendChild(mediaElement);
        localStorage.setItem("localSrc", event.stream);
    }
    if (event.type == 'remote'){
        let remote_div = document.createElement("div");
        remote_div.setAttribute("class","video__container remote");
        remote_div.id = event.streamid;
        remote_div.appendChild(mediaElement);
        videoContainer.appendChild(remote_div);
    }

    mediaElement.id = event.streamid;
    localStorage.setItem(connection.socketMessageEvent, connection.sessionid);
}

connection.onstreamended = function(event) {
    let video_container = document.getElementById(event.streamid);
    if (video_container && video_container.parentNode) {
        video_container.parentNode.removeChild(video_container);
    }
};

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