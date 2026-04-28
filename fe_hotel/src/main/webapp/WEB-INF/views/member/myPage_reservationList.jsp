<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%@include file="../includes/header.jsp"%>

<div class="container py-5" style="max-width:900px;">
	<div class="mypage-section">
		<h3><i class="bi bi-calendar-check"></i> 전체 예약 내역</h3>
		<div class="table-responsive">
			<table class="table table-hover align-middle">
				<thead class="table-light">
					<tr>
						<th>예약 호텔</th>
						<th>예약 인원</th>
						<th>예약 기간</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${myPageList}">
						<tr>
							<td class="fw-semibold">${item.hotelName}</td>
							<td>${item.memberAmount}명</td>
							<td>
								<fmt:formatDate pattern="yyyy-MM-dd" value="${item.checkInDate}" />
								~ <fmt:formatDate pattern="yyyy-MM-dd" value="${item.checkOutDate}" />
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="text-center mt-3">
			<a href="/member/myPage" class="btn btn-outline-hotel">
				<i class="bi bi-arrow-left"></i> 마이페이지로 돌아가기
			</a>
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>
