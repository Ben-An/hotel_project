<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

<div class="container py-5">
	<h2 class="fw-bold mb-4">예약 확인</h2>

	<input type="hidden" name="userAmount" value='<c:out value="${reservationList.roomguest}"/>' />
	<input type="hidden" name="memberNo" value='<c:out value="${member.memberNo}"/>' />

	<div class="row g-4">
		<!-- Left: Reservation Info -->
		<div class="col-lg-7">
			<div class="p-4 bg-white rounded shadow-sm border">
				<h4 class="fw-bold mb-4">예약자 정보</h4>

				<div class="mb-4">
					<label class="form-label fw-semibold">예약자 이름</label>
					<input type="text" class="form-control bg-light" name="realUser"
						value='<c:out value="${member.memberName}"/>' readonly>
				</div>

				<div class="mb-4">
					<label class="form-label fw-semibold">휴대폰 번호</label>
					<input type="text" class="form-control bg-light"
						value='<c:out value="${member.memberPhoneNo}"/>' readonly>
				</div>

				<hr class="my-4">

				<h5 class="fw-bold mb-3">약관 동의</h5>
				<div class="d-flex flex-column gap-3" onclick="chkReserve()">
					<div class="form-check">
						<input type="checkbox" class="form-check-input" id="check1" name="option1" required>
						<label class="form-check-label" for="check1">숙소이용규칙 및 취소/환불규정 동의</label>
					</div>
					<div class="form-check">
						<input type="checkbox" class="form-check-input" id="check2" name="option2" required>
						<label class="form-check-label" for="check2">개인정보 수집 및 이용 동의</label>
					</div>
					<div class="form-check">
						<input type="checkbox" class="form-check-input" id="check3" name="option3" required>
						<label class="form-check-label" for="check3">개인정보 제3자 제공 동의</label>
					</div>
				</div>
			</div>
		</div>

		<!-- Right: Summary -->
		<div class="col-lg-5">
			<div class="reservation-summary">
				<h4 class="fw-bold mb-4">예약 상세</h4>

				<div class="summary-item">
					<div class="summary-label">숙소</div>
					<div class="summary-value"><c:out value="${reservationList.realhotelname}" /></div>
				</div>

				<div class="summary-item">
					<div class="summary-label">객실</div>
					<div class="summary-value"><c:out value="${reservationList.roomname}" /></div>
				</div>

				<div class="summary-item">
					<div class="summary-label">체크인</div>
					<div class="summary-value" id="checkIndate">
						<i class="bi bi-calendar-check"></i>
						<fmt:formatDate value="${reservationList.checkIndate}" pattern="yyyy-MM-dd" />
					</div>
				</div>

				<div class="summary-item">
					<div class="summary-label">체크아웃</div>
					<div class="summary-value" id="checkOutDate">
						<i class="bi bi-calendar-x"></i>
						<fmt:formatDate value="${reservationList.checkOutDate}" pattern="yyyy-MM-dd" />
					</div>
				</div>

				<hr>

				<div class="summary-item">
					<div class="summary-label">총 결제 금액</div>
					<div class="total-price">
						<c:out value="${reservationList.roomPrice}" />원
					</div>
				</div>

				<button class="btn btn-primary-hotel w-100 py-3 mt-3" type="submit" id="btn"
					onClick="kakaoPay()" disabled>
					<i class="bi bi-credit-card"></i> 결제하기
				</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="/resources/js/reservation.js"></script>
<script type="text/javascript">
function kakaoPay() {
	$.ajax({
		type: 'POST',
		url: '/hotel/kakaoPay.cls',
		dataType: 'json',
		success: function(data) {
			window.open(data.next_redirect_pc_url);
		},
		error: function(error) {
			alert(error);
		}
	});
}

$(function() {
	var memberNo = '<c:out value="${member.memberNo}"/>';
	var roomNo = '<c:out value="${reservationList.roomno}"/>';
	var realUser = '<c:out value="${member.memberName}"/>';
	var checkInDate = $('#checkIndate').text().trim();
	var checkOutDate = $('#checkOutDate').text().trim();
	var userAmount = '<c:out value="${reservationList.roomguest}"/>';
	var payment = '<c:out value="${reservationList.roomPrice}"/>';

	$('#btn').click(function() {
		var reservation = {
			memberNo: memberNo,
			roomNo: roomNo,
			realUser: realUser,
			checkInDate: checkInDate,
			checkOutDate: checkOutDate,
			userAmount: userAmount,
			payment: payment
		};

		reservationService.add(reservation, function(result) {
			alert(result);
		});
	});
});

function chkReserve() {
	var check1 = document.querySelector('#check1');
	var check2 = document.querySelector('#check2');
	var check3 = document.querySelector('#check3');
	var btn = document.querySelector('#btn');

	btn.disabled = !(check1.checked && check2.checked && check3.checked);
}
</script>

<%@include file="../includes/footer.jsp"%>
