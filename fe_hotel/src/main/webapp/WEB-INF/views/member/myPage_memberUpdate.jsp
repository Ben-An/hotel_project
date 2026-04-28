<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>심사숙소 - 정보 수정</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&display=swap" rel="stylesheet">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="/resources/css/style.css" rel="stylesheet">
</head>
<body>
<div class="auth-page" style="padding:2rem;">
	<div class="auth-card" style="max-width:500px;">
		<div class="auth-logo"><a href="/hotel/index">심사숙소</a></div>
		<h2>회원 정보 수정</h2>

		<form id="update_form" method="post">
			<div class="mb-3">
				<label class="form-label">아이디</label>
				<input class="form-control bg-light" type="text" name="memberId" value="${member.memberId}" readonly>
			</div>
			<div class="mb-3">
				<label class="form-label">비밀번호</label>
				<input class="form-control pw_input" type="password" name="memberPassword" placeholder="새 비밀번호">
				<small class="invalid-msg final_pw_ck">비밀번호를 입력해주세요.</small>
			</div>
			<div class="mb-3">
				<label class="form-label">비밀번호 확인</label>
				<input class="form-control pwck_input" type="password" placeholder="비밀번호 확인">
				<small class="invalid-msg final_pwck_ck">비밀번호 확인을 입력해주세요.</small>
				<small class="valid-msg pwck_input_re_1">비밀번호가 일치합니다.</small>
				<small class="invalid-msg pwck_input_re_2">비밀번호가 일치하지 않습니다.</small>
			</div>
			<div class="mb-3">
				<label class="form-label">이름</label>
				<input class="form-control user_input" type="text" name="memberName" value="${member.memberName}">
				<small class="invalid-msg final_name_ck">이름을 입력해주세요.</small>
			</div>
			<div class="mb-3">
				<label class="form-label">닉네임</label>
				<input class="form-control usernn_input" type="text" name="memberNickname" value="${member.memberNickname}">
				<small class="invalid-msg final_nickname_ck">닉네임을 입력해주세요.</small>
			</div>
			<div class="mb-3">
				<label class="form-label">이메일</label>
				<input class="form-control mail_input" type="email" name="memberEmail" value="${member.memberEmail}">
				<small class="invalid-msg final_mail_ck">이메일을 입력해주세요.</small>
				<small class="mail_input_box_warn" style="display:none;"></small>
				<div class="input-group mt-2">
					<input class="form-control mail_check_input" placeholder="인증번호 입력" disabled>
					<button class="btn btn-outline-secondary mail_check_button" type="button">인증번호 전송</button>
				</div>
				<small id="mail_check_input_box_warn"></small>
			</div>
			<div class="mb-3">
				<label class="form-label">휴대폰 번호</label>
				<input class="form-control hp_input" type="text" name="memberPhoneNo" value="${member.memberPhoneNo}">
				<small class="invalid-msg final_hp_ck">핸드폰 번호 형식이 올바르지 않습니다.</small>
			</div>
			<div class="mb-4">
				<label class="form-label d-block">성별</label>
				<div class="btn-group" role="group">
					<input type="radio" class="btn-check" name="memberGender" id="male" value="1" checked>
					<label class="btn btn-outline-secondary" for="male">남성</label>
					<input type="radio" class="btn-check" name="memberGender" id="female" value="2">
					<label class="btn btn-outline-secondary" for="female">여성</label>
				</div>
			</div>
			<button type="button" class="btn btn-primary-hotel w-100 py-2 update_button">수정하기</button>
			<div class="text-center mt-3">
				<a href="/member/myPage" class="text-muted">돌아가기</a>
			</div>
		</form>
	</div>
</div>

<script>
var code = "";
var pwCheck = false, pwCkCheck = false, pwCkCorCheck = false;
var nameCheck = false, nickNameCheck = false, mailCheck = false, mailNumCheck = false;

$(document).ready(function() {
	$(".update_button").click(function() {
		var pw = $('.pw_input').val();
		var pwck = $('.pwck_input').val();
		var name = $('.user_input').val();
		var nickname = $('.usernn_input').val();
		var mail = $('.mail_input').val();
		var phone = $('.hp_input').val();

		pwCheck = pw !== "";     $('.final_pw_ck').css('display', pw ? 'none' : 'block');
		pwCkCheck = pwck !== ""; $('.final_pwck_ck').css('display', pwck ? 'none' : 'block');
		nameCheck = name !== ""; $('.final_name_ck').css('display', name ? 'none' : 'block');
		nickNameCheck = nickname !== ""; $('.final_nickname_ck').css('display', nickname ? 'none' : 'block');
		mailCheck = mail !== ""; $('.final_mail_ck').css('display', mail ? 'none' : 'block');
		$('.final_hp_ck').css('display', fn_mbtlnumChk(phone) ? 'none' : 'block');

		if (pwCheck && pwCkCheck && pwCkCorCheck && nameCheck && nickNameCheck && mailCheck && mailNumCheck) {
			$("#update_form").attr("action", "/member/myPage_member");
			$("#update_form").submit();
		}
		return false;
	});
});

$(".mail_check_button").click(function() {
	var email = $(".mail_input").val();
	var warnMsg = $(".mail_input_box_warn");
	if (mailFormCheck(email)) {
		warnMsg.html("인증 메일이 전송되었습니다.").css({ "display": "inline-block", "color": "var(--color-success)" });
	} else {
		warnMsg.html("올바르지 않은 이메일 형식입니다.").css({ "display": "inline-block", "color": "var(--color-danger)" });
		return false;
	}
	$.ajax({ type: "GET", url: "mailCheck?email=" + email, success: function(data) {
		$(".mail_check_input").attr("disabled", false);
		code = data;
	}});
});

$(".mail_check_input").blur(function() {
	var inputCode = $(this).val();
	var checkResult = $("#mail_check_input_box_warn");
	if (inputCode == code) {
		checkResult.html("인증번호가 일치합니다.").attr("class", "text-success small");
		mailNumCheck = true;
	} else {
		checkResult.html("인증번호를 다시 확인해주세요.").attr("class", "text-danger small");
		mailNumCheck = false;
	}
});

$('.pwck_input').on("propertychange change keyup paste input", function() {
	var pw = $('.pw_input').val();
	var pwck = $(this).val();
	$('.final_pwck_ck').css('display', 'none');
	if (pw == pwck) {
		$('.pwck_input_re_1').css('display', 'block');
		$('.pwck_input_re_2').css('display', 'none');
		pwCkCorCheck = true;
	} else {
		$('.pwck_input_re_1').css('display', 'none');
		$('.pwck_input_re_2').css('display', 'block');
		pwCkCorCheck = false;
	}
});

function mailFormCheck(email) {
	return /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i.test(email);
}
function fn_mbtlnumChk(m) {
	return /^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-(\d{4})$/.test(m);
}
</script>
<script src="/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
