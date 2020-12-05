# TimeWizard 온라인 스터디 플래너
> KH 파이널 프로젝트 - 미니빈MiniBean 조<br />
> Online Study Planner


### 🚩요약
- COURSE : 웹기반 빅데이터 전문 개발자 양성과정 (1) - KH정보교육원 (강남지원)
- SUBJECT : 파이널 프로젝트
- TITLE : TimeWizard
- SUMMARY : 시간 관리 보조 + 캠스터디 애플리케이션
- PERIOD : 2020.10.19 ~ 2020.11.16 + 2020.11.21 ~


### 🚩프로젝트 멤버
- [정형빈](https://github.com/AbelJung)
- [김산희](https://github.com/sanheekim)
- [박진희](https://github.com/pomeloEater)
- [배민경](https://github.com/mingyeungAA)
- [윤용민](https://github.com/yoonyongmin)
- [주명빈](https://github.com/wnaudqls)


### 🚩개발 환경
* 사용 언어 : Java, JavaScript, HTML, CSS
* 사용 기술 : MyBatis, jQuery
* 사용 API : SNS 로그인(NAVER, kakao, Google), Summernote, D3.js, Frappe, Toast UI Calendar, socket.io, stompJS, rtcMulticonnection, recordRTC, html2canvas, 카카오공유하기, 카카오i 챗봇, 카카오 지도, 아임포트-이니시스
* 사용 도구 : Eclipse IDE, Visual Studio Code
* 사용 DB : Oracle Database 11g
* 사용 서버 : Apache Tomcat 9.0
* 협업 도구 : Github, Notion


### 🚩개발 동기
- 코로나 19 장기화로 재택근무, 온라인 수업 확대.
- 쉬는 공간인 집과 일하는 공간인 회사의 경계가 모호해짐.
- 학원, 독서실 등 이용이 불가해지면서 혼공(혼자하는 공부)가 대세.


### 🚩시장조사

#### 📍열품타 (열정품은타이머)
- 공부시간을 내부 유저들끼리 공유할 수 있어서, 경쟁을 유발.
- 장점
  - 다른 어플 사용 금지 기능.
  - "그룹"메뉴에서 같은 목표를 가진 유저들과 공부시간 비교 가능.
- 단점
  - 캠기능이 있지만, 영상이 아닌 30초마다 한번씩 찍히는 사진 기능.

#### 📍마이루틴
- 일반 개인 스케쥴러
- "습관", "루틴" 이 중점
- 장점
  - 다른 유저들의 일정을 볼 수 있다.
- 단점
  - 다른 스케쥴러와는 차별점이 없다.

<br />

👉다른 유저들의 일정을 볼 수 있는 기능을 오마주하였고, 

👉친구인 유저들과 일정을 공유할 수 있는 기능 오마주

👉열품타, 모트모트에서 10분단위로 시간을 시각화한 점을 착안

👉차별점으로 실시간 영상 공유, timelapse저장기능, 친구 초대 기능, ....

<br />

### 🚩Menu

- [📃Daily](#Daily)
- [📈Weekly](#Weekly)
- [📈Monthly](#Monthly)
- [👫Friend](#Friend)
- [👪Group](#Group)

---

### 📃Daily

- 하루 일정을 적는 부분
- 일정을 완료하면 10분단위로 시간이 시각화 된다.

![daily_modal](https://postfiles.pstatic.net/MjAyMDExMThfMjM0/MDAxNjA1NjcwNDgwNDQy.xNvL5ZECkmrixWzAWcmalOJoPPgPd0n20CKDuf7oPHkg.AKKx0ry_GkLlIV3S6WmN1UM6FcL8LgFlQD_01kKq7ZAg.PNG.mingyeung/image.png?type=w966)

<br>

![daily](https://postfiles.pstatic.net/MjAyMDExMThfNDYg/MDAxNjA1NjcwMzI3MTI0.Vc2azQ4kmFXpzXTzom08Z99ZfmXTTAvLK144ybleYXog.iVzdyeDBGrmpxdgYhi9dNnNyFBqayZmNdwV2ZaEXn_Ig.PNG.mingyeung/image.png?type=w966)

<br>

### 📈Weekly


- 한 주의 일정 완료여부를 chart로 보여준다.

<br>

### 📈Monthly

- 한달동안의 일정을 달력으로 보여준다.


<br>

### 👫Friend

- 유저에게 친구 추가를 할 수 있다.

<br>

### 👪Group

- 공개방과 비공개방으로 나뉜다.

<br>
