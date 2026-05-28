<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%@include file="../includes/header.jsp"%>

<div class="container py-5" style="max-width:900px;">
	<div class="mypage-section">
		<h3><i class="bi bi-heart"></i> 내가 찜한 숙소</h3>

		<c:if test="${empty myPageList}">
			<div class="alert alert-light border text-center my-4">
				<i class="bi bi-heart"></i> 아직 찜한 숙소가 없습니다.
			</div>
		</c:if>

		<div class="row g-3">
			<c:forEach var="item" items="${myPageList}">
				<div class="col-6 col-md-4 col-lg-3 wish-item" data-hotelno="${item.hotelno}">
					<div class="hotel-card h-100">
						<a href="/hotel/detail?hotelno=${item.hotelno}" class="text-decoration-none text-dark">
							<c:choose>
								<c:when test="${not empty item.hotelFileName}">
									<img src="/hotel/display?fileName=${fn:escapeXml(item.hotelFileName)}" class="card-img" alt="<c:out value='${item.realhotelname}'/>">
								</c:when>
								<c:otherwise>
									<img src="/resources/hotel/file_repo/1/hotel3.jpg" class="card-img" alt="<c:out value='${item.realhotelname}'/>">
								</c:otherwise>
							</c:choose>
							<div class="card-body">
								<h6 class="card-title"><c:out value="${item.realhotelname}"/></h6>
								<p class="card-location small text-muted mb-0">
									<i class="bi bi-geo-alt"></i> <c:out value="${item.state}"/>
								</p>
							</div>
						</a>
						<div class="px-2 pb-2">
							<button type="button" class="btn btn-sm btn-outline-danger-hotel w-100 btn-wish-remove" data-hotelno="${item.hotelno}">
								<i class="bi bi-heart-fill"></i> 찜 해제
							</button>
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

<script type="text/javascript">
$(function() {
	$(document).on('click', '.btn-wish-remove', function() {
		if (!confirm('찜 목록에서 제거하시겠습니까?')) return;
		var $item = $(this).closest('.wish-item');
		var hotelNo = $item.data('hotelno');
		$.ajax({
			url: '/member/wish?hotelNo=' + hotelNo,
			type: 'DELETE',
			success: function() { $item.fadeOut(250, function() { $(this).remove(); }); },
			error: function() { alert('찜 해제에 실패했습니다.'); }
		});
	});
});
</script>

<%@include file="../includes/footer.jsp"%>
