// 사용자가 답변 버튼을 클릭했을 때
// 서버로 바로 데이터가 날라가지 않도록 하는 기능
	var notice_no = document.getElementById("nno").value;
	var user_no = document.getElementById("user_no").value;

	function showReplyList(){

		//${pageContext.request.contextPath}
		var url = "/timewizard/reply/replylist";
		var paramData = {"notice_no" : notice_no};
		
		console.log(paramData);
		console.log(user_id);
	
		$.ajax({

            type: 'POST',

            url: url,

            data: paramData,

            dataType: 'json',

            success: function(result) {

               	var htmls = "";

			if(result.length < 1){

				htmls = "등록된 댓글이 없습니다.";

			} else {

					for(i in result){
						var uno = result[i].user_no;
						var reno = result[i].reply_no;
						var recon = result[i].reply_content;
						var redate = result[i].reply_regdate;
						var uid = result[i].user_id;
						var user_name = result[i].user_name;
						var rec = '\''+result[i].reply_content+'\'';
						var uname = '\''+result[i].user_name+'\'';
						
						console.log(result[i].user_no);
						
	                    /* htmls += '<div class="media text-muted pt-3" id="reply_no' + this.reply_no + '">';*/
						
						 htmls += '<div class="relist'+reno+'">';
						 htmls += '<div> ';
	                     htmls += '<p>';
	                     htmls += '<span class="d-block">';
	                     htmls += '<strong> User &#91; '+user_name+"	&#93; </strong>";
	                     htmls += '<p>Comment &nbsp; : &nbsp; '+recon +'</p>';
	                     htmls += '<h5>Date &nbsp; : '+ redate+'</h5>';
	                     htmls += '<span style="padding-left: 7px; font-size: 9pt">';
						 if(uno == user_no){
	                     	htmls += '<a href="javascript:void(0)" onclick="fn_editReply(' + reno + ',' + uno +','+ rec +','+ uname +' )" style="padding-right:5px">수정</a>';
	                     	htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply(' + reno + ')" >삭제</a>';
						 }
	                     htmls += '</span>';
	                     htmls += '</span>';
	                     htmls += '</p>';
	                     htmls += '<br>';    
	                     htmls += '</div>';
	                     htmls += '</div>';
	                     htmls += '<p style="border-top: 1px solid #ccc;"></p>';

	               
					}

			}

			$("#replyList").html(htmls);

                

            }	   // Ajax success end

		});	// Ajax end

	}
	
	
window.onload = function(){

	showReplyList();
}


