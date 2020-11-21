// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
Kakao.init('f78bdb18545b23a910d70eec2950b2b7');

// SDK 초기화 여부를 판단합니다.
console.log(Kakao.isInitialized());

/* 직접 만든 버튼으로 메시지 보내기 - Daily */
function dailyLink(){
	Kakao.Link.sendDefault({
  objectType: 'feed',
  content: {
    title: 'Time Wizard Daily',
    description: 'Time Wizard가 시간관리를 도와드립니다!',
    imageUrl:
      'https://cdn.pixabay.com/photo/2016/06/01/06/26/open-book-1428428_1280.jpg',
    link: {
      mobileWebUrl: 'https://qclass.iptime.org:8443/timewizard',
      androidExecParams: 'test',
    },
  },
  buttons: [
    {
      title: '웹으로 이동',
      link: {
        mobileWebUrl: 'https://qclass.iptime.org:8443/timewizard',
      },
    },
    {
      title: '앱으로 이동',
      link: {
        mobileWebUrl: 'https://qclass.iptime.org:8443/timewizard',
      },
    },
  ]
});
};
$(document).ready(function () {
	screenshot();
 
});

/* html2canvas - 스크린샷 */
function screenshot(){
  document.getElementById("downloadbtn").style.display = "none";
  setTimeout(() => {
      html2canvas(document.getElementById("daily__part")).then(function(canvas) {
      canvas.setAttribute("id", "mycanvas");
      canvas.setAttribute("style", "display:none");
      document.body.appendChild(canvas);
      document.getElementById("downloadbtn").style.display = "";
      download();
    });
  }, 1000);
}

/* 이미지 다운로드 */
function download() {
	var image = document.getElementById("mycanvas")
						.toDataURL("image/png")
						.replace("image/png", "image/octet-stream");
	var download = document.getElementById("download")
							.setAttribute("href", image);
							
};