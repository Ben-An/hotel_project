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

	// Price slider
	$("#slider-range").slider({
		range: true,
		min: 0,
		max: 100000,
		step: 5000,
		values: [0, 100000],
		slide: function(event, ui) {
			$("#price").val("\u20A9" + ui.values[0].toLocaleString() + " ~ \u20A9" + ui.values[1].toLocaleString());
		}
	});
	$("#price").val("\u20A9" + $("#slider-range").slider("values", 0).toLocaleString() +
		" ~ \u20A9" + $("#slider-range").slider("values", 1).toLocaleString());

	$("#slider-range").on("slidechange", function() { filterApply(); });

	// Checkbox event
	$("input[name='option']").on("change", function() { filterApply(); });
});

// Star rating
const drawStar = function(target) {
	$('.star-rating span').css({ width: target.value * 20 + "%" });
	filterApply();
};

// Filter variables
var allHotels = $('.hotelContent');

// Filter function
const filterApply = function() {
	$('.hotelContent').removeClass("filtered");

	var lowPrice = parseInt($("#slider-range").children('span')[0].style.left.replace('%', '')) * 1000;
	var highPrice = parseInt($("#slider-range").children('span')[1].style.left.replace('%', '')) * 1000;
	var searchGrade = document.getElementById("grade").value;
	var selectedFilters = $("input[name='option']:checked");
	var leng = selectedFilters.length;

	for (var i = 0; i < allHotels.length; i++) {
		var hotel = allHotels[i];
		var roomPrice = parseInt(hotel.querySelector('.roomPrice').innerText.replace(/,/g, "").replace(/원/g, ""));
		var averageGrade = hotel.querySelector('.averageGrade').innerText;
		var facility = hotel.querySelector(".facility").innerText;

		if (roomPrice < lowPrice || roomPrice > highPrice) {
			hotel.classList.add("filtered");
		} else if (averageGrade < searchGrade) {
			hotel.classList.add("filtered");
		} else if (leng > 0) {
			for (var j = 0; j < leng; j++) {
				var value = selectedFilters[j].value.toLowerCase();
				if (facility.indexOf(value) < 0) {
					hotel.classList.add("filtered");
					break;
				}
			}
		}
	}
};
</script>
