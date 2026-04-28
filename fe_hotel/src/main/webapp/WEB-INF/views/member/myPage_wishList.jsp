<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%@include file="../includes/header.jsp"%>

<div class="container py-5" style="max-width:900px;">
	<div class="mypage-section">
		<h3><i class="bi bi-heart"></i> 내가 찜한 숙소</h3>
		<div class="row g-3">
			<c:forEach var="item" items="${myPageList}">
				<div class="col-6 col-md-4 col-lg-3">
					<div class="hotel-card">
						<img src="${item.hotelFileName}" class="card-img" alt="${item.hotelName}">
						<div class="card-body">
							<h6 class="card-title">${item.hotelName}</h6>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		<div class="text-center mt-4">
			<a href="/member/myPage" class="btn btn-outline-hotel">
				<i class="bi bi-arrow-left"></i> 마이페이지로 돌아가기
			</a>
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>
