<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%@include file="../includes/header.jsp"%>

<div class="container py-5" style="max-width:1200px;">

	<!-- Reservations -->
	<div class="mypage-section">
		<h3><i class="bi bi-calendar-check"></i> 예약 내역 조회</h3>
		<div class="table-responsive">
			<table class="table table-hover align-middle">
				<thead class="table-light">
					<tr>
						<th>고객 이름</th>
						<th>지역</th>
						<th>호텔</th>
						<th>객실</th>
						<th>인원</th>
						<th>금액</th>
						<th>예약 기간</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list_reser}" var="list_reser">
						<tr>
							<td>${list_reser.realUser}</td>
							<td><span class="badge-hotel">${list_reser.state}</span></td>
							<td class="fw-semibold">${list_reser.realhotelName}</td>
							<td>${list_reser.roomName}</td>
							<td>${list_reser.userAmount}명</td>
							<td class="text-primary-hotel fw-bold">${list_reser.roomPrice}원</td>
							<td>
								${list_reser.checkInDate}
								~ ${list_reser.checkOutDate}
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<!-- Hotel Registration -->
	<div class="mypage-section">
		<div class="hotel-list-header">
			<div>
				<h3 class="mb-1"><i class="bi bi-building"></i> 등록된 숙소</h3>
				<p class="text-muted mb-0" style="font-size:0.9rem;">
					총 <strong class="text-primary-hotel">${totalCount}</strong>개의 숙소가 등록되어 있습니다
				</p>
			</div>
			<a href="${contextPath}/admin/addHotel" class="btn btn-primary-hotel btn-sm">
				<i class="bi bi-plus-lg"></i> 숙소 등록
			</a>
		</div>

		<!-- Search -->
		<form id="searchForm" action="${contextPath}/admin/main" method="get" class="hotel-list-search">
			<div class="input-group">
				<span class="input-group-text bg-white border-end-0"><i class="bi bi-search"></i></span>
				<input type="text" name="keyword" class="form-control border-start-0"
					   placeholder="숙소명, 지역, 주소로 검색" value="${keyword}">
				<button type="submit" class="btn btn-primary-hotel">검색</button>
			</div>
			<input type="hidden" name="pageNum" value="1">
			<input type="hidden" name="amount" value="10">
		</form>

		<!-- Table -->
		<div class="table-responsive">
			<table class="table table-hover align-middle hotel-manage-table">
				<thead>
					<tr>
						<th style="width:60px;">썸네일</th>
						<th>숙소명</th>
						<th>지역</th>
						<th>주소</th>
						<th>전화번호</th>
						<th style="width:100px;">편의시설</th>
						<th style="width:90px;">등록일</th>
						<th style="width:80px;">등록자</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty list}">
							<tr>
								<td colspan="8" class="text-center py-5 text-muted">
									<i class="bi bi-inbox" style="font-size:2rem;"></i>
									<p class="mt-2 mb-0">등록된 숙소가 없습니다</p>
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${list}" var="hotel">
								<tr class="hotel-row" onclick="location.href='/hotel/detail?hotelno=${hotel.hotelNo}'" style="cursor:pointer;">
									<td>
										<div class="hotel-thumb">
											<c:choose>
												<c:when test="${not empty hotel.hotelFileName}">
													<img src="/hotel/display?fileName=${hotel.hotelFileName}" alt="${hotel.hotelName}">
												</c:when>
												<c:otherwise>
													<div class="hotel-thumb-empty"><i class="bi bi-image"></i></div>
												</c:otherwise>
											</c:choose>
										</div>
									</td>
									<td><span class="fw-semibold">${hotel.hotelName}</span></td>
									<td><span class="badge-hotel">${hotel.mainAddress}</span></td>
									<td class="text-muted" style="font-size:0.85rem;">${hotel.address}</td>
									<td style="font-size:0.85rem;">${hotel.hotelPhoneNo}</td>
									<td>
										<div class="amenity-icons">
											<c:if test="${hotel.parking == 't'}"><span title="주차"><i class="bi bi-p-circle-fill"></i></span></c:if>
											<c:if test="${hotel.wifi == 't'}"><span title="와이파이"><i class="bi bi-wifi"></i></span></c:if>
											<c:if test="${hotel.swim == 't'}"><span title="수영장"><i class="bi bi-water"></i></span></c:if>
											<c:if test="${hotel.fitness == 't'}"><span title="피트니스"><i class="bi bi-heart-pulse"></i></span></c:if>
											<c:if test="${hotel.restaurant == 't'}"><span title="레스토랑"><i class="bi bi-cup-hot"></i></span></c:if>
											<c:if test="${hotel.buffet == 't'}"><span title="조식"><i class="bi bi-egg-fried"></i></span></c:if>
											<c:if test="${hotel.pet == 't'}"><span title="반려동물"><i class="bi bi-emoji-heart-eyes"></i></span></c:if>
											<c:if test="${hotel.golf == 't'}"><span title="골프"><i class="bi bi-trophy"></i></span></c:if>
											<c:if test="${hotel.kitchen == 't'}"><span title="주방"><i class="bi bi-fire"></i></span></c:if>
											<c:if test="${hotel.smoke == 't'}"><span title="흡연"><i class="bi bi-wind"></i></span></c:if>
										</div>
									</td>
									<td style="font-size:0.83rem;">
										<fmt:formatDate value="${hotel.hotelRegistDate}" pattern="yyyy-MM-dd"/>
									</td>
									<td style="font-size:0.85rem;">${hotel.memberNickname}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>

		<!-- Pagination -->
		<c:if test="${pageMaker != null}">
		<c:set var="pm" value="${pageMaker}" />
		<nav>
			<ul class="pagination justify-content-center mb-0">
				<c:if test="${pm.prev}">
					<li class="page-item">
						<a class="page-link" href="${contextPath}/admin/main?pageNum=${pm.startPage - 1}&amount=${pm.cri.amount}&keyword=${keyword}">&laquo;</a>
					</li>
				</c:if>
				<c:forEach var="num" begin="${pm.startPage}" end="${pm.endPage}">
					<li class="page-item ${pm.cri.pageNum == num ? 'active' : ''}">
						<a class="page-link" href="${contextPath}/admin/main?pageNum=${num}&amount=${pm.cri.amount}&keyword=${keyword}">${num}</a>
					</li>
				</c:forEach>
				<c:if test="${pm.next}">
					<li class="page-item">
						<a class="page-link" href="${contextPath}/admin/main?pageNum=${pm.endPage + 1}&amount=${pm.cri.amount}&keyword=${keyword}">&raquo;</a>
					</li>
				</c:if>
			</ul>
		</nav>
		</c:if>
	</div>

	<!-- Reported Reviews -->
	<div class="mypage-section">
		<h3><i class="bi bi-flag"></i> 신고 리뷰 조회</h3>
		<div class="table-responsive">
			<table class="table table-hover align-middle">
				<thead class="table-light">
					<tr>
						<th>작성자</th>
						<th>별점</th>
						<th>리뷰 내용</th>
						<th>작성일</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list_review}" var="list_review">
						<tr>
							<td>${list_review.memberNickname}</td>
							<td><span class="text-warning">${list_review.grade} &#9733;</span></td>
							<td>${list_review.reviewContent}</td>
							<td>${list_review.reviewDate}</td>
							<td><button id="reviewBtn" class="btn btn-sm btn-outline-danger">삭제</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>

<script>
let moveForm = $('#moveForm');

$(".pageMaker_btn a").on("click", function(e) {
	e.preventDefault();
	moveForm.find("input[name='pageNum']").val($(this).attr("href"));
	moveForm.submit();
});

$("#reviewBtn").on("click", function() {
	$.ajax({
		type: "post",
		url: "/admin/reviewDelete",
		data: data,
		success: success,
		dataType: dataType
	});
});
</script>
