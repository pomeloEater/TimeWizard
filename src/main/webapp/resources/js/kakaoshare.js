// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
Kakao.init('f78bdb18545b23a910d70eec2950b2b7');

// SDK 초기화 여부를 판단합니다.
console.log(Kakao.isInitialized());

/* 카카오톡 링크로 메시지 보내기 */
function sendLink(){
	Kakao.Link.createDefaultButton({
	  container: '#kakao-link-btn',
	  objectType: 'feed',
	  content: {
	    title: '디저트 사진',
	    description: '아메리카노, 빵, 케익',
	    imageUrl:
	      'http://mud-kage.kakao.co.kr/dn/NTmhS/btqfEUdFAUf/FjKzkZsnoeE4o19klTOVI1/openlink_640x640s.jpg',
	    link: {
	      mobileWebUrl: 'https://developers.kakao.com',
	      androidExecParams: 'test',
	    },
	  },
	  social: {
	    likeCount: 10,
	    commentCount: 20,
	    sharedCount: 30,
	  },
	  buttons: [
	    {
	      title: '웹으로 이동',
	      link: {
	        mobileWebUrl: 'http://localhost:8787/timewizard/main',
	      },
	    },
	    {
	      title: '앱으로 이동',
	      link: {
	        mobileWebUrl: 'http://localhost:8787/timewizard/main',
	      },
	    },
	  ]
	});
	
	// 링크가 전송되면 앱의 링크 콜백이 설정된 URL 및 메소드로 콜백이 전송됩니다.
	Kakao.Link.sendDefault({
	  objectType: 'text',
	  text: '간단한 JavaScript SDK 샘플과 함께 카카오 플랫폼 서비스 개발을 시작해 보세요.',
	  link: {
	    mobileWebUrl: 'https://developers.kakao.com',
	    webUrl: 'https://developers.kakao.com'
	  },
	  serverCallbackArgs: { // 콜백 파라미터 설정
	    key: 'value'
	  }
	});
};

/* 직접 만든 버튼으로 메시지 보내기 */
function goLink(){
	Kakao.Link.sendDefault({
  objectType: 'feed',
  content: {
    title: '디저트 사진',
    description: '아메리카노, 빵, 케익',
    imageUrl:
      'http://mud-kage.kakao.co.kr/dn/NTmhS/btqfEUdFAUf/FjKzkZsnoeE4o19klTOVI1/openlink_640x640s.jpg',
    link: {
      mobileWebUrl: 'https://developers.kakao.com',
      androidExecParams: 'test',
    },
  },
  social: {
    likeCount: 10,
    commentCount: 20,
    sharedCount: 30,
  },
  buttons: [
    {
      title: '웹으로 이동',
      link: {
        mobileWebUrl: 'https://developers.kakao.com',
      },
    },
    {
      title: '앱으로 이동',
      link: {
        mobileWebUrl: 'https://developers.kakao.com',
      },
    },
  ]
});
};