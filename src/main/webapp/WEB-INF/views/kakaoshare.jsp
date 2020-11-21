<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%request.setCharacterEncoding("UTF-8");%>
<%response.setContentType("text/html; charset=UTF-8");%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Kakao Sharing</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script src="resources/js/kakaoshare.js" defer></script>
<script src="resources/js/imgdownload.js" defer></script>
<link rel="stylesheet" type="text/css" href="resources/css/kakaoshare.css">
</head>
<body>

	<div>
	<img src="resources/image/park.JPG" alt="london park" width="400" height="200" id="kakao-link-btn" onclick="sendLink()">
	<button id="kakao-link-btn" onclick="sendLink()">공유하기</button>
	<button id="kakao-link-btn" onclick="dailyLink()">daily 공유</button>
	<button id="kakao-link-btn" onclick="etcLink()">weekly/monthly 공유</button>
	</div>
	
	
	<a id="download" download="hitmap.JPG">
	<button type="button" onClick="download()">Download</button>
	</a>
	
	
	<div style="background:red;" id="test">
		<div style="background:green;">
			<div style="background:blue;border-color:white;">
				<div style="background:yellow;">
					<div style="background:orange;">
					<img src="resources/image/paris.JPG" alt="paris" width="400" height="200">
						<h1>Heading</h1>
						Text that isn't wrapped in anything.
						<p>
						Followed by some text wrapped in a <b> paragraph.</b>
						</p>
						Maybe add a	<a href="#">link</a> or a different style of <a href="#" style="background:white;" id="highlight">link with a highlight</a>. <hr/>
						<h2>More content</h2>
						<div style="width:10px;height:10px;border-width:10px;padding:0;">
						a
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>