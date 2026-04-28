<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>심사숙소 - 회원가입</title>

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&display=swap" rel="stylesheet">

<!-- Bootstrap -->
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Custom CSS -->
<link href="/resources/css/style.css" rel="stylesheet">
</head>
<body>
<div class="auth-page" style="padding:2rem;">
	<div class="auth-card" style="max-width:500px;">
		<div class="auth-logo">
			<a href="/hotel/index">심사숙소</a>
		</div>
		<h2>회원가입</h2>

		<form id="join_form" method="post">
			<!-- ID -->
			<div class="mb-3">
				<label class="form-label">아이디</label>
				<div class="input-group">
					<input class="form-control id_input" type="text" name="memberId" placeholder="아이디를 입력하세요">
					<button class="btn btn-outline-secondary id_check_button" type="button">중복확인</button>
				</div>
				<small class="valid-msg id_input_re_1">사용 가능한 아이디입니다.</small>
				<small class="invalid-msg id_input_re_2">이미 존재하는 아이디입니다.</small>
				<small class="invalid-msg final_id_ck">아이디를 입력해주세요.</small>
			</div>

			<!-- Password -->
			<div class="mb-3">
				<label class="form-label">비밀번호</label>
				<input class="form-control pw_input" type="password" name="memberPassword" placeholder="비밀번호를 입력하세요">
				<small class="invalid-msg final_pw_ck">비밀번호를 입력해주세요.</small>
			</div>

			<!-- Password Confirm -->
			<div class="mb-3">
				<label class="form-label">비밀번호 확인</label>
				<input class="form-control pwck_input" type="password" placeholder="비밀번호를 다시 입력하세요">
				<small class="invalid-msg final_pwck_ck">비밀번호 확인을 입력해주세요.</small>
				<small class="valid-msg pwck_input_re_1">비밀번호가 일치합니다.</small>
				<small class="invalid-msg pwck_input_re_2">비밀번호가 일치하지 않습니다.</small>
			</div>

			<!-- Name -->
			<div class="mb-3">
				<label class="form-label">이름</label>
				<input class="form-control user_input" type="text" name="memberName" placeholder="이름을 입력하세요">
				<small class="invalid-msg final_name_ck">이름을 입력해주세요.</small>
			</div>

			<!-- Nickname -->
			<div class="mb-3">
				<label class="form-label">닉네임</label>
				<div class="input-group">
					<input class="form-control usernn_input" type="text" name="memberNickname" placeholder="닉네임을 입력하세요">
					<button class="btn btn-outline-secondary nn_check_button" type="button">중복확인</button>
				</div>
				<small class="valid-msg nn_input_re_1">사용 가능한 닉네임입니다.</small>
				<small class="invalid-msg nn_input_re_2">이미 존재하는 닉네임입니다.</small>
				<small class="invalid-msg final_nickname_ck">닉네임을 입력해주세요.</small>
			</div>

			<!-- Email -->
			<div class="mb-3">
				<label class="form-label">이메일</label>
				<input class="form-control mail_input" type="email" name="memberEmail" placeholder="이메일을 입력하세요">
				<small class="invalid-msg final_mail_ck">이메일을 입력해주세요.</small>
				<small class="mail_input_box_warn" style="display:none;"></small>

				<div class="input-group mt-2">
					<input class="form-control mail_check_input" placeholder="인증번호 입력" disabled>
					<button class="btn btn-outline-secondary mail_check_button" type="button">인증번호 전송</button>
				</div>
				<small id="mail_check_input_box_warn"></small>
			</div>

			<!-- Phone -->
			<div class="mb-3">
				<label class="form-label">휴대폰 번호</label>
				<input class="form-control hp_input" type="text" name="memberPhoneNo" placeholder="010-0000-0000">
				<small class="invalid-msg final_hp_ck">핸드폰 번호 형식이 올바르지 않습니다.</small>
			</div>

			<!-- Gender -->
			<div class="mb-4">
				<label class="form-label d-block">성별</label>
				<div class="btn-group" role="group">
					<input type="radio" class="btn-check" name="memberGender" id="male" value="M" checked>
					<label class="btn btn-outline-secondary" for="male">남성</label>
					<input type="radio" class="btn-check" name="memberGender" id="female" value="F">
					<label class="btn btn-outline-secondary" for="female">여성</label>
				</div>
			</div>

			<!-- Submit -->
			<button type="button" class="btn btn-primary-hotel w-100 py-2 join_button">가입하기</button>

			<div class="text-center mt-3">
				<small class="text-muted">이미 계정이 있으신가요? <a href="/member/login" class="text-primary-hotel fw-semibold">로그인</a></small>
			</div>
		</form>
	</div>
</div>

<script>
var code = "";
var idCheck = false, idCkCheck = false, pwCheck = false, pwCkCheck = false;
var pwCkCorCheck = false, nameCheck = false, nickNameCheck = false, nnCkCheck = false;
var mailCheck = false, mailNumCheck = false;

$(document).ready(function() {
	$(".join_button").click(function() {
		var id = $('.id_input').val();
		var pw = $('.pw_input').val();
		var pwck = $('.pwck_input').val();
		var name = $('.user_input').val();
		var nickname = $('.usernn_input').val();
		var mail = $('.mail_input').val();
		var phone = $('.hp_input').val();

		idCheck = id !== "";     $('.final_id_ck').css('display', id ? 'none' : 'block');
		pwCheck = pw !== "";     $('.final_pw_ck').css('display', pw ? 'none' : 'block');
		pwCkCheck = pwck !== ""; $('.final_pwck_ck').css('display', pwck ? 'none' : 'block');
		nameCheck = name !== ""; $('.final_name_ck').css('display', name ? 'none' : 'block');
		nickNameCheck = nickname !== ""; $('.final_nickname_ck').css('display', nickname ? 'none' : 'block');
		mailCheck = mail !== ""; $('.final_mail_ck').css('display', mail ? 'none' : 'block');
		$('.final_hp_ck').css('display', fn_mbtlnumChk(phone) ? 'none' : 'block');

		if (idCheck && idCkCheck && pwCheck && pwCkCheck && pwCkCorCheck && nameCheck && nickNameCheck && nnCkCheck && mailCheck && mailNumCheck) {
			$.ajax({
				type: "POST",
				url: "/member/join",
				data: $("#join_form").serialize(),
				success: function() {
					alert("회원가입이 완료되었습니다.");
					location.href = "/member/login";
				},
				error: function() {
					alert("회원가입에 실패했습니다. 다시 시도해주세요.");
				}
			});
		}
		return false;
	});
});

// ID change resets check
$('.id_input').on("propertychange change keyup paste input", function() {
	idCkCheck = false;
	$('.id_input_re_1').css("display", "none");
	$('.id_input_re_2').css("display", "none");
});

// ID duplicate check button
$('.id_check_button').click(function() {
	var memberId = $('.id_input').val();
	if (!memberId) {
		$('.final_id_ck').css('display', 'block');
		return;
	}
	$('.final_id_ck').css('display', 'none');
	$.ajax({
		type: "post",
		url: "/member/memberIdChk",
		data: { memberId: memberId },
		success: function(result) {
			if (result != 'fail') {
				$('.id_input_re_1').css("display", "inline-block");
				$('.id_input_re_2').css("display", "none");
				idCkCheck = true;
			} else {
				$('.id_input_re_2').css("display", "inline-block");
				$('.id_input_re_1').css("display", "none");
				idCkCheck = false;
			}
		}
	});
});

// Nickname change resets check
$('.usernn_input').on("propertychange change keyup paste input", function() {
	nnCkCheck = false;
	$('.nn_input_re_1').css("display", "none");
	$('.nn_input_re_2').css("display", "none");
});

// Nickname duplicate check button
$('.nn_check_button').click(function() {
	var memberNickname = $('.usernn_input').val();
	if (!memberNickname) {
		$('.final_nickname_ck').css('display', 'block');
		return;
	}
	$('.final_nickname_ck').css('display', 'none');
	$.ajax({
		type: "post",
		url: "/member/memberNicknameChk",
		data: { memberNickname: memberNickname },
		success: function(result) {
			if (result != 'fail') {
				$('.nn_input_re_1').css("display", "inline-block");
				$('.nn_input_re_2').css("display", "none");
				nnCkCheck = true;
			} else {
				$('.nn_input_re_2').css("display", "inline-block");
				$('.nn_input_re_1').css("display", "none");
				nnCkCheck = false;
			}
		}
	});
});

// Email verification
$(".mail_check_button").click(function() {
	var email = $(".mail_input").val();
	var warnMsg = $(".mail_input_box_warn");

	if (mailFormCheck(email)) {
		warnMsg.html("인증 메일이 전송되었습니다.").css({ "display": "inline-block", "color": "var(--color-success)" });
	} else {
		warnMsg.html("올바르지 않은 이메일 형식입니다.").css({ "display": "inline-block", "color": "var(--color-danger)" });
		return false;
	}

	$.ajax({
		type: "GET",
		url: "mailCheck?email=" + email,
		success: function(data) {
			$(".mail_check_input").attr("disabled", false);
			code = data;
		}
	});
});

// Verify code
$(".mail_check_input").blur(function() {
	var inputCode = $(".mail_check_input").val();
	var checkResult = $("#mail_check_input_box_warn");

	if (inputCode == code) {
		checkResult.html("인증번호가 일치합니다.").attr("class", "text-success small");
		mailNumCheck = true;
	} else {
		checkResult.html("인증번호를 다시 확인해주세요.").attr("class", "text-danger small");
		mailNumCheck = false;
	}
});

// Password confirm
$('.pw_input, .pwck_input').on("propertychange change keyup paste input", function() {
	var pw = $('.pw_input').val();
	var pwck = $('.pwck_input').val();
	$('.final_pwck_ck').css('display', 'none');

	if (pwck === "") {
		$('.pwck_input_re_1').css('display', 'none');
		$('.pwck_input_re_2').css('display', 'none');
		pwCkCorCheck = false;
	} else if (pw === pwck) {
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

function fn_mbtlnumChk(mbtlnum) {
	return /^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-(\d{4})$/.test(mbtlnum);
}

// 전화번호 자동 하이픈
$('.hp_input').on('input', function() {
	var num = $(this).val().replace(/[^0-9]/g, '');
	if (num.length <= 3) {
		$(this).val(num);
	} else if (num.length <= 7) {
		$(this).val(num.substring(0, 3) + '-' + num.substring(3));
	} else {
		$(this).val(num.substring(0, 3) + '-' + num.substring(3, 7) + '-' + num.substring(7, 11));
	}
});
</script>

<script src="/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
