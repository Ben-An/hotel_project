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

<script>
$('#login_form').on('submit', function(e) {
	e.preventDefault();
	$(this).attr("action", "/member/login");
	$(this).off('submit').submit();
});
</script>

<script src="/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
