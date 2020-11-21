<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TimeWizard</title>

<link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@700&display=swap" rel="stylesheet">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link href="/timewizard/css/actionpage.css" rel="stylesheet">
<link href="/timewizard/css/friends.css" rel="stylesheet">

<style>

	.friendsbar {
		font-family: 'Gothic A1';
	}

</style>

<script type="text/javascript">
var iconDataURI = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAKBJREFUeNpiYBjpgBFd4P///wJAaj0QO9DEQiAg5ID9tLIcmwMYsDgABhqoaTHMUHRxpsGYBv5TGqTIZsDkYWLo6gc8BEYdMOqAUQeMOoAqDgAWcgZAfB9EU63SIAGALH8PZb+H8v+jVz64KiOK6wIg+ADEArj4hOoCajiAqMpqtDIadcCoA0YdQIoDDtCqQ4KtBY3NAYG0csQowAYAAgwAgSqbls5coPEAAAAASUVORK5CYII=";
var sock;
var nickname;
var client;
var uname = '${login.user_name}'
var fno;
var uno = ${login.user_no};
var friendval = {
		"user_no": uno
	}
var flist;
var nlist;


function searchfriend(){
var url = location.href;
var inviteurl = "\""+url.split("/timewizard")[1]+"\"";
var username = $("#search_text").val();
var searchval = {
			"user_name": username,
			"user_no": uno
		}
	$.ajax({
	    type: "post",
	    url: "/timewizard/searchList",
	    data: JSON.stringify(searchval),
	    dataType: "json",
	    contentType: "application/json",
	    success: function(data){
	    	searchList = data.searchList;
	    	searchListN = data.searchListN;
	    	$(".userlist").empty();
	    	$(".userlist").append("<p><b>Search List</b></p>");
	    	if(searchList == ''){
	    		$(".userlist").append("<p>-- 검색하신 분을 찾지 못했습니다. --</p>")
	    	}else if(username.trim() == ''){
	    		$(".userlist").append("<p>-- 이름을 입력해주세요. --</p>");
	    	}
	    	else{
	    		for(i in searchList){
	    			var user_name = searchList[i].user_name; // 상대방 이름
	    			var name = "\""+searchList[i].user_name+"\""; //값으로 쓸 상대방 이름(이스케이프 문자)
	    			var user_no = searchList[i].user_no; //상대방 번호
	    			var friend_no = searchList[i].friend_no; //자기번호
	    			var status = searchList[i].status; //관계 상태(수락, 응답중, 전송)
	    			var dist = searchList[i].user_distinct;
	    			console.log(dist);
	    			
	    			if(url.indexOf("joinroom")!= -1){
	    				if(status == "ACCEPT" && (friend_no == uno)){
	    					$(".userlist").append("<p><a href='/timewizard/user/"+dist+"'>"+ user_name +
	    					"</a><button class='accdeny'onclick='deletefriend("+user_no+","+ uno +","+name+")'><i class='fas fa-user-slash'></i></button>"+
			    			"<button class='accdeny'onclick='invitefriend("+user_no+","+ uno +","+inviteurl+","+name+")'><i class='far fa-envelope'></i>"+"</button></p>");
	    				}
	    				else if(status == "RESP" && (friend_no == uno)){
	    					$(".userlist").append("<p><a href='/timewizard/user/"+dist+"'>"+ user_name +"</a>님이 친구신청 하셨습니다."+
	    							"<button class='accdeny' onclick='friendDeny("+user_no+","+name+")'> <i class='fas fa-user-times'></i></button>"
	    		    				+" <button class='accdeny' onclick='friendAccept("+user_no+")'><i class='fas fa-user-check'></i></button></p>");
	    				
	    				}else if(status == "SEND" && (friend_no == uno)){
	    		
	    					$(".userlist").append("<p><a href='/timewizard/user/"+dist+"'>"+user_name +"</a>님이 응답중 입니다.</p>");
	    				}
	    			}else{
	    				if(status == "ACCEPT" && (friend_no == uno)){
	    					$(".userlist").append("<p><a href='/timewizard/user/"+dist+"'>"+ user_name +
	    							"</a><button class='accdeny'onclick='deletefriend("+user_no+","+ uno +","+name+")'><i class='fas fa-user-slash'></i></button></p>");
	    				}
	    				else if(status == "RESP" && (friend_no == uno)){
	    					$(".userlist").append("<p><a href='/timewizard/user/"+dist+"'>"+ user_name +"</a>님이 친구신청 하셨습니다."+
	    							"<button class='accdeny' onclick='friendDeny("+user_no+","+name+")'> <i class='fas fa-user-times'></i></button>"
	    		    				+" <button class='accdeny' onclick='friendAccept("+user_no+")'><i class='fas fa-user-check'></i></button></p>");
	    				
	    				}else if(status == "SEND" && (friend_no == uno)){
	    		
	    					$(".userlist").append("<p><a href='/timewizard/user/"+dist+"'>"+user_name +"</a>님이 응답중 입니다.</p>");
	    				}
	    				
	    			}
	    		}
	    		for(i in searchListN){
	    			var user_name = searchListN[i].user_name;
	    			var name = "\""+searchListN[i].user_name+"\"";
	    			var user_no = searchList[i].user_no;
	    			console.log(searchListN[i]);
	    			var dist =  searchList[i].user_distinct;
	    			if(searchListN[i].user_role == "ADMIN"){
	    				$(".userlist").append("<p><a href='/timewizard/user/"+dist+"'>"+ user_name+ "</a></p>");
	    			}else{
	    			$(".userlist").append("<p><a href='/timewizard/user/"+dist+"'>"+ user_name +
				    		"</a><button class='accdeny' onclick='alertsys("+user_no+","+ uno +","+name+")'><i class='fas fa-user-plus'></i></button></p>");
	    			}
	    		}
	    	}
	    },
	    error: function(data){
	    	$(".friendsbar").append("연결이 끊겼습니다.");
	    }
	});
}
function reset(){
	var uname = $("#search_text");
	$(uname).val("");
	friendlist();
	
}

function friendlist(){
	var url = location.href;
	var inviteurl = "\""+url.split("/timewizard")[1]+"\"";
	$.ajax({
	    type: "post",
	    url: "/timewizard/friend",
	    dataType: "json",
	    data: JSON.stringify(friendval),
	    contentType: "application/json",
	    success: function(data){
	    	$("#search_text").val("");
	    	flist = data.flist;
	    	nlist = data.nlist;
	    	$(".friendlist").empty();
	    	$(".userlist").empty();
	    	console.log(flist);
	    	if(flist == ''){
	    		$(".friendlist").append("<h5>친구목록이 없습니다</h5>")
	    	}else{
	    		for(i in flist){
	    			var user_name = flist[i].user_name;
	    			var name = "\""+flist[i].user_name+"\"";
	    			var user_no = flist[i].user_no;
	    			var dist =  flist[i].user_distinct;
	    			var friend_no  = flist[i].friend_no;
	    			if(url.indexOf("joinroom")!= -1){
	    				if((flist[i].status == "ACCEPT")){
	    					$(".friendlist").append("<p><a href='/timewizard/user/"+dist+"'>"+ user_name +
	    					"</a><button class='accdeny'onclick='deletefriend("+user_no+","+ uno +","+name+")'><i class='fas fa-user-slash'></i></button>"+
			    			"<button class='accdeny'onclick='invitefriend("+user_no+","+ uno +","+inviteurl+","+name+")'><i class='far fa-envelope'></i>"+"</button></p>");
	    				}else if(flist[i].status == "SEND"){
	    					$(".friendlist").append("<p><a href='/timewizard/user/"+dist+"'>"+ user_name +"</a>님이 응답중 입니다.</p>");
	    	    					
	    	    		}else if(flist[i].status == "RESP"){
		    					$(".friendlist").append("<p><a href='/timewizard/user/"+dist+"'>"+ user_name +"</a>님이 친구신청 하셨습니다."+
		    							"<button class='accdeny' onclick='friendDeny("+user_no+","+name+")'> <i class='fas fa-user-times'></i></button>"
		    		    				+" <button class='accdeny' onclick='friendAccept("+user_no+")'><i class='fas fa-user-check'></i></button></p>");
		    			}
	    			}
	    			else {
		    			if((flist[i].status == "ACCEPT")){
		    					$(".friendlist").append("<p><a href='/timewizard/user/"+dist+"'>"+user_name
		    					+"</a><button class='accdeny'onclick='deletefriend("+user_no+","+ uno +","+name+")'><i class='fas fa-user-slash'></i></button></p>");
		    			}else if(flist[i].status == "SEND"){
	    					$(".friendlist").append("<p><a href='/timewizard/user/"+dist+"'>"+ user_name +"</a>님이 응답중 입니다.</p>");
	    	    					
	    	    		}else if(flist[i].status == "RESP"){
		    					$(".friendlist").append("<p><a href='/timewizard/user/"+dist+"'>"+ user_name +"</a>님이 친구신청 하셨습니다."+
		    							"<button class='accdeny' onclick='friendDeny("+user_no+","+name+")'> <i class='fas fa-user-times'></i></button>"
		    		    				+" <button class='accdeny' onclick='friendAccept("+user_no+")'><i class='fas fa-user-check'></i></button></p>");
		    				}
		    			}
	    		}
	    		
	    	}
	    	$(".userlist").append("<h5>알 수도 있는 사람</h5>");
	    	if(nlist == ''){
	    		$(".userlist").append("<p>-- 당신은 인싸>_&lt; --</p>");
	    	}else{
	    		for(i in nlist){
	    			var name = "\""+nlist[i].user_name+"\"";
	    			var dist =  nlist[i].user_distinct;
	    			console.log(nlist[i].user_role);
	    			if(nlist[i].user_role == "ADMIN"){
	    				$(".userlist").append("<p><a href='/timewizard/user/"+dist+"'>"+ nlist[i].user_name+"</a></p>");
	    			}else{
	    				$(".userlist").append("<p><a href='/timewizard/user/"+dist+"'>"+ nlist[i].user_name+"&nbsp;"+
	    					"</a><button class='accdeny' onclick='alertsys("+nlist[i].user_no+","+ uno +","+name+")'><i class='fas fa-user-plus'></i>" +"</button></p>");
	    			}
	    		}
	    	
	    	}
	    	
	    },
	    error: function(data){
	    	$(".friendsbar").append("연결이 끊겼습니다.");
	    }
	});
}

</script>
</head>
<body>

<aside class="friendsbar">
		<input type="text" placeholder="search.." id="search_text" onkeyup="searchkey();" />
		<button id="search_button" class="searchbtn" onclick="reset();">
			<i class="fas fa-sync"></i>
		</button>
		<button id="search_button" class="searchbtn" onclick="searchfriend();"><i class="fas fa-search" ></i>
		</button>
		<h5 style="margin-left:2px;">친구목록</h5>
		<!-- 나와 친구인 유저들 -->
		<div class="friendlist">
		
	
		
		</div>
		
		<div class="userlist">
		
		
		
		</div>
		
		
	</aside>


<script type="text/javascript" src="https://cdn.jsdelivr.net/sockjs/latest/sockjs.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>

<script type="text/javascript">
var reconnect = 0;
var uno = ${login.user_no};
	//handler에서 정해준 서버 겅로로 설정
	sock = new SockJS("/timewizard/webserver");
	// SockJS로 연결한 웹소켓 주소에 Stomp을 씌움
	client = Stomp.over(sock)
	
	 Notification.requestPermission(function (result) {

        //요청을 거절하면,
        
        if (result === 'denied') {
        	console.log("알림이 비활성화 되었습니다.");
            return;
        }
        //요청을 허용하면,
        else {
        	console.log("알림이 활성화 되었습니다.");
            return;
        }
    });
	//연결 했을시,
	client.connect({}, function(){
		friendlist();
	    client.subscribe("/subscribe/alert/good/"+uno, function (data) {
	    	var fnd = JSON.parse(data.body);
	    	var fnd_name = fnd['user_name'];
	    	var message = fnd_name+"님이 친구 신청을 하셨습니다.";
	    	var fno = fnd["user_no"];
	        var options = {
	            body: message,
	            icon: iconDataURI
	        }
	        //데스크탑 알림 요청
	        var sendalert = new Notification("알람", options);
	        
	      //알림 후 1초 뒤 친구목록 다시 불러옴
	        setTimeout(function () {
	            //알람 메시지 닫기
	            friendlist();
	            //sendalert.close();
	        	}, 1000);
	        sendalert.onclick= function(){
	        	window.open('/timewizard/main');
	        };
	    });
	    client.subscribe("/subscribe/confirm/check/"+uno, function (data) {
				
	    	var chk = data.body;
 			var message = chk+"님이 친구추가를 수락하셨습니다.";
 				options = {
 		            body: message,
 		            icon: iconDataURI
 		        }
 			var checkalert = new Notification("친구 수락", options);
	        
 				//알림 후 1초 뒤 친구목록 다시 불러옴
	        setTimeout(function () {
	            //얼람 메시지 닫기
	             friendlist();
	            //checkalert.close();
	           
	       	 	}, 1000); 		
	       		checkalert.onclick = function(){ 
	       			window.open('/timewizard/main');
	       	
	       		};
	       
	    	})
	    	client.subscribe("/subscribe/confirm/denychk/"+uno, function(data){
	    		var chk = data.body;
	 			var message = chk+"님이 친구신청을 거절하셨습니다.";
	 				options = {
	 		            body: message,
	 		            icon: iconDataURI
	 		        }
	 			var checkalert = new Notification("알림", options);
		        
	 				//알림 후 1초 뒤 친구목록 다시 불러옴
		        setTimeout(function () {
		            //얼람 메시지 닫기
		            friendlist();
		            //checkalert.close();
		           
		       	 	}, 1000); 		
		        checkalert.onclick = function(){
		     		window.open('/timewizard/main');
		     	};
		        
	    	});
	    client.subscribe("/subscribe/confirm/deletechk/"+uno, function(data){
    		var chk = data.body;
 			var message = chk+"님이 친구목록에서 삭제하셨습니다.";
 				options = {
 		            body: message,
 		            icon: iconDataURI
 		        }
 			var resalert = new Notification("알림", options);
	        
 				//알림 후 1초 뒤 친구목록 다시 불러옴
	        setTimeout(function () {
	            //얼람 메시지 닫기
	            friendlist();
	            //checkalert.close();
	           
	       	 	}, 1000); 		
	       		resalert.onclick = function(){
	     			window.open('/timewizard/main');
	     		};
	        
    		});
	    client.subscribe("/subscribe/invite/res/"+uno, function(data){
    		var chk = JSON.parse(data.body);
    		var name = chk['user_name']
 			var message = name+"님이 초대장을 보내셧습니다.";
 				options = {
 		            body: message,
 		            icon: iconDataURI
 		        }
 			var resalert = new Notification("알림", options);
 				resalert.onclick = function (){
 					window.open("/timewizard/main");
 				}
 				//알림 후 1초 뒤 친구목록 다시 불러옴
	        setTimeout(function () {
	            //얼람 메시지 닫기
	            friendlist();
	            //checkalert.close();
	           	var check = confirm(name+"님의 초대를 수락하시겟습니까?");
	           		if(check){
	           			location.href = /timewizard/+chk['url']
	           		}else{
	           			
	           		}
	       	 	}, 3000); 		
	        
    		});
		}, function(error){
			var count = 1;
			$('.friendlist').append("<p>연결이 끊겼습니다.</p>");
			if(reconnect ++ <= 10){
				setTimeout(function (){
					var count = 1;
					$('.friendlist').empty();
					$('.friendlist').append("<p>연결이 끊겼습니다. 재시도: "+count+"</p>");
					sock = new SockJS("/timewizard/webserver");
					// SockJS로 연결한 웹소켓 주소에 Stomp을 씌움
					client = Stomp.over(sock);
					connect();
				},2*1000)		
			}
			
		});
	
function alertsys(fno, mynum, fname){
			var notification;
		    var message = fname+"님에게 친구신청을 보냈습니다.";
	        
	        var options = {
	            body: message,
	            icon: iconDataURI
	        }
	       
	        var chk = confirm(fname+'님을 친구추가 하시겠습니까?');
	        if(chk){
	        	//데스크탑 알림 요청
	       		notification = new Notification("친구신청" ,options);
	       		alert("친구추가 메세지를 전송했습니다.");
	       		client.send("/publish/alert/friend", {},JSON.stringify({friend_no: fno, user_no: mynum, user_name: fname}));
	       	//알림 후 1초 뒤 친구목록 다시 불러옴
	        	setTimeout(function () {

	          	 friendlist();
	   
	           
	      	  }, 1000);
	        	 
				
	        	
	        }else{
	        	alert("친구추가 메세지 전송을 취소했습니다.");
	        	
	        }
	        notification.onclick = function (){
        		window.open("/timewizard/main");
        	};
	}
	
function deletefriend(fno,myno,fname){
	

	var rly = confirm(fname + "님을 목록에서 삭제하시겠습니까?");
		var deletealert;
		if (rly) {
			var message = fname + "님이 목록에서 삭제되었습니다.";

			options = {
				body : message,
				icon : iconDataURI
			}
			//데스크탑 알림 요청
			deletealert = new Notification("친구삭제", options);
			client.send("/publish/confirm/delete", {}, JSON.stringify({
				user_no : myno,
				friend_no : fno
			}));

			//알림 후 1초 뒤 친구목록 다시 불러옴
			setTimeout(function() {
				friendlist();
				//얼람 메시지 닫기
				//deletealert.close();

			}, 1000);

		} else {
			alert("친구삭제를 취소하셨습니다.");
		}
		deletealert.onclick = function() {
			window.open("/timewizard/main");
		}
	}

	function friendAccept(fno) {

		client.send("/publish/confirm/accept", {}, JSON.stringify({
			friend_no : fno,
			user_no : uno,
			user_name : uname
		}));
		client.subscribe("/subscribe/confirm/res/" + uno, function(chat) {
			var added = chat.body;
			var message = added + "님과 이제 친구입니다";
			var options = {
				body : message,
				icon : iconDataURI
			}
			var acceptalert = new Notification("친구추가 수락", options);

			//알림 후 1초 뒤 친구목록 다시 불러옴
			setTimeout(function() {
				//얼람 메시지 닫기
				friendlist();
				//acceptalert.close();

			}, 1000);
			acceptalert.onclick = function() {
				window.open("/timewizard/main");
			}
			client.send("/publish/confirm/fnd", {}, JSON.stringify({
				user_no : uno,
				friend_no : fno,
				user_name : uname
			}));

		})

	}

	function friendDeny(fno, fname) {
		//"거절"을 누르면 FriendControlller로 보내서 update, delete시키기
		//ajax로?

		var message = fname + "님의 친구 신청을 거절하셨습니다.";

		var options = {
			body : message,
			icon : iconDataURI
		}
		//데스크탑 알림 요청
		var denyalert = new Notification("알람", options);
		client.send("/publish/confirm/deny", {}, JSON.stringify({
			friend_no : fno,
			user_no : uno,
			user_name : fname
		}));

		//알림 후 1초 뒤 친구목록 다시 불러옴
		setTimeout(function() {
			//얼람 메시지 닫기
			friendlist();
			//denyalert.close();

		}, 1000);
		denyalert.onclick = function() {
			window.open("/timewizard/main");
		}

	}
	function searchkey() {
		if (window.event.keyCode == 13) {
			searchfriend();
		}

	}
	function invitefriend(user_no, uno, url, name) {

		var message = name + "님에게 초대를 보냈습니다.";

		var options = {
			body : message,
			icon : iconDataURI
		}
		//데스크탑 알림 요청
		var denyalert = new Notification("알람", options);
		client.send("/publish/invite/send", {}, JSON.stringify({
			friend_no : user_no,
			user_no : uno,
			url : url,
			user_name : uname
		}));

		//알림 후 1초 뒤 친구목록 다시 불러옴
		setTimeout(function() {
			//얼람 메시지 닫기
			friendlist();
			//denyalert.close();

		}, 1000);
		denyalert.onclick = function() {
			window.open('/timewizard/main');
		};

	}
	
function connect(){
	client.connect({}, function(){
		friendlist();
	    client.subscribe("/subscribe/alert/good/"+uno, function (data) {
	    	var fnd = JSON.parse(data.body);
	    	var fnd_name = fnd['user_name'];
	    	var message = fnd_name+"님이 친구 신청을 하셨습니다.";
	    	var fno = fnd["user_no"];
	        var options = {
	            body: message,
	            icon: iconDataURI
	        }
	        //데스크탑 알림 요청
	        var sendalert = new Notification("알람", options);
	        
	      //알림 후 1초 뒤 친구목록 다시 불러옴
	        setTimeout(function () {
	            //알람 메시지 닫기
	            friendlist();
	            //sendalert.close();
	        	}, 1000);
	        sendalert.onclick= function(){
	        	window.open('/timewizard/main');
	        };
	    });
	    client.subscribe("/subscribe/confirm/check/"+uno, function (data) {
				
	    	var chk = data.body;
 			var message = chk+"님이 친구추가를 수락하셨습니다.";
 				options = {
 		            body: message,
 		            icon: iconDataURI
 		        }
 			var checkalert = new Notification("친구 수락", options);
	        
 				//알림 후 1초 뒤 친구목록 다시 불러옴
	        setTimeout(function () {
	            //얼람 메시지 닫기
	             friendlist();
	            //checkalert.close();
	           
	       	 	}, 1000); 		
	       		checkalert.onclick = function(){ 
	       			window.open('/timewizard/main');
	       	
	       		};
	       
	    	})
	    	client.subscribe("/subscribe/confirm/denychk/"+uno, function(data){
	    		var chk = data.body;
	 			var message = chk+"님이 친구신청을 거절하셨습니다.";
	 				options = {
	 		            body: message,
	 		            icon: iconDataURI
	 		        }
	 			var checkalert = new Notification("알림", options);
		        
	 				//알림 후 1초 뒤 친구목록 다시 불러옴
		        setTimeout(function () {
		            //얼람 메시지 닫기
		            friendlist();
		            //checkalert.close();
		           
		       	 	}, 1000); 		
		        checkalert.onclick = function(){
		     		window.open('/timewizard/main');
		     	};
		        
	    	});
	    client.subscribe("/subscribe/confirm/deletechk/"+uno, function(data){
    		var chk = data.body;
 			var message = chk+"님이 친구목록에서 삭제하셨습니다.";
 				options = {
 		            body: message,
 		            icon: iconDataURI
 		        }
 			var resalert = new Notification("알림", options);
	        
 				//알림 후 1초 뒤 친구목록 다시 불러옴
	        setTimeout(function () {
	            //얼람 메시지 닫기
	            friendlist();
	            //checkalert.close();
	           
	       	 	}, 1000); 		
	       		resalert.onclick = function(){
	     			window.open('/timewizard/main');
	     		};
	        
    		});
	    client.subscribe("/subscribe/invite/res/"+uno, function(data){
    		var chk = JSON.parse(data.body);
    		var name = chk['user_name']
 			var message = name+"님이 초대장을 보내셧습니다.";
 				options = {
 		            body: message,
 		            icon: iconDataURI
 		        }
 			var resalert = new Notification("알림", options);
 				resalert.onclick = function (){
 					window.open("/timewizard/main");
 				}
 				//알림 후 1초 뒤 친구목록 다시 불러옴
	        setTimeout(function () {
	            //얼람 메시지 닫기
	            friendlist();
	            //checkalert.close();
	           	var check = confirm(name+"님의 초대를 수락하시겟습니까?");
	           		if(check){
	           			location.href = /timewizard/+chk['url']
	           		}else{
	           			
	           		}
	       	 	}, 3000); 		
	        
    		});
		}, function(error){
			var count = 1;
			$('.friendlist').append("<p>연결이 끊겼습니다.</p>");
			if(reconnect ++ <= 10){
				setTimeout(function (){
					var count = 2;
					$('.friendlist').empty();
					$('.friendlist').append("<p>연결이 끊겼습니다. 재시도: "+count+"</p>");
					sock = new SockJS("/timewizard/webserver");
					count++;
					// SockJS로 연결한 웹소켓 주소에 Stomp을 씌움
					client = Stomp.over(sock);
				},2*1000)		
			}
			
		});
	
}
</script>
</body>
</html>
