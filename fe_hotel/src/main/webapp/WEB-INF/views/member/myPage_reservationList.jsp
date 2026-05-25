<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%@include file="../includes/header.jsp"%>

<div class="container py-5" style="max-width:900px;">
	<div class="mypage-section">
		<h3><i class="bi bi-calendar-check"></i> 전체 예약 내역</h3>

		<c:if test="${empty myPageList}">
			<div class="alert alert-light border text-center my-4">
				<i class="bi bi-calendar-x"></i> 예약 내역이 없습니다.
			</div>
		</c:if>

		<c:if test="${not empty myPageList}">
		<div class="table-responsive">
			<table class="table table-hover align-middle">
				<thead class="table-light">
					<tr>
						<th>예약 호텔</th>
						<th>객실</th>
						<th>예약 인원</th>
						<th>예약 기간</th>
						<th class="text-end">관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${myPageList}">
						<tr class="reservation-row" data-reservno="${item.reservationNo}">
							<td class="fw-semibold"><c:out value="${item.realhotelname}" /></td>
							<td><c:out value="${item.roomname}" /></td>
							<td><c:out value="${item.userAmount}" />명</td>
							<td>
								<fmt:formatDate pattern="yyyy-MM-dd" value="${item.checkIndate}" />
								~ <fmt:formatDate pattern="yyyy-MM-dd" value="${item.checkOutDate}" />
							</td>
							<td class="text-end">
								<button type="button" class="btn btn-sm btn-outline-danger btn-cancel-reserv"
									data-reservno="${item.reservationNo}">
									<i class="bi bi-x-circle"></i> 취소
								</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		</c:if>

		<div class="text-center mt-3">
			<a href="/member/myPage" class="btn btn-outline-hotel">
				<i class="bi bi-arrow-left"></i> 마이페이지로 돌아가기
			</a>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$(document).on('click', '.btn-cancel-reserv', function() {
		if (!confirm('이 예약을 취소하시겠습니까?')) return;
		var $row = $(this).closest('.reservation-row');
		var reservNo = $row.data('reservno');
		$.ajax({
			url: '/member/reservation/' + reservNo,
			type: 'DELETE',
			success: function() {
				alert('예약이 취소되었습니다.');
				$row.fadeOut(250, function() { $(this).remove(); });
			},
			error: function() { alert('예약 취소에 실패했습니다.'); }
		});
	});
});
</script>

<%@include file="../includes/footer.jsp"%>
