<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%@include file="../includes/header.jsp"%>

<!-- Recommended Hotels -->
<section class="recommend-section">
	<div class="container">
		<h2>추천 숙소</h2>
		<p class="subtitle">경기도 인기 숙소를 만나보세요</p>

		<div class="row g-4">
			<c:forEach var="item" items="${list}">
				<div class="col-12 col-sm-6 col-lg-3">
					<div class="hotel-card" data-hotelno="${item.hotelno}">
						<div class="card-img-wrap">
							<div id="carousel-${item.hotelno}" class="carousel slide" data-bs-ride="false">
								<div class="carousel-inner">
									<div class="carousel-item active">
										<a href="/hotel/detail?hotelno=${item.hotelno}&memberNo=${member.memberNo}">
											<img src="/hotel/display?fileName=${item.hotelFileName}" class="d-block card-img" alt="${item.realhotelname}">
										</a>
									</div>
								</div>
								<button class="carousel-control-prev" type="button" data-bs-target="#carousel-${item.hotelno}" data-bs-slide="prev" style="display:none;">
									<span class="carousel-control-prev-icon" aria-hidden="true"></span>
								</button>
								<button class="carousel-control-next" type="button" data-bs-target="#carousel-${item.hotelno}" data-bs-slide="next" style="display:none;">
									<span class="carousel-control-next-icon" aria-hidden="true"></span>
								</button>
							</div>
							<span class="badge-hotel">추천</span>
						</div>
						<a href="/hotel/detail?hotelno=${item.hotelno}&memberNo=${member.memberNo}" class="text-decoration-none text-dark">
							<div class="card-body">
								<h5 class="card-title">${item.realhotelname}</h5>
								<p class="card-location">
									<i class="fas fa-map-marker-alt"></i>
									<c:choose>
										<c:when test="${not empty item.roadaddr}">${item.roadaddr}</c:when>
										<c:otherwise>${item.mainAddress}</c:otherwise>
									</c:choose>
								</p>
								<div class="card-footer-info">
									<div class="card-rating review">
										<div class="rating" data-rate="${item.ag}">
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
										</div>
										<span class="rating-score">${item.ag}</span>
									</div>
								</div>
							</div>
						</a>
					</div>
				</div>
			</c:forEach>
		</div>

		<!-- 페이지네이션 -->
		<c:if test="${pageMaker != null && pageMaker.total > pageMaker.amount}">
		<nav class="mt-4">
			<ul class="pagination justify-content-center">
				<c:if test="${pageMaker.prev}">
					<li class="page-item">
						<a class="page-link" href="/hotel/index?pageNum=${pageMaker.startPage - 1}&amount=${pageMaker.amount}">&laquo;</a>
					</li>
				</c:if>

				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li class="page-item ${pageMaker.pageNum == num ? 'active' : ''}">
						<a class="page-link" href="/hotel/index?pageNum=${num}&amount=${pageMaker.amount}">${num}</a>
					</li>
				</c:forEach>

				<c:if test="${pageMaker.next}">
					<li class="page-item">
						<a class="page-link" href="/hotel/index?pageNum=${pageMaker.endPage + 1}&amount=${pageMaker.amount}">&raquo;</a>
					</li>
				</c:if>
			</ul>
		</nav>
		</c:if>

	</div>
</section>

<script type="text/javascript">

/* Star rating color */
function applyStarRating() {
	var rating = $('.review .rating');
	rating.each(function() {
		var targetScore = parseInt($(this).attr('data-rate'));
		if (targetScore > 0) {
			$(this).find('svg:nth-child(-n+' + targetScore + ')').css({
				color: '#F05522'
			});
		}
	});
}

$(document).ready(function() {

	applyStarRating();
	loadHotelCarousels();

	/* ===== Hotel Card Carousels ===== */
	function loadHotelCarousels() {
		$('.hotel-card[data-hotelno]').each(function() {
			var $card = $(this);
			var hotelNo = $card.data('hotelno');
			var $inner = $card.find('.carousel-inner');
			var detailHref = $card.find('.card-body').parent('a').attr('href');

			$.getJSON('/hotel/getAttachList', { hotelNo: hotelNo }, function(list) {
				if (!list || list.length <= 1) return;

				var str = '';
				for (var i = 0; i < list.length; i++) {
					var activeClass = (i === 0) ? ' active' : '';
					str += "<div class='carousel-item" + activeClass + "'>";
					str += "<a href='" + detailHref + "'>";
					str += "<img src='/hotel/display?fileName=" + list[i].hotelFileName + "' class='d-block card-img' alt=''>";
					str += "</a></div>";
				}
				$inner.html(str);
				$card.find('.carousel-control-prev, .carousel-control-next').show();
			});
		});

		// 캐러셀 화살표 클릭 시 링크 이동 방지
		$(document).on('click', '.hotel-card .carousel-control-prev, .hotel-card .carousel-control-next', function(e) {
			e.stopPropagation();
		});
	}

});
</script>

<%@include file="../includes/footer.jsp"%>
