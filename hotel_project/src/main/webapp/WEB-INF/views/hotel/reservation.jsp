<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@include file="../includes/header.jsp"%>



<div class="container mt-5">
	<div class="row">
		<h1>예약자정보</h1>


		<input type="hidden" name="userAmount"
			value='<c:out value="${reservationList.roomguest }"/>' /> <input
			type="hidden" name="memberNo"
			value='<c:out value="${member.memberNo }"/>' />
		<div class="col-sm-6">
			<div class="mt-3">
				<strong class="user_profile">예약자 이름 : </strong> <br> <input
					type="text" class=" form-control-lg mt-3"
					style="padding: 10px; background-color: #dddddd" name="realUser"
					value='<c:out value="${member.memberName}"/>' readonly>

			</div>

			<div class="mt-5">
				<strong class="user_profile">휴대폰 번호:</strong> <br> <input
					type="text" class=" form-control-lg mt-3"
					style="padding: 10px; background-color: #dddddd" name=""
					value='<c:out value="${member.memberPhoneNo}"/>' readonly>
			</div>



			<div class="mt-5" onclick="chkReserve()">
				<div class="form-check">
					<input type="checkbox" class="form-check-input" id="check1"
						name="option1" value="something" required> <label
						class="form-check-label" for="check1">숙소이용규칙 및 취소/환불규정 동의</label>
				</div>
				<div class="form-check">
					<input type="checkbox" class="form-check-input" id="check2"
						name="option2" value="something" required> <label
						class="form-check-label" for="check2">개인정보 수집 및 이용 동의</label>
				</div>
				<div class="form-check">
					<input type="checkbox" class="form-check-input" id="check3"
						name="option2" value="something" required> <label
						class="form-check-label" for="check2">개인정보 제 3자 제공 동의</label>
				</div>

			</div>



		</div>




		<div class="col-sm-6"
			style="background-color: #dddddd; height: 700px; width: 500px; padding: 20px">
			<div class="row">
				<div class="col-12 mt-3">
					<h4 class="reserve_info">
						<strong class="reserve_name">숙소이름:</strong> <br>
						<c:out value="${reservationList.realhotelname}" />

					</h4>
				</div>

				<div class="col-12 mt-3">
					<h4 class="reserve_info">
						<strong class="reserve_name">객실타입:</strong> <br>
						<c:out value="${reservationList.roomname}" />
					</h4>

				</div>


				<div class="col-12 mt-3">
					<h4 class="reserve_info">
						<strong class="reserve_name">체크인:</strong> <br> <span
							id="checkIndate"> <fmt:formatDate
								value="${reservationList.checkIndate}" pattern="yyyy-MM-dd" />
						</span>

					</h4>

				</div>


				<div class="col-12 mt-3">
					<h4 class="reserve_info">
						<strong class="reserve_name">체크아웃:</strong> <br> <span
							id="checkOutDate"> <fmt:formatDate
								value="${reservationList.checkOutDate }" pattern="yyyy-MM-dd" />
						</span>

					</h4>

				</div>



			</div>




			<div class="row" style="margin-top: 170px;">
				<hr>
				<div class="col-12">

					<strong class="reserve_name" style="color: black;">총 결제
						금액:</strong>
				</div>

				<div class="col-12">


					<strong class="reserve_name"
						style="color: #FF8C00; font-size: 30px;"><c:out
							value="${reservationList.roomPrice}" /></strong><strong
						class="reserve_name" style="color: black; font-size: 30px;">
						원</strong>

				</div>



				<div class="col-12 mt-3">
					<button class="btn" type="submit" id="btn"
						style="width: 100%; height: 56px; background: #FF8C00; color: white; border: none;"
						onClick="kakaoPay()" disabled>결제하기</button>
				</div>

			</div>



		</div>


	</div>
</div>




<script type="text/javascript" src="/resources/js/reservation.js"></script>
<script type="text/javascript">
	function kakaoPay() {

		$.ajax({
			type : 'POST',
			url : '/hotel/kakaoPay.cls',
			dataType : 'json',
			success : function(data) {
			 	
				window.open(data.next_redirect_pc_url); 
				
		
				
				

			},

			error : function(error) {

				alert(error);

			}
		}); //ajax end

	}; //end kakaoPayAPI

	$(function() {

		var memberNo = '<c:out value="${member.memberNo}"/>';
		var roomNo = '<c:out value="${reservationList.roomno }"/>';
		var realUser = '<c:out value="${member.memberName}"/>';
		var checkInDate = $('#checkIndate').text();
		var checkOutDate = $('#checkOutDate').text();
		var userAmount = '<c:out value="${reservationList.roomguest }"/>';
		var payment = '<c:out value="${reservationList.roomPrice}"/>';

		console.log("checkOutDate >>>>>>>>>>>>> ", checkOutDate);

		$('#btn').click(function() {

			var reservation = {
				memberNo : memberNo,
				roomNo : roomNo,
				realUser : realUser,
				checkInDate : checkInDate,
				checkOutDate : checkOutDate,
				userAmount : userAmount,
				payment : payment

			};

			console.log(reservation);

			reservationService.add(reservation, function(result) {

				alert(result);
				
				/* window.location.replace("/hotel/index"); */

			});

		});

	});//reservation table에 값 집어넣기

	/* 체크 박스 모두 클릭을 하여야 결제가능함 */
	function chkReserve() {
		const check1 = document.querySelector('#check1');
		const check2 = document.querySelector('#check2');
		const check3 = document.querySelector('#check3');
		const btn = document.querySelector('#btn');

		if (check1.checked == true && check2.checked == true
				&& check3.checked == true) {
			btn.disabled = false
		} else {
			btn.disabled = true
		}
	};
</script>





<%@include file="../includes/footer.jsp"%>