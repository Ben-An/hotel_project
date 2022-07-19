<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>심사숙소 회원가입</title>

<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/adac482b14.js"
	crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@700&display=swap"
	rel="stylesheet">

<style>
/* 중복아이디 존재하지 않는경우 */
.id_input_re_1 {
	color: green;
	display: none;
}
/* 중복아이디 존재하는 경우 */
.id_input_re_2 {
	color: red;
	display: none;
}

/* #mail_check_input_box_false{
    background-color:#ebebe4;
}
 
#mail_check_input_box_true{
    background-color:white;
} */
.correct {
	color: green;
}

.incorrect {
	color: red;
}

.mail_check_button {
	background-color: black;
}

/* 유효성 검사 문구 */
.final_id_ck {
	display: none;
	color : red;
}

.final_pw_ck {
	display: none;
	color : red;
}

.final_pwck_ck {
	display: none;
	color : red;
}

.final_name_ck {
	display: none;
	color : red;
}

.final_nickname_ck {
	display: none;
	color : red;
}

.final_mail_ck {
	display: none;
	color : red;
}

.final_hp_ck {
	display: none;
	color : red;
}

/* 비밀번호 확인 일치 유효성검사 */
.pwck_input_re_1 {
	color: green;
	display: none;
}

.pwck_input_re_2 {
	color: red;
	display: none;
}

@import
	url('https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@700&display=swap')
	;

*, body {
	font-family: 'Gowun Batang', serif;
	font-weight: 400;
	-webkit-font-smoothing: antialiased;
	text-rendering: optimizeLegibility;
	-moz-osx-font-smoothing: grayscale;
}

html, body {
	height: 100%;
	background-color: #152733;
	overflow: hidden;
}

.form-holder {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
	min-height: 100vh;
}

.form-holder .form-content {
	position: relative;
	text-align: center;
	display: -webkit-box;
	display: -moz-box;
	display: -ms-flexbox;
	display: -webkit-flex;
	display: flex;
	-webkit-justify-content: center;
	justify-content: center;
	-webkit-align-items: center;
	align-items: center;
	padding: 60px;
}

.form-content .form-items {
	border: 3px solid #fff;
	padding: 40px;
	display: inline-block;
	width: 100%;
	min-width: 540px;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
	text-align: left;
	-webkit-transition: all 0.4s ease;
	transition: all 0.4s ease;
}

.form-content h3 {
	color: #fff;
	text-align: left;
	font-size: 28px;
	font-weight: 600;
	margin-bottom: 5px;
}

.form-content h3.form-title {
	margin-bottom: 30px;
}

.form-content p {
	color: #fff;
	text-align: left;
	font-size: 17px;
	font-weight: 300;
	line-height: 20px;
	margin-bottom: 30px;
}

.form-content label, .was-validated .form-check-input:invalid ~.form-check-label,
	.was-validated .form-check-input:valid ~.form-check-label {
	color: #fff;
}

.form-content input[type=text], .form-content input[type=password],
	.form-content input[type=email], .form-content select {
	width: 100%;
	padding: 9px 20px;
	text-align: left;
	border: 0;
	outline: 0;
	border-radius: 6px;
	background-color: #fff;
	font-size: 15px;
	font-weight: 300;
	color: #8D8D8D;
	-webkit-transition: all 0.3s ease;
	transition: all 0.3s ease;
	margin-top: 16px;
}

.btn-primary {
	background-color: #6C757D;
	outline: none;
	border: 0px;
	box-shadow: none;
}

.btn-primary:hover, .btn-primary:focus, .btn-primary:active {
	background-color: #495056;
	outline: none !important;
	border: none !important;
	box-shadow: none;
}

.form-content textarea {
	position: static !important;
	width: 100%;
	padding: 8px 20px;
	border-radius: 6px;
	text-align: left;
	background-color: #fff;
	border: 0;
	font-size: 15px;
	font-weight: 300;
	color: #8D8D8D;
	outline: none;
	resize: none;
	height: 120px;
	-webkit-transition: none;
	transition: none;
	margin-bottom: 14px;
}

.form-content textarea:hover, .form-content textarea:focus {
	border: 0;
	background-color: #ebeff8;
	color: #8D8D8D;
}

.mv-up {
	margin-top: -9px !important;
	margin-bottom: 8px !important;
}

.invalid-feedback {
	color: #ff606e;
}

.valid-feedback {
	color: #2acc80;
}
</style>
<!-- Bootstrap core CSS -->
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/css/bootstrap.css" rel="stylesheet">
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/adac482b14.js"
	crossorigin="anonymous"></script>
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>

</head>
<body class="text-center"
	style="font-family: 'Gowun Batang', serif; background-color: #FF8C00;">


	<main class="form-signin w-100 m-auto text-white">
		<form id="join_form" method="post">
			<div class="form-body">
				<div class="row">
					<div class="form-holder">
						<div class="form-content">
							<div class="form-items">
								<h3>심사숙소 회원가입</h3>
								
								<form class="requires-validation" novalidate>

									<div class="col-md-12 id_wrap">
										<input class="form-control id_input" type="text"
											name="memberId" placeholder="아이디"> <span
											class="id_input_re_1">사용 가능한 아이디입니다.</span> 
											<span class="id_input_re_2">아이디가 이미 존재합니다.</span> 
											<span class="final_id_ck">아이디를 입력해주세요.</span>
									</div>

									<div class="col-md-12 pw_wrap">
										<input class="form-control pw_input" type="password"
											name="memberPassword" placeholder="비밀번호">
										<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
									</div>

									<div class="col-md-12 pwck_wrap">
										<input class="form-control pwck_input" type="password"
											placeholder="비밀번호 확인"> <span class="final_pwck_ck">비밀번호
											확인을 입력해주세요.</span> <span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
										<span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
									</div>

									<div class="col-md-12 user_wrap">
										<input class="form-control user_input" type="text"
											name="memberName" placeholder="이름"> <span
											class="final_name_ck">이름을 입력해주세요.</span>
									</div>

									<div class="col-md-12 usernn_wrap">
										<input class="form-control usernn_input" type="text"
											name="memberNickname" placeholder="닉네임"> <span
											class="final_nickname_ck">닉네임을 입력해주세요.</span>
									</div>

									<div class="col-md-12 mail_wrap">
										<input class="form-control mail_input" type="email"
											name="memberEmail" placeholder="이메일"> 
											<span class="final_mail_ck">이메일을 입력해주세요.</span> 
											<span class="mail_input_box_warn"></span>
											
										<div class="col-md-12 mail_check_wrap">
											<div class="mail_check_input_box" id="mail_check_input_box_false">
												<input class="form-control mail_check_input" placeholder="인증번호" disabled="disabled">
										</div>
										<div class="mail_check_button">
											<span class="btn btn-dark w-100">인증번호 전송</span>
										</div>
											<div class="clearfix"></div>
											<span id="mail_check_input_box_warn"></span>
									</div>
								</div>
									<div class="col-md-12 hp_wrap">
										<input class="form-control hp_input" type="text"
											name="memberPhoneNo" placeholder="핸드폰 번호">
										<span class="final_hp_ck">핸드폰 번호 형식이 올바르지 않습니다.</span> 
									</div>

									<div class="col-md-12 mt-3 gender_wrap">
										<label class="mb-3 mr-1" for="gender">성별: </label> 
										<input type="radio" class="btn-check" name="memberGender" id="male" value="1"
											 checked="checked"> 
											<label class="btn btn-sm btn-outline-secondary" for="male">남성</label>

										<input type="radio" class="btn-check" name="memberGender"
											id="female" value="2"> 
											<label class="btn btn-sm btn-outline-secondary" for="female">여성</label>
									</div>
									<div class="form-button mt-3 join_button_wrap">
										<input type="button" class="btn btn-dark join_button w-100" value="가입하기" id="joinButton">
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>

	</main>
	<script>
		var code = ""; //이메일전송 인증번호 저장위한 코드

		/* 유효성 검사 통과유무 변수 */
		var idCheck = false; // 아이디
		var idCkCheck = false; // 아이디 중복 검사
		var pwCheck = false; // 비번
		var pwCkCheck = false; // 비번 확인
		var pwCkCorCheck = false; // 비번 확인 일치 확인
		var nameCheck = false; // 이름
		var nickNameCheck = false; // 닉네임
		var mailCheck = false; // 이메일
		var mailNumCheck = false; // 이메일 인증번호 확인

		$(document)
				.ready(
						function() {
							//회원가입 버튼(회원가입 기능 작동)
							$(".join_button")
									.click(
											function() {
												/* 입력값 변수 */
												var id = $('.id_input').val(); // id 입력란
												var pw = $('.pw_input').val(); // 비밀번호 입력란
												var pwck = $('.pwck_input')
														.val(); // 비밀번호 확인 입력란
												var name = $('.user_input')
														.val(); // 이름 입력란
												var nickname = $(
														'.usernn_input').val(); // 닉네임 입력란
												var mail = $('.mail_input')
														.val(); // 이메일 입력란
												var phone = $('.hp_input')
														.val(); // 핸드폰 입력란

												/* 아이디 유효성검사 */
												if (id == "") {
													$('.final_id_ck').css(
															'display', 'block');
													idCheck = false;
												} else {
													$('.final_id_ck').css(
															'display', 'none');
													idCheck = true;
												}
												/* 비밀번호 유효성 검사 */
												if (pw == "") {
													$('.final_pw_ck').css(
															'display', 'block');
													pwCheck = false;
												} else {
													$('.final_pw_ck').css(
															'display', 'none');
													pwCheck = true;
												}
												/* 비밀번호 확인 유효성 검사 */
												if (pwck == "") {
													$('.final_pwck_ck').css(
															'display', 'block');
													pwCkCheck = false;
												} else {
													$('.final_pwck_ck').css(
															'display', 'none');
													pwCkCheck = true;
												}
												/* 이름 유효성 검사 */
												if (name == "") {
													$('.final_name_ck').css(
															'display', 'block');
													nameCheck = false;
												} else {
													$('.final_name_ck').css(
															'display', 'none');
													nameCheck = true;
												}
												/* 닉네임 유효성 검사 */
												if (nickname == "") {
													$('.final_nickname_ck')
															.css('display',
																	'block');
													nickNameCheck = false;
												} else {
													$('.final_nickname_ck')
															.css('display',
																	'none');
													nickNameCheck = true;
												}
												/* 이메일 유효성 검사 */
												if (mail == "") {
													$('.final_mail_ck').css(
															'display', 'block');
													mailCheck = false;
												} else {
													$('.final_mail_ck').css(
															'display', 'none');
													mailCheck = true;
												}
												/* 핸드폰 유효성 검사 */
												if (fn_mbtlnumChk(phone)) {

													$('.final_hp_ck').css(
															'display', 'none');
													//mailCheck = false;
												} else {
													$('.final_hp_ck').css(
															'display', 'block');
													//mailCheck = true;
												}
												/* 최종 유효성 검사 */
												if (idCheck && idCkCheck
														&& pwCheck && pwCkCheck
														&& pwCkCorCheck
														&& nameCheck
														&& nickNameCheck
														&& mailCheck
														&& mailNumCheck) {
													$("#join_form").attr("action",
															"/member/join");
													$("#join_form").submit();
												}

												return false;
											});
						});

		//아이디 중복검사
		$('.id_input').on(
				"propertychange change keyup paste input",
				function() {

					var memberId = $('.id_input').val(); // .id_input에 입력되는 값
					var data = {
						memberId : memberId
					} // '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'

					$.ajax({
						type : "post",
						url : "/member/memberIdChk",
						data : data,
						success : function(result) {
							//console.log("성공 여부" + result);
							if (result != 'fail') {
								$('.id_input_re_1').css("display",
										"inline-block");
								$('.id_input_re_2').css("display", "none");
								idCkCheck = true;
							} else {
								$('.id_input_re_2').css("display",
										"inline-block");
								$('.id_input_re_1').css("display", "none");
								idCkCheck = false;
							}

						}// success 종료
					}); // ajax 종료

				});// function 종료

		/* 인증번호 이메일 전송 */
		$(".mail_check_button").click(function() {
			var email = $(".mail_input").val(); // 입력한 이메일
			var cehckBox = $(".mail_check_input"); // 인증번호 입력란
			var boxWrap = $(".mail_check_input_box"); // 인증번호 입력란 박스
			var warnMsg = $(".mail_input_box_warn"); // 이메일 입력 경고글

			/* 이메일 형식 유효성 검사 */
			if (mailFormCheck(email)) {
				warnMsg.html("이메일이 전송 되었습니다. 이메일을 확인해주세요.");
				warnMsg.css("display", "inline-block");
			} else {
				warnMsg.html("올바르지 못한 이메일 형식입니다.");
				warnMsg.css("display", "inline-block");
				return false;
			}

			$.ajax({
				type : "GET",
				url : "mailCheck?email=" + email,
				success : function(data) {

					console.log("data : " + data);
					cehckBox.attr("disabled", false);
					boxWrap.attr("id", "mail_check_input_box_true");
					code = data;
				}
			});
		});

		/* 인증번호 비교 */
		$(".mail_check_input").blur(function() {
			var inputCode = $(".mail_check_input").val(); // 입력코드    
			var checkResult = $("#mail_check_input_box_warn"); // 비교 결과     

			if (inputCode == code) { // 일치할 경우
				checkResult.html("인증번호가 일치합니다.");
				checkResult.attr("class", "correct");
				mailNumCheck = true;
			} else { // 일치하지 않을 경우
				checkResult.html("인증번호를 다시 확인해주세요.");
				checkResult.attr("class", "incorrect");
				mailNumCheck = false;
			}
		});

		/* 비밀번호 확인 일치 유효성 검사 */

		$('.pwck_input').on("propertychange change keyup paste input",
				function() {
					var pw = $('.pw_input').val();
					var pwck = $('.pwck_input').val();
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

		/* 입력 이메일 형식 유효성 검사 */
		function mailFormCheck(email) {
			var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
			return form.test(email);
		}

		/* 핸폰 형식 유효성 검사*/
		function fn_mbtlnumChk(mbtlnum) {
			var form = /^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-(\d{4})$/;
			return form.test(mbtlnum);
		}
	</script>
</body>
</html>