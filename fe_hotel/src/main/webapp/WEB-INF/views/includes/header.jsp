<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>심사숙소</title>

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&display=swap" rel="stylesheet">

<!-- Bootstrap 5 -->
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

<!-- jQuery + jQuery UI -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css">

<!-- Font Awesome -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"></script>

<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- Custom CSS -->
<link href="/resources/css/style.css" rel="stylesheet">

<!-- Datepicker Init (single instance) -->
<script>
$(function() {
	$.datepicker.setDefaults({
		dateFormat: 'yy-mm-dd',
		prevText: '이전 달',
		nextText: '다음 달',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		showMonthAfterYear: true,
		yearSuffix: '년',
		minDate: 0
	});
	// === 체크인 · 체크아웃 범위 선택 ===
	var stage = 'checkin';
	var checkinDate = null;
	var checkoutDate = null;
	var DATE_FMT = 'yy-mm-dd';

	function formatD(d) { return d ? $.datepicker.formatDate(DATE_FMT, d) : ''; }
	function sameDay(a, b) {
		return a && b && a.getFullYear()===b.getFullYear() && a.getMonth()===b.getMonth() && a.getDate()===b.getDate();
	}

	function refreshInputs() {
		$("#checkinInput").val(formatD(checkinDate));
		$("#checkoutInput").val(formatD(checkoutDate));
	}

	function openDatePanel(forStage) {
		stage = forStage;
		$("#checkinField").toggleClass("is-active", stage === 'checkin');
		$("#checkoutField").toggleClass("is-active", stage === 'checkout');
		$("#dateRangePanel").attr("hidden", false);
		$("#rangeCal").datepicker("refresh");
	}

	function closeDatePanel() {
		$("#dateRangePanel").attr("hidden", true);
		$("#checkinField, #checkoutField").removeClass("is-active");
	}

	$("#rangeCal").datepicker({
		numberOfMonths: 2,
		minDate: 0,
		dateFormat: DATE_FMT,
		showButtonPanel: false,
		onSelect: function(dateText) {
			var d = $.datepicker.parseDate(DATE_FMT, dateText);
			if (stage === 'checkin') {
				checkinDate = d;
				if (checkoutDate && checkoutDate <= d) checkoutDate = null;
				refreshInputs();
				openDatePanel('checkout');
			} else {
				if (!checkinDate || d <= checkinDate) {
					// 체크아웃 단계에서 체크인보다 이전/같은 날 선택 시 → 새 체크인으로 처리
					checkinDate = d;
					checkoutDate = null;
					refreshInputs();
					openDatePanel('checkout');
				} else {
					checkoutDate = d;
					refreshInputs();
					closeDatePanel();
				}
			}
			$("#rangeCal").datepicker("refresh");
		},
		beforeShowDay: function(date) {
			if (sameDay(date, checkinDate)) return [true, 'dp-range-start', ''];
			if (sameDay(date, checkoutDate)) return [true, 'dp-range-end', ''];
			if (checkinDate && checkoutDate && date > checkinDate && date < checkoutDate) return [true, 'dp-range', ''];
			return [true, '', ''];
		}
	});

	$("#checkinInput").on("click focus", function(){ openDatePanel('checkin'); });
	$("#checkoutInput").on("click focus", function(){ openDatePanel(checkinDate ? 'checkout' : 'checkin'); });

	$(document).on("mousedown", function(e){
		if (!$(e.target).closest("#checkinField, #checkoutField").length) closeDatePanel();
	});
	$(document).on("keydown", function(e){
		if (e.key === "Escape" && !$("#dateRangePanel").attr("hidden")) closeDatePanel();
	});

	// === 지역 데이터 (search_filter.jsp 기준 canonical 31개) ===
	var CITIES = [
		{ko:"고양", en:"Goyang"},     {ko:"구리", en:"Guri"},
		{ko:"남양주", en:"Namyangju"}, {ko:"동두천", en:"Dongducheon"},
		{ko:"양주", en:"Yangju"},     {ko:"의정부", en:"Uijeongbu"},
		{ko:"파주", en:"Paju"},       {ko:"포천", en:"Pocheon"},
		{ko:"가평", en:"Gapyeong"},   {ko:"연천", en:"Yeoncheon"},
		{ko:"과천", en:"Gwacheon"},   {ko:"광명", en:"Gwangmyeong"},
		{ko:"광주", en:"Gwangju"},    {ko:"군포", en:"Gunpo"},
		{ko:"김포", en:"Gimpo"},      {ko:"부천", en:"Bucheon"},
		{ko:"성남", en:"Seongnam"},   {ko:"수원", en:"Suwon"},
		{ko:"시흥", en:"Siheung"},    {ko:"안산", en:"Ansan"},
		{ko:"안성", en:"Anseong"},    {ko:"안양", en:"Anyang"},
		{ko:"여주", en:"Yeoju"},      {ko:"오산", en:"Osan"},
		{ko:"용인", en:"Yongin"},     {ko:"의왕", en:"Uiwang"},
		{ko:"이천", en:"Icheon"},     {ko:"평택", en:"Pyeongtaek"},
		{ko:"하남", en:"Hanam"},      {ko:"화성", en:"Hwaseong"},
		{ko:"양평", en:"Yangpyeong"}
	];
	var REGION_EN_TO_KO = {};
	CITIES.forEach(function(r){ REGION_EN_TO_KO[r.en] = r.ko; });

	var popularSet = {}; // en → true, AJAX로 채움

	// === 리스트 아이템 렌더 ===
	// item: { label, sublabel, value, icon, type: 'region'|'popular'|'city' }
	function itemHtml(item) {
		return '<button type="button" class="dest-item" data-value="' + item.value + '" data-label="' + item.label + '">'
			+ '<span class="dest-icon"><i class="bi ' + item.icon + '"></i></span>'
			+ '<span class="dest-text">'
				+ '<strong>' + item.label + '</strong>'
				+ '<span class="dest-sub">' + item.sublabel + '</span>'
			+ '</span>'
			+ '</button>';
	}

	// 필터링된 리스트 렌더
	function renderList(query) {
		var q = (query || "").trim().toLowerCase();
		var items = [];

		// 1) 최상위 지역 — value="경기"로 두면 LIKE '%경기%'로 경기도 전체 숙소가 매칭됨
		var region = { label:"경기도, 대한민국", sublabel:"지역", value:"경기", icon:"bi-flag-fill", type:"region" };
		if (!q || region.label.toLowerCase().includes(q) || "경기도".includes(q)) items.push(region);

		// 2) 추천 지역 (popularSet)
		CITIES.forEach(function(c) {
			if (!popularSet[c.en]) return;
			var label = c.ko + ", 대한민국";
			if (q && !label.toLowerCase().includes(q) && !c.ko.includes(q) && !c.en.toLowerCase().includes(q)) return;
			items.push({ label:label, sublabel:"추천", value:c.en, icon:"bi-fire", type:"popular" });
		});

		// 3) 전체 도시 (추천 제외)
		CITIES.forEach(function(c) {
			if (popularSet[c.en]) return;
			var label = c.ko + ", 대한민국";
			if (q && !label.toLowerCase().includes(q) && !c.ko.includes(q) && !c.en.toLowerCase().includes(q)) return;
			items.push({ label:label, sublabel:"도시", value:c.en, icon:"bi-geo-alt-fill", type:"city" });
		});

		var $list = $("#destList");
		if (items.length === 0) {
			$list.html('<div class="dest-empty">일치하는 목적지가 없습니다</div>');
		} else {
			$list.html(items.map(itemHtml).join(''));
		}
	}

	// 추천 지역 API 로드 → 리스트 재렌더
	$.getJSON("${contextPath}/hotel/popularRegions?limit=6", function(data) {
		if (data && data.length) {
			data.forEach(function(row) {
				var en = row.state || "";
				// DB가 한글로 저장된 경우: 역방향 매핑 시도
				var found = CITIES.find(function(c){ return c.en === en || c.ko === en; });
				if (found) popularSet[found.en] = true;
			});
		}
		renderList($("#searchInput").val());
	}).fail(function(){ renderList($("#searchInput").val()); });

	// 초기 렌더 (API 응답 전에도 기본 리스트 표시)
	renderList("");

	// === 드롭다운 동작 ===
	$("#searchInput").on("focus", function(){
		$("#destPanel").attr("hidden", false);
		$(this).attr("aria-expanded", "true");
	});
	$("#searchInput").on("input", function(){
		$("#destPanel").attr("hidden", false);
		renderList($(this).val());
	});
	$(document).on("mousedown", function(e){
		if (!$(e.target).closest(".destination-field").length) {
			$("#destPanel").attr("hidden", true);
			$("#searchInput").attr("aria-expanded", "false");
		}
	});
	$(document).on("keydown", function(e){
		if (e.key === "Escape" && !$("#destPanel").attr("hidden")) {
			$("#destPanel").attr("hidden", true);
			$("#searchInput").attr("aria-expanded", "false");
		}
	});
	// 리스트 아이템 클릭 → 입력값만 세팅 (검색은 사용자가 검색 버튼으로 직접 실행)
	$(document).on("click", ".dest-item", function(){
		var label = $(this).data("label");
		var value = $(this).data("value");
		$("#searchInput").val(label);
		$("#searchValue").val(value);
		$("#destPanel").attr("hidden", true);
	});

	// === 객실 / 인원 수 스테퍼 ===
	function refreshGuestsLabel() {
		var adults = parseInt($("#guestsAdults").val(), 10) || 0;
		var children = parseInt($("#guestsChildren").val(), 10) || 0;
		var rooms = parseInt($("#guestsRooms").val(), 10) || 0;
		var parts = [];
		if (adults > 0) parts.push("성인 " + adults + "명");
		if (children > 0) parts.push("어린이 " + children + "명");
		if (rooms > 0) parts.push("객실 " + rooms + "개");
		$("#guestsInput").val(parts.join(" · "));
	}

	function updateStepperButtons($row) {
		var key = $row.data("key");
		var min = parseInt($row.data("min"), 10);
		var max = parseInt($row.data("max"), 10);
		var val = parseInt($row.find("[data-value]").text(), 10);
		$row.find('[data-action="dec"]').prop("disabled", val <= min);
		$row.find('[data-action="inc"]').prop("disabled", val >= max);
	}

	$(".guests-row").each(function(){ updateStepperButtons($(this)); });
	refreshGuestsLabel();

	$("#guestsInput").on("click focus", function(){
		$("#guestsPanel").attr("hidden", false);
	});

	$(document).on("click", ".guests-row .stepper-btn", function(){
		var $btn = $(this);
		var $row = $btn.closest(".guests-row");
		var key = $row.data("key");
		var min = parseInt($row.data("min"), 10);
		var max = parseInt($row.data("max"), 10);
		var $val = $row.find("[data-value]");
		var val = parseInt($val.text(), 10);
		var action = $btn.data("action");
		if (action === "inc" && val < max) val++;
		else if (action === "dec" && val > min) val--;
		$val.text(val);
		var idMap = { adults: "#guestsAdults", children: "#guestsChildren", rooms: "#guestsRooms" };
		$(idMap[key]).val(val);
		updateStepperButtons($row);
		refreshGuestsLabel();
	});

	$("#guestsDoneBtn").on("click", function(){
		$("#guestsPanel").attr("hidden", true);
	});

	$(document).on("mousedown", function(e){
		if (!$(e.target).closest("#guestsField").length) {
			$("#guestsPanel").attr("hidden", true);
		}
	});
	$(document).on("keydown", function(e){
		if (e.key === "Escape" && !$("#guestsPanel").attr("hidden")) {
			$("#guestsPanel").attr("hidden", true);
		}
	});
});
</script>

</head>

<body>
<main>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-hotel">
	<div class="container">
		<a class="navbar-brand" href="${contextPath}/hotel/index">
			심사숙소 <span class="brand-hanja">深思熟所</span>
		</a>

		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarMain">
			<ul class="navbar-nav ms-auto align-items-center gap-2">
				<c:if test="${member == null}">
					<li class="nav-item">
						<a class="btn btn-outline-hotel btn-sm" href="/member/login">로그인</a>
					</li>
					<li class="nav-item">
						<a class="btn btn-primary-hotel btn-sm" href="/member/join">회원가입</a>
					</li>
				</c:if>

				<c:if test="${member.memberRole == 'MASTER' or member.memberRole == 'ADMIN'}">
					<li class="nav-item">
						<a class="btn btn-outline-hotel btn-sm" href="/admin/main">관리자</a>
					</li>
					<li class="nav-item">
						<button type="button" id="logout" class="btn btn-outline-hotel btn-sm">로그아웃</button>
					</li>
				</c:if>

				<c:if test="${member != null and member.memberRole != 'MASTER' and member.memberRole != 'ADMIN'}">
					<li class="nav-item">
						<span class="nav-link fw-semibold">
							<i class="bi bi-person-circle"></i>
							<c:choose>
								<c:when test="${member.memberNickname != null}">${member.memberNickname}</c:when>
								<c:otherwise>${member.MEMBERNICKNAME}</c:otherwise>
							</c:choose>님
						</span>
					</li>
					<li class="nav-item">
						<a class="btn btn-outline-hotel btn-sm" href="/member/myPage">
							<i class="bi bi-person"></i> 마이페이지
						</a>
					</li>
					<li class="nav-item">
						<button type="button" id="logout" class="btn btn-outline-hotel btn-sm">로그아웃</button>
					</li>
				</c:if>
			</ul>
		</div>
	</div>
</nav>

<!-- Search Hero Section -->
<section class="search-hero">
	<div class="container">
		<h1>한옥에서 보내는 깊은 하룻밤</h1>
	</div>

	<!-- Search bar card overlapping hero bottom -->
	<div class="container search-bar-wrapper">
		<div class="search-bar">
			<div class="search-field destination-field">
				<label>목적지</label>
				<input type="text" placeholder="지역 선택 또는 직접 입력"
					class="search-autocomplete" id="searchInput"
					autocomplete="off" aria-haspopup="dialog" aria-expanded="false"
					value="${pageMaker.cri.keyword}">
				<input type="hidden" id="searchValue">
				<div id="destPanel" class="destination-panel" hidden
					 role="listbox" aria-label="목적지 선택">
					<div id="destList" class="dest-list"></div>
				</div>
			</div>
			<div class="search-field-divider"></div>
			<div class="search-field date-field" id="checkinField">
				<label>체크인</label>
				<input type="text" placeholder="날짜 선택" id="checkinInput" readonly autocomplete="off">
			</div>
			<div class="search-field-divider"></div>
			<div class="search-field date-field" id="checkoutField">
				<label>체크아웃</label>
				<input type="text" placeholder="날짜 선택" id="checkoutInput" readonly autocomplete="off">
				<div id="dateRangePanel" class="date-range-panel" hidden
					 role="dialog" aria-label="체크인·체크아웃 선택">
					<div id="rangeCal"></div>
				</div>
			</div>
			<div class="search-field-divider"></div>
			<div class="search-field guests-field" id="guestsField">
				<label>객실 / 인원 수</label>
				<input type="text" placeholder="게스트 추가" id="guestsInput" readonly autocomplete="off">
				<input type="hidden" id="guestsAdults" value="2">
				<input type="hidden" id="guestsChildren" value="0">
				<input type="hidden" id="guestsRooms" value="1">
				<div id="guestsPanel" class="guests-panel" hidden
					 role="dialog" aria-label="객실 및 인원 선택">
					<div class="guests-row" data-key="adults" data-min="1" data-max="20">
						<div class="guests-row__text">
							<div class="guests-row__title">성인</div>
							<div class="guests-row__sub">만 13세 이상</div>
						</div>
						<div class="guests-stepper">
							<button type="button" class="stepper-btn" data-action="dec" aria-label="성인 감소">−</button>
							<span class="stepper-value" data-value>2</span>
							<button type="button" class="stepper-btn" data-action="inc" aria-label="성인 증가">+</button>
						</div>
					</div>
					<div class="guests-row" data-key="children" data-min="0" data-max="10">
						<div class="guests-row__text">
							<div class="guests-row__title">어린이</div>
							<div class="guests-row__sub">2~12세</div>
						</div>
						<div class="guests-stepper">
							<button type="button" class="stepper-btn" data-action="dec" aria-label="어린이 감소">−</button>
							<span class="stepper-value" data-value>0</span>
							<button type="button" class="stepper-btn" data-action="inc" aria-label="어린이 증가">+</button>
						</div>
					</div>
					<div class="guests-row" data-key="rooms" data-min="1" data-max="10">
						<div class="guests-row__text">
							<div class="guests-row__title">객실</div>
							<div class="guests-row__sub">필요한 객실 수</div>
						</div>
						<div class="guests-stepper">
							<button type="button" class="stepper-btn" data-action="dec" aria-label="객실 감소">−</button>
							<span class="stepper-value" data-value>1</span>
							<button type="button" class="stepper-btn" data-action="inc" aria-label="객실 증가">+</button>
						</div>
					</div>
					<div class="guests-panel__footer">
						<button type="button" class="guests-done-btn" id="guestsDoneBtn">완료</button>
					</div>
				</div>
			</div>
			<button class="search-btn" type="button" aria-label="검색">
				<i class="bi bi-search"></i>
				<span>검색</span>
			</button>
		</div>
	</div>
</section>

<!-- Search Form (hidden) -->
<form id="searchForm" action="${contextPath}/hotel/search_normal" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
</form>

<script>
// Logout
$("#logout").click(function() {
	Swal.fire({
		title: '로그아웃 하시겠습니까?',
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#FF8C00',
		cancelButtonColor: '#d33',
		confirmButtonText: '확인',
		cancelButtonText: '취소'
	}).then((result) => {
		if (result.isConfirmed) {
			location.href = '/member/logout.do';
		}
	});
});

// Search
$(".search-btn").on("click", function(e) {
	e.preventDefault();
	var searchForm = $('#searchForm');
	// 버튼/칩으로 선택한 경우 hidden searchValue(영문)를 사용, 자유 입력은 표시값 그대로
	var keyword = $("#searchValue").val() || $("#searchInput").val();
	searchForm.find("input[name='keyword']").val(keyword);
	searchForm.find("input[name='pageNum']").val(1);
	searchForm.submit();
});
</script>
