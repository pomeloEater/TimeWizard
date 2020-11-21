var reflesh;
var loop;
$(document).ready(function () {
	
	roomlist();

});


function reset(){
	if(reflesh == "가능"){
	var gtitle = document.getElementById("search");
	gtitle.value = "";
	roomlist();
	}
}

var imgArray= new Array();
					imgArray[0]=1;
					imgArray[1]=2;
					imgArray[2]=3;
					imgArray[3]=4;
					imgArray[4]=5;
					
					function showImage() {
						var imgNum=Math.round(Math.random()*4+1);
						return imgNum;
					}

function searchRoom(){
	
	var gtitle = document.getElementById("search").value;
	console.log(gtitle);
	var paramdata = {
			"group_title": gtitle
	}
	if(gtitle == '' || gtitle.trim() == ''){
		alert("방 이름이나 사용자의 이름을 적어주세요.");
		
	}else{
	$.ajax({
	    type: "post",
	    url: "/timewizard/ajaxgroupselectlist",
	    data: JSON.stringify(paramdata),
	    dataType: "json",
	    contentType: "application/json",
	    success: function(data){
	    	var list = data.selectlist;
	    	$(".contentmain").empty();
	    	
	    	if(list == '' || list == 'undefined' || list == null){
	    		$(".contentmain").append("찾으시는 방이 존재하지 않습니다.");
	    	}else{
	     	for(i in list){
	    	
  				if(list[i].group_public == "공개"){
  					var name = list[i].group_title;
					var user_name = list[i].user_name;
					var user_id = list[i].user_id;
  					$(".contentmain").append(
  				"<div class='grouproom' onclick='location.href="+"\"joinroom/"+name+"\"'>"
					+"<div class='groupimg' style='background-image: url(/timewizard/image/groupimg" + showImage() + ".PNG)'>"
					+"</div>"
  					+"<div class='grouptitle'>"
  							+"<span class='group2'>"+name+"</span>"
  							+"</div>"
				+"<div class='groupmain'>"
							+"<span class='groupid'>"+user_id.substr(0,4)+"</span>"
							+"</div>"
  				+"<div class='groupmain'>"
							+"<span class='groupid'>"+user_name.substr(0,3)+"</span>"
							+"</div>"
				+"<div class='groupmain'>"
							+"<span class='groupid'>"+list[i].group_client+"/"+list[i].group_su+"</span>"
				+"</div>"
				+"<div style='width: 1rem'>"
				+"</div>"
  					
  					
  						);
   					}
	    		}
	    	}
	    
	    },
		error: function(data){
			$(".fixedmain").empty();
			$(".fixedmain").append("<p>연결이 끊겼습니다.</p>");
		}
	    	
	});
	reflesh = "가능";
	console.log("reflesh: "+reflesh);
	clearTimeout(loop);
	}
}
function roomlist(){
	$.ajax({
	    type: "post",
	    url: "/timewizard/ajaxgrouplist",
	    data: "",
	    dataType: "json",
	    contentType: "application/json",
	    success: function(data){
	    	var list = data.flist;
	    	$(".contentmain").empty();
	    	if(list == ''){
    			$(".contentmain").append('<p>방이 없습니다.</p>');
    		}else{
	     	for(i in list){
	    	
  				if(list[i].group_public == "공개"){
  					var name = list[i].group_title;
					var user_name = list[i].user_name;
					var user_id = list[i].user_id;
  					$(".contentmain").append(
  							"<div class='grouproom' onclick='location.href="+"\"joinroom/"+name+"\"'>"
  							+"<div class='groupimg' style='background-image: url(/timewizard/image/groupimg" + showImage() + ".PNG)'>"
  							+"</div>"
  		  					+"<div class='grouptitle'>"
  		  							+"<span class='group2'>"+name+"</span>"
  		  							+"</div>"
						+"<div class='groupmain'>"
							+"<span class='groupid'>"+user_id.substr(0,4)+"</span>"
							+"</div>"
  		  				+"<div class='groupmain'>"
  									+"<span class='groupid'>"+user_name.substr(0,3)+"</span>"
  									+"</div>"
  						+"<div class='groupmain'>"
  									+"<span class='groupid'>"+list[i].group_client+"/"+list[i].group_su+"</span>"
  						+"</div>"
  						+"<div style='width: 1rem'>"
  						+"</div>"
  					
  					
  						);
   					}
  				}
	    	}
	    
	    },
		error: function(data){
			$(".contentmain").empty();
			$(".contentmain").append("<p>연결이 끊겼습니다.</p>");
		}
	    	
	});
	reflesh = "불가능";
	loop = setTimeout("roomlist()", 3000);
	
}

function enterkey(){
	if (window.event.keyCode == 13) {
		searchRoom();
	}
	
}


