<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%@include file="../includes/header.jsp"%>

<div class="container py-5" style="max-width:900px;">

	<!-- User Info -->
	<div class="mypage-section">
		<h3><i class="bi bi-person-circle"></i> 사용자 정보</h3>
		<table class="table table-borderless mb-3">
			<tbody>
				<tr>
					<th class="text-muted" style="width:120px;">이름</th>
					<td>${member.memberName}</td>
				</tr>
				<tr>
					<th class="text-muted">아이디</th>
					<td>${member.memberId}</td>
				</tr>
				<tr>
					<th class="text-muted">닉네임</th>
					<td>${member.memberNickname}</td>
				</tr>
			</tbody>
		</table>
		<div class="d-flex gap-2 justify-content-end">
			<a href="${contextPath}/member/myPage_memberUpdate?memberNo=${member.memberNo}" class="btn btn-sm btn-outline-hotel">
				<i class="bi bi-pencil"></i> 정보 수정
			</a>
			<a href="${contextPath}/member/myPage_memberDelete?memberNo=${member.memberNo}" class="btn btn-sm btn-outline-danger">
				<i class="bi bi-person-x"></i> 회원 탈퇴
			</a>
		</div>
	</div>

	<!-- Reservations -->
	<div class="mypage-section">
		<h3><i class="bi bi-calendar-check"></i> 예약 내역</h3>
		<div class="table-responsive">
			<table class="table table-hover align-middle">
				<thead class="table-light">
					<tr>
						<th>예약 호텔</th>
						<th>투숙자</th>
						<th>인원</th>
						<th>예약 기간</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<c:if test="${item.reservationNo != null}">
							<td class="fw-semibold">${item.realhotelName}</td>
							<td>
								<c:choose>
									<c:when test="${item.realUser != null}">${item.realUser}</c:when>
									<c:otherwise>${item.memberName}</c:otherwise>
								</c:choose>
							</td>
							<td>${item.userAmount}명</td>
							<td>
								<fmt:formatDate pattern="yyyy-MM-dd" value="${item.checkInDate}" />
								~ <fmt:formatDate pattern="yyyy-MM-dd" value="${item.checkOutDate}" />
							</td>
						</c:if>
						<c:if test="${item.reservationNo == null}">
							<td colspan="4" class="text-center text-muted py-4">예약 내역이 없습니다.</td>
						</c:if>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="text-end">
			<a href="${contextPath}/member/myPage_reservationList?memberNo=${item.memberNo}" class="btn btn-sm btn-outline-hotel">
				전체보기 <i class="bi bi-chevron-right"></i>
			</a>
		</div>
	</div>

	<!-- Reviews -->
	<div class="mypage-section">
		<h3><i class="bi bi-chat-left-text"></i> 내가 쓴 리뷰</h3>
		<div class="table-responsive">
			<table class="table table-hover align-middle">
				<thead class="table-light">
					<tr>
						<th>호텔</th>
						<th>작성자</th>
						<th>리뷰 내용</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${myReviewList}">
						<tr>
							<td class="fw-semibold">${item.realhotelName}</td>
							<td>${item.memberNickname}</td>
							<td>${item.reviewContent}</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${item.reviewDate}" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="text-end">
			<a href="${contextPath}/member/myPage_reviewList?memberNo=${item.memberNo}" class="btn btn-sm btn-outline-hotel">
				전체보기 <i class="bi bi-chevron-right"></i>
			</a>
		</div>
	</div>

	<!-- Wishlist -->
	<div class="mypage-section">
		<h3><i class="bi bi-heart"></i> 찜한 숙소</h3>
		<div class="row g-3">
			<c:forEach var="item" items="${myWishList}" begin="0" end="5" step="1">
				<c:if test="${item.wishListNo != null}">
					<div class="col-6 col-md-4">
						<div class="hotel-card">
							<img src="${item.hotelFileName}" class="card-img" alt="${item.realhotelName}">
							<div class="card-body">
								<h6 class="card-title">${item.realhotelName}</h6>
								<small class="text-muted">${item.state}</small>
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${item.wishListNo == null}">
					<div class="col-12">
						<p class="text-center text-muted py-4">찜한 숙소가 없습니다.</p>
					</div>
				</c:if>
			</c:forEach>
		</div>
		<div class="text-end mt-3">
			<a href="${contextPath}/member/myPage_wishList?memberNo=${item.memberNo}" class="btn btn-sm btn-outline-hotel">
				전체보기 <i class="bi bi-chevron-right"></i>
			</a>
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>
