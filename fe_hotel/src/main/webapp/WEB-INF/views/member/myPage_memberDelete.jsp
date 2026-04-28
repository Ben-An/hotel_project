<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>심사숙소 - 회원 탈퇴</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&display=swap" rel="stylesheet">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="/resources/css/style.css" rel="stylesheet">
</head>
<body>
<div class="auth-page">
	<div class="auth-card" style="max-width:420px;">
		<div class="auth-logo"><a href="/hotel/index">심사숙소</a></div>
		<h2>회원 탈퇴</h2>

		<div class="alert alert-warning" role="alert">
			<i class="bi bi-exclamation-triangle"></i>
			탈퇴 시 모든 정보가 삭제되며 복구할 수 없습니다.
		</div>

		<form id="update_form" method="post">
			<div class="mb-3">
				<label class="form-label">아이디</label>
				<input class="form-control bg-light" type="text" name="memberId" value="${member.memberId}" readonly>
			</div>
			<div class="mb-4">
				<label class="form-label">비밀번호 확인</label>
				<input class="form-control" type="password" name="memberPassword" placeholder="비밀번호를 입력하세요">
			</div>
			<button type="submit" class="btn btn-danger w-100 py-2 mb-3">
				<i class="bi bi-person-x"></i> 탈퇴하기
			</button>
			<div class="text-center">
				<a href="/member/myPage" class="text-muted">돌아가기</a>
			</div>
		</form>
	</div>
</div>

<script src="/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
