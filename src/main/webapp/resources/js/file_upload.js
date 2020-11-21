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
				selectOne(user_no);
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
			}
		}
	}
}

function selectList(user_no){
	let files_div = document.querySelector(".files");
	files_div.innerHTML = "";
	const xhr = new XMLHttpRequest();
	xhr.open("POST","/timewizard/file/list/"+user_no);
	xhr.send();
	xhr.onreadystatechange = () => {
		if (xhr.readyState == 4 && xhr.status == 200){
			if (xhr.responseText != null && xhr.responseText != "" && xhr.responseText != '[]'){
				let files = JSON.parse(xhr.responseText);
				let i = 0;
				
				for (i = 0; i < files.length; i++){
					let file_div = document.createElement("div");
					file_div.setAttribute("class","file");
					
					let number_cell = document.createElement("div");
					number_cell.setAttribute("class","cell number__cell");
					let number_cell_span = document.createElement("span");
					number_cell_span.setAttribute("class", "number");
					number_cell_span.textContent = i + 1;
					number_cell.appendChild(number_cell_span);
					
					/*
					let title_cell = document.createElement("div");
					title_cell.setAttribute("class","cell title__cell");
					let title = document.createElement("p");
					title.textContent = files[i].file_name;
					title_cell.appendChild(title);
					*/
					
					let title_cell = document.createElement("div");
					title_cell.setAttribute("class","cell title__cell");
					let title = document.createElement("p");
					let temp = new Date(files[i].file_regdate);
					title.textContent = temp.toISOString().slice(0,16).replace('T',' ');
					/* 형식 체크하기 */
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
					form.setAttribute("class","download__form");
					if (timelapse != 0){
						form.setAttribute("action","/timewizard/file/download/"+files[i].file_no);
						form.setAttribute("method","POST");
						form.setAttribute("onsubmit","setTimeout(function(){window.location.reload();},1000);");
					}
					let submit = document.createElement("input");
					submit.setAttribute("type","submit");
//					submit.setAttribute("type","button");
					submit.setAttribute("class","download__button");
					submit.setAttribute("value","download");
					if (timelapse == 0){
						submit.setAttribute("onclick","alertMessage();");
					}
					form.appendChild(submit);
					download_cell.appendChild(form);
					
					file_div.appendChild(number_cell);
					file_div.appendChild(title_cell);
					file_div.appendChild(download_cell);
					files_div.appendChild(file_div)
				}
				
			} else if (xhr.responseText == '[]'){
				files_div.textContent = "저장된 파일이 없습니다.";
			}
		}
	}
}

function alertMessage(){
	alert('다운로드 횟수가 부족합니다');
}

function selectOne(user_no){
	let filesArea = document.querySelector(".files__area");
	filesArea.innerHTML = "";
	const xhr = new XMLHttpRequest();
	xhr.open("POST","/timewizard/file/one/"+user_no);
	xhr.send();
	xhr.onreadystatechange = () => {
		if (xhr.readyState == 4 && xhr.status == 200){
			console.log(xhr.responseText);
			if (xhr.responseText != null && xhr.responseText != ""){
				let file = JSON.parse(xhr.responseText);
				
				let files_div = document.createElement("div");
				files_div.setAttribute("class","files");
				
				let file_div = document.createElement("div");
				file_div.setAttribute("class","file");
					
				let number_cell = document.createElement("div");
				number_cell.setAttribute("class","cell number__cell");
				let number_cell_span = document.createElement("span");
				number_cell_span.setAttribute("class", "number");
				number_cell_span.textContent = 1;
				number_cell.appendChild(number_cell_span);
				
				let title_cell = document.createElement("div");
				title_cell.setAttribute("class","cell title__cell");
				let title = document.createElement("p");
				title.textContent = file.file_name;
				title_cell.appendChild(title);
				
				let download_cell = document.createElement("div");
				download_cell.setAttribute("class","cell download__cell");
				
				let form = document.createElement("form");
				form.setAttribute("action","/timewizard/file/download/"+file.file_no);
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
				filesArea.appendChild(files_div);
				
			} else if (xhr.responseText == "" || xhr.responseText == null){
					filesArea.textContent = "저장된 파일이 없습니다.";
			}
		}
	}
}