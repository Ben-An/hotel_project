<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>심사숙고</title>

<!-- Bootstrap core CSS -->
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">

<!--제이쿼리-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"
	integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"
	integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

<!--datepicker 이쁘게-->
<script type="text/javascript" src="/resources/js/jquery-ui.min.js"></script>
<link rel="stylesheet" href="/resources/css/jquery-ui.css">
<link href="/resources/css/recommend_hotel.css" rel="stylesheet">
<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

/* 큰화면 (태블릿, 768px 이상) */
@media ( min-width : 768px) {
	header {
		height: 300px;
	}
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
	.search_input {
		display: flex;
		align-items: center;
		text-align: center;
		height: 66px;
		width: 850px;
		margin: 100px auto;
		background-color: #FFFFFF;
		border-radius: 110px;
	}
	.search_input>div {
		width: 13rem;
		border-right: 1px solid #dadada;
	}
	.btn-primary {
		display: none;
	}
}

/* 작은 화면 */
@media screen and (max-width: 767px) {
	header {
		height: 200px;
	}
	.search_input_box {
		display: none;
	}
	.small_search_input_lacation, .small_search_input__start_date,
		.small_search_input__end_date, .small_search_input_people {
		align-items: center;
		text-align: center;
		height: 66px;
		width: 90%;
		background-color: #FFFFFF;
		border-radius: 110px;
		padding: 10px 0;
		margin: auto;
		margin-top: 10px;
	}
	.search_button_container {
		display: block;
		align-items: right;
		text-align: center;
		margin: auto;
	}
	.modal_btn {
		display: block;
		align-items: center;
		margin-top: 50px;
		margin-right: auto;
		margin-left: auto;
	}
}

.btn-outline-light, .modal_btn {
	background-color: white;
	color: #FF8C00;
	border: none;
}

.btn-outline-light:hover, .modal_btn:hover {
	background-color: #FF8C00;
	border-color: white;
	color: white;
}

.flex_center {
	display: inline-flex;
	align-items: center;
}

a {
	text-decoration: none;
	color: #000000;
}

a:visited {
	color: #000000;
}

.search_input>:nth-child(1) {
	width: 18rem;
}

.search_input>:nth-last-child(2) {
	width: 11rem;
	border: none;
}

.search_input>:nth-last-child(1) {
	width: 65px;
	border: none;
}

.search_input>:nth-last-child(1):hover {
	background: none;
}

.search_input>div div, .search_input>div input, .small_search_input>div div,
	.small_search_input>div input {
	width: 70%;
	margin: auto;
	border: none;
	text-align: left;
}

.search_input>div:hover, .small_search_input>div:hover {
	padding: 10px 0;
	background-color: #FFEBD2;
	border-radius: 110px;
	cursor: pointer;
}

.search_input input, .small_search_input input {
	cursor: default;
	background: transparent;
}

.search_button, .small_search_button {
	width: 45px;
	height: 45px;
	border: none;
	border-radius: 50%;
	background-color: #FF8607;
}

.search_button:hover, .small_search_button:hover {
	background-color: #FF7602;
}

.search_icon, .small_search_icon {
	color: white;
	border-color: #FFFFFF;
}

.st0 {
	fill: #FFFFFF;
}

.st1 {
	opacity: 0.8;
}

.st2 {
	fill: #D9D9D9;
}

.st3 {
	fill: #CCCCCC;
}

.st4 {
	fill: #A1A1A1;
}

.st5 {
	fill: none;
}

.st6 {
	fill: #B3B3B3;
}

.st7 {
	fill: #808080;
}

.st8 {
	fill: #BFBFBF;
}

.st9 {
	fill: #E6E6E6;
}

.st10 {
	fill: #A6A6A6;
}

.st11 {
	fill: #8C8C8C;
}

.st12 {
	fill: #999999;
}

.st0:hover {
	fill: #FF6A00;
}

.st1:hover {
	fill: #FF6A00;
}

.st2:hover {
	fill: #FF6A00;
}

.st3:hover {
	fill: #FF6A00;
}

.st4:hover {
	fill: #FF6A00;
}

.st5:hover {
	fill: #FF6A00;
}

.st6:hover {
	fill: #FF6A00;
}

.st7:hover {
	fill: #FF6A00;
}

.st8:hover {
	fill: #FF6A00;
}

.st9:hover {
	fill: #FF6A00;
}

.st10:hover {
	fill: #FF6A00;
}

.st11:hover {
	fill: #FF6A00;
}

.st12:hover {
	fill: #FF6A00;
}

.card{
	margin:10px;
}



/* .recommend_hotel_box{
  flex-grow: 0;
} */
</style>
<!-- Custom styles for this template -->
<link href="/resources/css/headers.css" rel="stylesheet">

<!-- 검색어 자동 완성 -->
<script>
	$(function() { //화면 다 뜨면 시작
		var searchSource = [ "연천", "고양", "파주", "김포", "가평", "부천", "화성", "동두천",
				"구리", "하남", "양평", "여주", "이천", "화성", "평택", "안성", "용인", "수원",
				"안산", "양주", "의정부", "남양주", "성남", "군포", "안양", "광명", "과천", "포천",
				"광주" ]; // 배열 형태로 
		$("#searchInput").autocomplete({ //오토 컴플릿트 시작
			source : searchSource, // source 는 자동 완성 대상
			select : function(event, ui) { //아이템 선택시
				console.log(ui.item);
			},
			focus : function(event, ui) { //포커스 가면
				return false;//한글 에러 잡기용도로 사용됨
			},
			minLength : 1,// 최소 글자수
			autoFocus : true, //첫번째 항목 자동 포커스 기본값 false
			classes : { //잘 모르겠음
				"ui-autocomplete" : "highlight"
			},
			delay : 100, //검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
			//            disabled: true, //자동완성 기능 끄기
			position : {
				my : "right top",
				at : "right bottom"
			}, //잘 모르겠음
			close : function(event) { //자동완성창 닫아질때 호출
				console.log(event);
			}
		});

	});
</script>



</head>

<body>
<main>
<header style="background-color: #FF8C00;" class="p-3 text-white">
    <div class="container">
      <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
        <a href="index.html" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
            <span class="fs-4"><strong>심사숙소</strong></span>
        </a>
        <div class="col-md-7 mb-lg-0 me-lg-3"></div>
          <div class="text-end">
            <button type="button" class="btn btn-outline-light me-2">Login</button>
            <button type="button" class="btn btn-outline-light me-2">Sign-up</button>
          </div>
      </div>
    </div>

      <div class="search_input_box">
        <div class="search_input rooms_box">
          <div class="search_input_lacation">
            <a href="#">
              <div>위치</div>
              <input type="text" placeholder="어디로 여행가세요?" id="searchInput">
            </a>
          </div>
          <div class="search_input__start_date">
            <a href="#">
              <div>체크인</div>
              <input type="datetime" placeholder="날짜 추가" class="datepicker" readonly>
              <script>
                $.datepicker.setDefaults({
                  dateFormat: 'yy-mm-dd',
                  prevText: '이전 달',
                  nextText: '다음 달',
                  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
                  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
                  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
                  showMonthAfterYear: true,
                  yearSuffix: '년'
                });
                $(function () {
                  $('.datepicker').datepicker();
                })
              </script>
            </a>
          </div>
          <div class="search_input__end_date">
            <a href="#">
              <div>체크아웃</div>
              <input type="datetime" placeholder="날짜 추가" 
              class="datepicker" readonly>
              <script>
                $.datepicker.setDefaults({
                  dateFormat: 'yy-mm-dd',
                  prevText: '이전 달',
                  nextText: '다음 달',
                  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
                  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
                  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
                  showMonthAfterYear: true,
                  yearSuffix: '년'
                });
                $(function () {
                  $('.datepicker').datepicker();
                })
              </script>
            </a>
          </div>
          <div class="search_input_people">
            <a href="#">
              <div>인원</div>
              <input type="number" placeholder="게스트 추가">
            </a>
          </div>
          <div class="search_button_container">
            <button class="search_button" style="text-align: center;">
                <img src="/resources/images/search.svg" class="search_icon"/>
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Button trigger modal -->
      <button type="button" class="modal_btn btn btn-primary " data-bs-toggle="modal" data-bs-target="#exampleModal">
        숙소검색하기
      </button>

      <!-- Modal -->
      <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel" style="color: #000000;">조건 검색</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" style="background-color: #FF8C00;">
              <div class="small_search_input_box">
                <div class="small_search_input rooms_box">
                  <div class="small_search_input_lacation">
                    <a href="#">
                      <div>위치</div>
                      <input type="text" placeholder="어디로 여행가세요?">
                    </a>
                  </div>
                  <div class="small_search_input__start_date">
                    <a href="#">
                      <div>체크인</div>
                      <input type="datetime" placeholder="날짜 추가" class="datepicker" readonly>
                      <script>
                        $.datepicker.setDefaults({
                          dateFormat: 'yy-mm-dd',
                          prevText: '이전 달',
                          nextText: '다음 달',
                          monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                          monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                          dayNames: ['일', '월', '화', '수', '목', '금', '토'],
                          dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
                          dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
                          showMonthAfterYear: true,
                          yearSuffix: '년'
                        });
                        $(function () {
                          $('.datepicker').datepicker();
                        })
                      </script>
                    </a>
                  </div>
                  <div class="small_search_input__end_date">
                    <a href="#">
                      <div>체크아웃</div>
                      <input type="datetime" placeholder="날짜 추가" 
                      class="datepicker" readonly>
                      <script>
                        $.datepicker.setDefaults({
                          dateFormat: 'yy-mm-dd',
                          prevText: '이전 달',
                          nextText: '다음 달',
                          monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                          monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                          dayNames: ['일', '월', '화', '수', '목', '금', '토'],
                          dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
                          dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
                          showMonthAfterYear: true,
                          yearSuffix: '년'
                        });
                        $(function () {
                          $('.datepicker').datepicker();
                        })
                      </script>
                    </a>
                  </div>
                  <div class="small_search_input_people">
                    <a href="#">
                      <div>인원</div>
                      <input type="number" placeholder="게스트 추가">
                    </a>
                  </div>
                </div>
                <div class="small_search_button_container">
                  <button class="search_button" style="display: block; text-align: center; margin: auto;">
                      <img src="images/search.svg" class="search_icon"/>
                  </button>
                </div>
              </div>
            </div>
            </div>
          </div>
        </div>
      </div>
  </header>
  
 

  
  
  
  


