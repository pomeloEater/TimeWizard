<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TimeWizard :: error</title>
<script src="https://kit.fontawesome.com/3914a9940d.js" crossorigin="anonymous"></script>
<style type="text/css">
	.error {
		text-align: center;
		margin-top: 10%;
	}
	i.fas.fa-exclamation-triangle {
    	font-size: 5rem;
	}
	p:first-child {
    	font-weight: bold;
	}
</style>
</head>
<body>
	<div class="error">
		<h1><i class="fas fa-exclamation-triangle"></i></h1>
		<p>${message }</p>
	</div>
	<script type="text/javascript">
		window.addEventListener('DOMContentLoaded', () => {
			window.setTimeout(showMessage(), 2500);
			window.setTimeout(goToIndex, 5000);
		});
		function showMessage(){
			let message = document.createElement("p");
			message.textContent = "잠시 후 인덱스 화면으로 이동합니다";
			document.querySelector("div").appendChild(message);
		}
		function goToIndex(){
			location.href="/timewizard";
		}
	</script>
</body>
</html>