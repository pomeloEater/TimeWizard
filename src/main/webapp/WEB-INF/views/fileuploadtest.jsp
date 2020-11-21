<%@page import="com.minibean.timewizard.model.dto.UserInfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/3914a9940d.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="/timewizard/js/file_upload.js"></script>
</head>
<body>
<%
	UserInfoDto login = (UserInfoDto) session.getAttribute("login");
	int user_no = login.getUser_no();
%>
	<form:form action="file/upload" enctype="multipart/form-data" modelAttribute="FileUploadDto">
		<input type="file" name="file" accept="image/*" />
		<input type="hidden" name="user_no" value="<%=user_no%>" />
		<button type="button" value="send" onclick="uploadFile();">UPLOAD</button>
	</form:form>
	
	<div class="files__area"></div>
	
	<script type="text/javascript">
	let user_no = <%=user_no%>;
	window.addEventListener("DOMContentLoaded", ()=>{
		selectList(user_no);
		// selectOne(user_no);
	});

	function uploadFile(){
		let fileInput = document.querySelector("[name=file]");
		let file = fileInput.files[0];
		let formData = new FormData();
		formData.append("file",file);
		const xhr = new XMLHttpRequest();
		xhr.open("POST","/timewizard/file/upload");
		xhr.send(formData);
		xhr.onreadystatechange = () => {
			if (xhr.readyState == 4 && xhr.status == 200){
				if (JSON.parse(xhr.responseText).result == true){
					selectList(user_no);
				}
			}
		}
	}
	function selectList(user_no){
		let filesArea = document.querySelector(".files__area");
		filesArea.innerHTML = "";
		const xhr = new XMLHttpRequest();
		xhr.open("POST","/timewizard/file/list/"+user_no);
		xhr.send();
		xhr.onreadystatechange = () => {
			if (xhr.readyState == 4 && xhr.status == 200){
				if (xhr.responseText != null && xhr.responseText != "" && xhr.responseText != '[]'){
					console.log(JSON.parse(xhr.responseText));
					let files = JSON.parse(xhr.responseText);
					let i = 0;
					
					let files_div = document.createElement("div");
					files_div.setAttribute("class","files");
					
					for (i = 0; i < files.length; i++){
						let file_div = document.createElement("div");
						file_div.setAttribute("class","file");
						
						let number_cell = document.createElement("div");
						number_cell.setAttribute("class","cell number__cell");
						let number_cell_span = document.createElement("span");
						number_cell_span.setAttribute("class", "number");
						number_cell_span.textContent = i + 1;
						number_cell.appendChild(number_cell_span);
						
						let title_cell = document.createElement("div");
						title_cell.setAttribute("class","cell title__cell");
						let title = document.createElement("p");
						title.textContent = files[i].file_name;
						title_cell.appendChild(title);
						
						let download_cell = document.createElement("div");
						download_cell.setAttribute("class","cell download__cell");
						/*
						if (user_no == files[i].user_no){
							download_cell.setAttribute("onclick","downloadFile("+ files[i].file_no + ");")
						}
						let file_download = document.createElement("i");
						file_download.setAttribute("class","fas fa-file-download");
						download_cell.appendChild(file_download);
						 */
						let form = document.createElement("form");
						form.setAttribute("action","/timewizard/file/download/"+files[i].file_no);
						form.setAttribute("method","POST");
						let submit = document.createElement("input");
						submit.setAttribute("type","submit");
						submit.setAttribute("value","download");
						form.appendChild(submit);
						download_cell.appendChild(form);
						
						file_div.appendChild(number_cell);
						file_div.appendChild(title_cell);
						file_div.appendChild(download_cell);
						files_div.appendChild(file_div)
					}
					filesArea.appendChild(files_div);
					
				} else if (xhr.responseText == '[]'){
					filesArea.textContent = "저장된 파일이 없습니다.";
				}
			}
		}
	}
	
	function downloadFile(file_no){
		const xhr = new XMLHttpRequest();
		xhr.open("POST","/timewizard/file/download/"+file_no);
		xhr.send();
		xhr.onreadystatechange = () => {
			if (xhr.readyState == 4 && xhr.status == 200){
				if (xhr.responseText != null && xhr.responseText  != "" && xhr.responseText != '[]'){
					/*
					let item = JSON.parse(xhr.responseText);
					console.log(item);
					let blob = new Blob([item.bytes], {type: item.mime});
					console.log(blob);
					let link = document.createElement("a");
					link.href = window.URL.createObjectURL(blob);
					let fileName = "timewizard_" + new Date().getTime();
					link.download = fileName + "." + item.extension;
					link.click();
					 */
					return xhr.responseText;
				} /* not empty responseText */
			} /* readyState 4 status 200 */
		} /* onreadystatechange */
	}
	</script>
</body>
</html>