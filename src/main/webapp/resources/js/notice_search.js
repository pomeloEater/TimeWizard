$(document).on('click', '#search_button', function(e){
	var url="${pageContext.request.contextPath}/notice";
	url = url+"?searchType="+$('#searchType').val();
	url = url+"&keyword="+$('#search_text').val();
	//url = url+"&nowpage="+${paging.nowpage}+"&cntPerpage="+${paging.cntPerpage};
	location.href=url;
	console.log(url);
	
});