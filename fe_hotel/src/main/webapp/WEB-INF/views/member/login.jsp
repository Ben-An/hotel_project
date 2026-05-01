<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>심사숙소 - 로그인</title>

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&display=swap" rel="stylesheet">

<!-- Bootstrap -->
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Custom CSS -->
<link href="/resources/css/style.css" rel="stylesheet">
</head>
<body>
<div class="auth-page">
	<div class="auth-card">
		<div class="auth-logo">
			<a href="/hotel/index">심사숙소</a>
		</div>
		<h2>로그인</h2>

		<form id="login_form" method="post">
			<div class="mb-3">
				<label for="memberId" class="form-label">아이디</label>
				<input type="text" class="form-control" id="memberId" name="memberId" placeholder="아이디를 입력하세요">
			</div>

			<div class="mb-3">
				<label for="memberPassword" class="form-label">비밀번호</label>
				<input type="password" class="form-control" id="memberPassword" name="memberPassword" placeholder="비밀번호를 입력하세요">
			</div>

			<div class="d-flex justify-content-end mb-3">
				<small>
					<a href="#" class="text-muted text-decoration-none find_id_link">아이디 찾기</a>
					<span class="text-muted mx-1">|</span>
					<a href="#" class="text-muted text-decoration-none find_pw_link">비밀번호 찾기</a>
				</small>
			</div>

			<c:if test="${result == 0}">
				<div class="alert alert-danger py-2 text-center" role="alert">
					<small>아이디 또는 비밀번호를 잘못 입력하셨습니다.</small>
				</div>
			</c:if>

			<button class="btn btn-primary-hotel w-100 py-2 mb-3" type="submit">로그인</button>

			<a href="${url}" class="btn w-100 py-2 mb-3"
				style="background-color:#03C75A; color:#fff; font-weight:600;">
				Naver로 로그인
			</a>

			<div class="text-center">
				<small class="text-muted">계정이 없으신가요? <a href="/member/join" class="text-primary-hotel fw-semibold">회원가입</a></small>
			</div>
		</form>
	</div>
</div>

<!-- 아이디 찾기 모달 -->
<div class="modal fade" id="findIdModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">아이디 찾기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="mb-3">
					<label class="form-label">이름</label>
					<input type="text" class="form-control find_id_name" placeholder="이름을 입력하세요">
				</div>
				<div class="mb-3">
					<label class="form-label">이메일</label>
					<input type="email" class="form-control find_id_email" placeholder="가입 시 등록한 이메일">
				</div>
				<div class="find_id_result"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary-hotel find_id_submit">아이디 찾기</button>
			</div>
		</div>
	</div>
</div>

<!-- 비밀번호 찾기 모달 -->
<div class="modal fade" id="findPwModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">비밀번호 찾기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="mb-3">
					<label class="form-label">아이디</label>
					<input type="text" class="form-control find_pw_id" placeholder="아이디를 입력하세요">
				</div>
				<div class="mb-3">
					<label class="form-label">이메일</label>
					<input type="email" class="form-control find_pw_email" placeholder="가입 시 등록한 이메일">
				</div>
				<div class="find_pw_result"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary-hotel find_pw_submit">임시 비밀번호 발송</button>
			</div>
		</div>
	</div>
</div>

<script>
$('#login_form').on('submit', function(e) {
	e.preventDefault();
	$(this).attr("action", "/member/login");
	$(this).off('submit').submit();
});

// 아이디/비밀번호 찾기 모달 열기
$('.find_id_link').on('click', function(e) {
	e.preventDefault();
	$('.find_id_name, .find_id_email').val('');
	$('.find_id_result').html('');
	new bootstrap.Modal(document.getElementById('findIdModal')).show();
});
$('.find_pw_link').on('click', function(e) {
	e.preventDefault();
	$('.find_pw_id, .find_pw_email').val('');
	$('.find_pw_result').html('');
	new bootstrap.Modal(document.getElementById('findPwModal')).show();
});

// 아이디 찾기 제출
$('.find_id_submit').on('click', function() {
	var memberName = $('.find_id_name').val().trim();
	var memberEmail = $('.find_id_email').val().trim();
	var resultBox = $('.find_id_result');

	if (!memberName || !memberEmail) {
		resultBox.html('<div class="alert alert-danger py-2 mb-0"><small>이름과 이메일을 모두 입력해주세요.</small></div>');
		return;
	}

	$.ajax({
		type: 'POST',
		url: '/member/findId',
		contentType: 'application/json',
		data: JSON.stringify({ memberName: memberName, memberEmail: memberEmail }),
		success: function(data) {
			if (data && data.status === 'success') {
				resultBox.html('<div class="alert alert-success py-2 mb-0"><small>회원님의 아이디는 <b>' + data.memberId + '</b> 입니다.</small></div>');
			} else {
				resultBox.html('<div class="alert alert-warning py-2 mb-0"><small>일치하는 회원 정보가 없습니다.</small></div>');
			}
		},
		error: function() {
			resultBox.html('<div class="alert alert-danger py-2 mb-0"><small>요청 처리 중 오류가 발생했습니다.</small></div>');
		}
	});
});

// 비밀번호 찾기 제출
$('.find_pw_submit').on('click', function() {
	var memberId = $('.find_pw_id').val().trim();
	var memberEmail = $('.find_pw_email').val().trim();
	var resultBox = $('.find_pw_result');

	if (!memberId || !memberEmail) {
		resultBox.html('<div class="alert alert-danger py-2 mb-0"><small>아이디와 이메일을 모두 입력해주세요.</small></div>');
		return;
	}

	resultBox.html('<div class="alert alert-info py-2 mb-0"><small>임시 비밀번호 발송 중...</small></div>');

	$.ajax({
		type: 'POST',
		url: '/member/findPw',
		contentType: 'application/json',
		data: JSON.stringify({ memberId: memberId, memberEmail: memberEmail }),
		success: function(data) {
			if (data && data.status === 'success') {
				resultBox.html('<div class="alert alert-success py-2 mb-0"><small>등록된 이메일로 임시 비밀번호를 발송했습니다.</small></div>');
			} else if (data && data.status === 'mailFail') {
				resultBox.html('<div class="alert alert-danger py-2 mb-0"><small>메일 발송에 실패했습니다. 잠시 후 다시 시도해주세요.</small></div>');
			} else {
				resultBox.html('<div class="alert alert-warning py-2 mb-0"><small>일치하는 회원 정보가 없습니다.</small></div>');
			}
		},
		error: function() {
			resultBox.html('<div class="alert alert-danger py-2 mb-0"><small>요청 처리 중 오류가 발생했습니다.</small></div>');
		}
	});
});
</script>

<script src="/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
