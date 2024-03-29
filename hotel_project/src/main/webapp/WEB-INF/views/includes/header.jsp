<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>심사숙소</title>

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


<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@700&display=swap"
	rel="stylesheet">

<!-- 별점주기	 -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"></script>

<!-- sweetalert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	
<!-- Custom styles for this template -->
<link href="/resources/css/headers.css" rel="stylesheet">

<link href="/resources/css/style.css" rel="stylesheet">

<!-- datepicker css -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />




<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
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


.card {
	margin: 10px;
}

.star {
    position: relative;
    font-size: 2rem;
    color: #ddd;
  }
  
  .star input {
    width: 100%;
    height: 100%;
    position: absolute;
    left: 0;
    opacity: 0;
    cursor: pointer;
  }
  
  .star span {
    width: 0;
    position: absolute; 
    left: 0;
    color: red;
    overflow: hidden;
    pointer-events: none;
  }

/* .recommend_hotel_box{
  flex-grow: 0;
} */
</style>


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
		$("#md").autocomplete({ //오토 컴플릿트 시작
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

<body style="font-family: 'Gowun Batang', serif;">
	<main>
		<header style="background-color: #FF8C00;" class="p-3 text-white">
			<nav class="navbar">
				<div class="container-fluid">
					<a href="${contextPath }/hotel/index"
						class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
						<span class="fs-4"><strong>심사숙소</strong></span>
					</a>
					<div class="col-md-7 mb-lg-0 me-lg-3"></div>
					<div
						class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
						<div class="col-md-7 mb-lg-0 me-lg-3"></div>
						<c:if test = "${member == null}">
						<button type="button" class="btn btn-outline-light me-2" onclick="location.href='/member/login'">Login</button>
						<button type="button" class="btn btn-outline-light me-2" onclick="location.href='/member/join'">Sign-up</button>
						</c:if>
						<!-- 관리자 로그인 -->
             		    <c:if test="${member.memberId =='admin'}">
                       	<button type="button" class="btn btn-outline-light me-2" onclick="location.href='/admin/main'">admin</button>
                       	<button type="button" id="logout" class="btn btn-outline-light me-2">Logout</button>
                    	</c:if>
						<!-- 로그인한 상태 -->
               		 	<c:if test="${member != null and member.memberId !='admin'}">
                		<span style="margin:15px">
                		<c:choose>
                		<c:when test="${member.memberNickname != null}">
                		${member.memberNickname}님, 안녕하세요</span>
                		</c:when>
                		<c:otherwise>
                		${member.MEMBERNICKNAME}님, 안녕하세요</span>
           				 </c:otherwise>
						</c:choose>
                		<button type="button" class="btn btn-outline-light me-2" onclick="location.href='/member/myPage'">my page</button>
                		<button type="button" id="logout" class="btn btn-outline-light me-2">Logout</button>
             		   </c:if>
					</div>

				</div>
			</nav>

			<div class="search_input_box">
				<div class="search_input rooms_box">
					<div class="search_input_lacation">
						<a href="#">
							<div>위치</div> <input type="text" placeholder="어디로 여행가세요?"
							name = "keyword"id="searchInput" value="${pageMaker.cri.keyword }">
						</a>
					</div>
					<div class="search_input__start_date">
						<a href="#">
							<div>체크인</div> <input type="datetime" placeholder="날짜 추가"
							class="datepicker" readonly> <script>
								$.datepicker.setDefaults({
									dateFormat : 'yy-mm-dd',
									prevText : '이전 달',
									nextText : '다음 달',
									monthNames : [ '1월', '2월', '3월', '4월',
											'5월', '6월', '7월', '8월', '9월',
											'10월', '11월', '12월' ],
									monthNamesShort : [ '1월', '2월', '3월', '4월',
											'5월', '6월', '7월', '8월', '9월',
											'10월', '11월', '12월' ],
									dayNames : [ '일', '월', '화', '수', '목', '금',
											'토' ],
									dayNamesShort : [ '일', '월', '화', '수', '목',
											'금', '토' ],
									dayNamesMin : [ '일', '월', '화', '수', '목',
											'금', '토' ],
									showMonthAfterYear : true,
									yearSuffix : '년'
								});
								$(function() {
									$('.datepicker').datepicker();
								})
							</script>
						</a>
					</div>
					<div class="search_input__end_date">
						<a href="#">
							<div>체크아웃</div> <input type="datetime" placeholder="날짜 추가"
							class="datepicker" readonly> <script>
								$.datepicker.setDefaults({
									dateFormat : 'yy-mm-dd',
									prevText : '이전 달',
									nextText : '다음 달',
									monthNames : [ '1월', '2월', '3월', '4월',
											'5월', '6월', '7월', '8월', '9월',
											'10월', '11월', '12월' ],
									monthNamesShort : [ '1월', '2월', '3월', '4월',
											'5월', '6월', '7월', '8월', '9월',
											'10월', '11월', '12월' ],
									dayNames : [ '일', '월', '화', '수', '목', '금',
											'토' ],
									dayNamesShort : [ '일', '월', '화', '수', '목',
											'금', '토' ],
									dayNamesMin : [ '일', '월', '화', '수', '목',
											'금', '토' ],
									showMonthAfterYear : true,
									yearSuffix : '년'
								});
								$(function() {
									$('.datepicker').datepicker();
								})
							</script>
						</a>
					</div>
					<div class="search_input_people">
						<a href="#">
							<div>인원</div> <input type="number" placeholder="게스트 추가">
						</a>
					</div>
					<div class="search_button_container">
						<button class="search_button" style="text-align: center;">
							<img src="/resources/images/search.svg" class="search_icon" />
						</button>
					</div>
				</div>
			</div>
			<form id='searchForm' action="${contextPath }/hotel/search_normal" method='post'>
				<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
				<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
				<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
			</form>
			</div>

			<!-- Button trigger modal -->
			<button type="button" class="modal_btn btn btn-primary "
				data-bs-toggle="modal" data-bs-target="#exampleModal">
				숙소검색하기</button>

			<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel"
								style="color: #000000;">조건 검색</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body" style="background-color: #FF8C00;">
							<div class="small_search_input_box">
								<div class="small_search_input rooms_box">
									<div class="small_search_input_lacation">
										<a href="#">
											<div>위치</div> <input type="text" placeholder="어디로 여행가세요?"
							name = "keyword"id="searchInput" value="${pageMaker.cri.keyword }">
										</a>
									</div>
									<div class="small_search_input__start_date">
										<a href="#">
											<div>체크인</div> <input type="datetime" placeholder="날짜 추가"
											class="datepicker" readonly> <script>
												$.datepicker
														.setDefaults({
															dateFormat : 'yy-mm-dd',
															prevText : '이전 달',
															nextText : '다음 달',
															monthNames : [
																	'1월', '2월',
																	'3월', '4월',
																	'5월', '6월',
																	'7월', '8월',
																	'9월',
																	'10월',
																	'11월',
																	'12월' ],
															monthNamesShort : [
																	'1월', '2월',
																	'3월', '4월',
																	'5월', '6월',
																	'7월', '8월',
																	'9월',
																	'10월',
																	'11월',
																	'12월' ],
															dayNames : [ '일',
																	'월', '화',
																	'수', '목',
																	'금', '토' ],
															dayNamesShort : [
																	'일', '월',
																	'화', '수',
																	'목', '금',
																	'토' ],
															dayNamesMin : [
																	'일', '월',
																	'화', '수',
																	'목', '금',
																	'토' ],
															showMonthAfterYear : true,
															yearSuffix : '년'
														});
												$(function() {
													$('.datepicker')
															.datepicker();
												})
											</script>
										</a>
									</div>
									<div class="small_search_input__end_date">
										<a href="#">
											<div>체크아웃</div> <input type="datetime" placeholder="날짜 추가"
											class="datepicker" readonly> <script>
												$.datepicker
														.setDefaults({
															dateFormat : 'yy-mm-dd',
															prevText : '이전 달',
															nextText : '다음 달',
															monthNames : [
																	'1월', '2월',
																	'3월', '4월',
																	'5월', '6월',
																	'7월', '8월',
																	'9월',
																	'10월',
																	'11월',
																	'12월' ],
															monthNamesShort : [
																	'1월', '2월',
																	'3월', '4월',
																	'5월', '6월',
																	'7월', '8월',
																	'9월',
																	'10월',
																	'11월',
																	'12월' ],
															dayNames : [ '일',
																	'월', '화',
																	'수', '목',
																	'금', '토' ],
															dayNamesShort : [
																	'일', '월',
																	'화', '수',
																	'목', '금',
																	'토' ],
															dayNamesMin : [
																	'일', '월',
																	'화', '수',
																	'목', '금',
																	'토' ],
															showMonthAfterYear : true,
															yearSuffix : '년'
														});
												$(function() {
													$('.datepicker')
															.datepicker();
												})
											</script>
										</a>
									</div>
									<div class="small_search_input_people">
										<a href="#">
											<div>인원</div> <input type="number" placeholder="게스트 추가">
										</a>
									</div>
								</div>
								<div class="small_search_button_container">
									<button class="search_button"
										style="display: block; text-align: center; margin: auto;">
										<img src="/resources/images/search.svg" class="search_icon" />
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<form id='searchForm' action="${contextPath }/hotel/search_normal" method='get'>
				<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
				<input type='hidden' name='amount' value='${pageMaker.cri .amount}'>
				<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
			</form>
			</div>
		</header>
		
		<script>
		//로그아웃 alert
		  $("#logout").click(function () {
			    Swal.fire({
			      title: '로그아웃 하시겠습니까?',
			      icon: 'warning',
			      showCancelButton: true,
			      confirmButtonColor: '#FF8C00',
			      cancelButtonColor: '#d33',
			      confirmButtonText: 'OK',
			      cancelButtonText: 'Cancel',
			      
			    }).then((result) => {
			      if (result.isConfirmed) {
			          location.href='/member/logout.do'
			      }
			    })
			  });
		
		//검색 script
		  $(".search_button").on("click", function(e){
			  	console.log("click");
		        e.preventDefault();
		        let searchForm = $('#searchForm');
		        let val = $("input[name='keyword']").val();
		        searchForm.find("input[name='keyword']").val(val);
		        searchForm.find("input[name='pageNum']").val(1);
		        searchForm.submit();
		    });
		</script>