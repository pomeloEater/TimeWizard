//댓글 저장 버튼 클릭 이벤트

//Insert ( 댓글 추가 )
	var user_no = document.getElementById("user_no").value;
	

	$(document).on('click', '#insertReplyBtn', function(){
		
		
		var reply_content = $('#reply_content').val();
		var notice_no = document.getElementById("nno").value;
		var user_name = $("#user_name").val();

		console.log("reply_content: "+ reply_content +" / user_no: "+user_no+" / notice_no: "+notice_no);
	
			var paramData = {
				"reply_content": reply_content, "user_no": user_no, "notice_no":notice_no
		
		};
			console.log("paramData: "+paramData);

		



	

		$.ajax({
			url : "/timewizard/reply/insertreply"	
			//url: "reply/insertreply"
			, data : paramData
			, type : 'POST'
			, dataType : 'json'
				
			, success: function(result){
				
				console.log()
				url = "/timewizard/reply/replylist";

		$.ajax({

            type: 'POST',

            url: url,

            data: paramData,

            dataType: 'json',

            success: function(result) {

               	var htmls = "";
               	

	                    $(result).each(function(){
   	
	                    	 htmls += '<div class="reinsert">';
		                     htmls += '<span class="d-block">';
		                     htmls += '<strong> User &#91; '+this.user_name+"	&#93; </strong>";
		                     htmls += '<p>Comment &nbsp; : &nbsp;  ' +this.reply_content+'</p>';
		                     htmls += '<h5> Date &nbsp; : '+this.reply_regdate+'</h5>';
		                     htmls += '<span style="padding-left: 7px; font-size: 9pt">';
							 if(this.user_no == user_no){
		                     	htmls += '<a href="javascript:void(0)" onclick="fn_editReply(' + this.reply_no + ', \'' + this.user_no + '\', \'' + this.reply_content + '\' )" style="padding-right:5px" >수정</a>';
		                     	htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply(' + this.reply_no + ')">삭제</a>';
							 }
		                     htmls += '</span>';
		                     htmls += '</span>';
		                     htmls += '</p>';
		                     
		                     htmls += '<div>';
		                     htmls += '<p style="border-top: 1px solid #ccc;"></p>';


	                });	//each end




			$("#replyList").html(htmls);

                

            }	   // Ajax success end

		});	// Ajax end

				$('#reply_content').val('');

			}

			, error: function(error){

				console.log("에러 : " + error);

			}

		});

	});
	
//────────────────────────────────────────────────────────────────────────────────────────────────────
	
// Update( 댓글 수정 )
	function fn_editReply(reply_no, user_no, reply_content, user_name){
		
		
		var htmls = "";
		htmls += '<div class="media text-muted pt-3" id="reply_no' + reply_no + '">';
	
		htmls += '<span class="d-block">';
		htmls += '<strong> User &#91; '+user_name+"	&#93; </strong>";
		htmls += '<strong class="text-gray-dark">' + user_no + '</strong>';
		htmls += '<span style="padding-left: 7px; font-size: 9pt">';
		htmls += '<a href="javascript:void(0)" onclick="fn_updateReply(' + reply_no + ','+ user_no +')" style="padding-right:5px">저장</a>';
		htmls += '<a href="javascript:void(0)" onclick="showReplyList()">취소<a>';
		htmls += '</span>';
		htmls += '</span>';		
		htmls += '<textarea name="editContent" id="editContent" class="form-control" cols="30" style="width:100%; height:100%; resize:none">';
		htmls += reply_content;
		htmls += '</textarea>';		
		htmls += '</p>';
		htmls += '</div>';	
		$("div.relist"+reply_no).html(htmls);
		$("div.relist" + reply_no + ' #editContent').focus();

	}
	
	function fn_updateReply(reply_no, user_no){

		var replyEditContent = $('#editContent').val();

		

		var paramData = {
			"reply_content": replyEditContent,
			"reply_no": reply_no

		}

		console.log(paramData);
		


		

		$.ajax({

   			type: 'post',
			url: "/timewizard/reply/updatereply",
            data: JSON.stringify(paramData),
			contentType: "application/json",
            dataType: 'json',
			success: function(result){

                 

				showReplyList();

			}

			, error: function(error){

				console.log(error);

			}

		});

	}

	
//────────────────────────────────────────────────────────────────────────────────────────────────────
	
// Delete ( 댓글 삭제 )
 
	function fn_deleteReply(reply_no){
		if(confirm(" 해당 댓글을 삭제하시겠습니까?")==true){
			
		
		var paramData = {"reply_no": reply_no};

		

		$.ajax({

			url: "/timewizard/reply/deletereply"

			, data : paramData

			, type : 'POST'

			, dataType : 'text'

			, success: function(result){

				url = "/timewizard/reply/replylist";
			 	paramData = {"reply_no" : reply_no};
			 	showReplyList();

			}

			, error: function(error){

				console.log("에러 : " + error);

			}

		});
	}
	}
