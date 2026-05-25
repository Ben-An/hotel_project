<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

<%@include file="../includes/header.jsp"%>

<div class="container py-4">
	<div class="row g-4">

		<!-- Sidebar Filter -->
		<div class="col-lg-3">
			<%@include file="../includes/search_filter.jsp"%>
		</div>

		<!-- Hotel List -->
		<div class="col-lg-9" id="contentList">
			<c:if test="${not empty param.checkIn and not empty param.checkOut}">
				<div class="alert alert-light border d-flex align-items-center justify-content-between mb-3 py-2 px-3">
					<div>
						<i class="bi bi-calendar2-week"></i>
						<strong>${param.checkIn}</strong> ~ <strong>${param.checkOut}</strong>
						<span class="text-muted ms-2">선택한 기간에 예약 가능한 숙소</span>
					</div>
					<span class="badge bg-secondary">${empty list ? 0 : list.size()}건</span>
				</div>
			</c:if>

			<c:if test="${empty list}">
				<div class="alert alert-warning text-center my-4">
					<i class="bi bi-exclamation-circle"></i>
					<c:choose>
						<c:when test="${not empty param.checkIn and not empty param.checkOut}">
							선택한 기간(${param.checkIn} ~ ${param.checkOut})에 예약 가능한 숙소가 없습니다. 다른 날짜를 선택해 주세요.
						</c:when>
						<c:otherwise>
							조건에 맞는 숙소가 없습니다.
						</c:otherwise>
					</c:choose>
				</div>
			</c:if>

			<c:forEach var="item" items="${list}">
				<a href="/hotel/detail?hotelno=${item.hotelno}<c:if test='${not empty param.checkIn}'>&checkIn=${param.checkIn}</c:if><c:if test='${not empty param.checkOut}'>&checkOut=${param.checkOut}</c:if>">
					<div class="hotel-list-card hotelContent">
						<c:if test="${not empty item.hotelFileName}">
							<img src="/hotel/display?fileName=${item.hotelFileName}" class="card-img-left d-none d-md-block" alt="${item.realhotelName}">
						</c:if>
						<div class="card-body">
							<h5 class="card-title">${item.realhotelName}</h5>
							<div class="card-rating mb-2">
								<span class="text-warning averageGrade">${item.ag}</span>
								<i class="fas fa-star text-warning"></i>
							</div>
							<div class="card-price roomPrice">
								<c:choose>
									<c:when test="${empty item.roomPrice}">가격 문의</c:when>
									<c:otherwise>${item.roomPrice}원</c:otherwise>
								</c:choose>
							</div>
						</div>
						<span class="facility" style="display:none">
							${item.hotelno} ${item.state} ${item.buffet == 'T'? 'buffet': ''} ${item.swim == 'T'? 'swim': ''}
							${item.golf == 'T'? 'golf': ''} ${item.pet == 'T'? 'pet': ''} ${item.restaurant == 'T'? 'restaurant': ''}
							${item.fitness == 'T'? 'fitness': ''} ${item.parking == 'T'? 'parking': ''} ${item.wifi == 'T'? 'wifi': ''}
							${item.kitchen == 'T'? 'kitchen': ''} ${item.smoke == 'T'? 'smoke': ''}
						</span>
					</div>
				</a>
			</c:forEach>

			<!-- Pagination -->
			<nav aria-label="Page navigation" class="mt-4">
				<ul class="pagination justify-content-center">
					<c:if test="${pageMaker.prev}">
						<li class="page-item">
							<a class="page-link" href="${pageMaker.startPage - 1}">
								<i class="bi bi-chevron-left"></i> 이전
							</a>
						</li>
					</c:if>
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}">
							<a class="page-link" href="${num}">${num}</a>
						</li>
					</c:forEach>
					<c:if test="${pageMaker.next}">
						<li class="page-item">
							<a class="page-link" href="${pageMaker.endPage + 1}">
								다음 <i class="bi bi-chevron-right"></i>
							</a>
						</li>
					</c:if>
				</ul>
			</nav>
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
$(document).ready(function() {

	var qs = new URLSearchParams(location.search);

	// \uAC00\uACA9 \uC2AC\uB77C\uC774\uB354 (URL \uAC12 \uBCF5\uC6D0)
	var initLo = parseInt(qs.get('minPrice'), 10); if (isNaN(initLo)) initLo = 0;
	var initHi = parseInt(qs.get('maxPrice'), 10); if (isNaN(initHi)) initHi = 100000;
	function priceLabel(lo, hi) {
		$("#price").val("\u20A9" + lo.toLocaleString() + " ~ \u20A9" + hi.toLocaleString());
	}
	$("#slider-range").slider({
		range: true, min: 0, max: 100000, step: 5000,
		values: [initLo, initHi],
		slide: function(event, ui) { priceLabel(ui.values[0], ui.values[1]); }
	});
	priceLabel(initLo, initHi);

	// \uC0AC\uC774\uB4DC\uBC14 \uD544\uD130 \uC0C1\uD0DC URL \uBCF5\uC6D0 (\uD3B8\uC758\uC2DC\uC124 / \uC9C0\uC5ED / \uD3C9\uC810)
	$("input[name='option']").each(function() {
		if (qs.get($(this).val()) === 'T') $(this).prop('checked', true);
	});
	var areaParam = qs.get('area');
	if (areaParam) {
		var areaSet = areaParam.split(',');
		$("input[name='area']").each(function() {
			if (areaSet.indexOf($(this).val()) >= 0) $(this).prop('checked', true);
		});
	}
	var gradeParam = qs.get('grade');
	if (gradeParam) {
		$("#grade").val(gradeParam);
		$('.star-rating span').css({ width: (parseFloat(gradeParam) * 20) + "%" });
	}

	// \uC11C\uBC84\uC0AC\uC774\uB4DC \uAC80\uC0C9 URL \uAD6C\uC131 \uD6C4 \uC774\uB3D9
	function buildAndGo(includeFilters) {
		var params = new URLSearchParams();
		params.set('pageNum', 1);
		var amount = $("#searchForm input[name='amount']").val();
		if (amount) params.set('amount', amount);

		var keyword = $("#searchValue").val() || $("#searchInput").val();
		if (keyword) params.set('keyword', keyword);

		var ci = $("#checkinInput").val(), co = $("#checkoutInput").val();
		if (ci && co) { params.set('checkIn', ci); params.set('checkOut', co); }

		var guests = (parseInt($("#guestsAdults").val(), 10) || 0) + (parseInt($("#guestsChildren").val(), 10) || 0);
		if (guests > 0) params.set('guests', guests);

		if (includeFilters) {
			var lo = $("#slider-range").slider("values", 0);
			var hi = $("#slider-range").slider("values", 1);
			if (lo > 0) params.set('minPrice', lo);
			if (hi < 100000) params.set('maxPrice', hi);

			var g = parseFloat($("#grade").val());
			if (g > 0) params.set('grade', g);

			$("input[name='option']:checked").each(function() { params.set($(this).val(), 'T'); });

			var areas = $("input[name='area']:checked").map(function() { return $(this).val(); }).get();
			if (areas.length) params.set('area', areas.join(','));
		}
		location.href = '/hotel/search_normal?' + params.toString();
	}

	$("#btnApplyFilter").on("click", function() { buildAndGo(true); });
	$("#btnResetFilter").on("click", function() { buildAndGo(false); });
});

// Star rating (별점 표시만; 실제 필터링은 서버에서 수행)
window.drawStar = function(target) {
	$('.star-rating span').css({ width: target.value * 20 + "%" });
};
</script>
