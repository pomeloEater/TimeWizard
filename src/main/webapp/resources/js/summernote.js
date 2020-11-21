$(document).ready(function(){
    $('#summernote').summernote({
      placeholder: '글을 자유롭게 작성해주세요.',
      height: 300,
      //width: 1000,
      lang: 'ko-KR',
      toolbar: [  //원하는 데로 툴바를 설정할 수 있다.
                  // [groupName, [list of button]]
                  ['Font Style', ['fontname']],  //폰트
                  ['style', ['bold', 'italic', 'underline']],  //글씨스타일
                  ['font', ['strikethrough']],  //글자 중간 밑줄
                  ['fontsize', ['fontsize']],  //글자 사이즈
                  ['color', ['color']],  //글자 색
                  ['para', ['paragraph']],  //정렬
                  ['height', ['height']],  //형광
                  ['Insert', ['picture']],  //사진
                  ['Insert', ['link']],  //링크첨부
                  ['Misc', ['fullscreen']]  //창 크기 조정
               ]
    });
  });