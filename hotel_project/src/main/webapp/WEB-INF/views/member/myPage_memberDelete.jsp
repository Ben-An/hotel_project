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
		<form id="update_form" method="post">
			<div class="form-body">
				<div class="row">
					<div class="form-holder">
						<div class="form-content">
							<div class="form-items">
								<h3>회원 탈퇴</h3>
								
								<form class="requires-validation" novalidate>

									<div class="col-md-12 id_wrap">
										<input class="form-control id_input" type="text"
											name="memberId" value="${member.memberId }" readonly>
									</div>

									<div class="col-md-12 pw_wrap">
										<input class="form-control pw_input" type="password"
											name="memberPassword" placeholder="비밀번호">
									</div>

									<div class="form-button mt-3 join_button_wrap">
										<input type="submit" class="btn btn-dark join_button w-100" value="탈퇴하기" id="delete_Button">
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>

	</main>
</body>
</html>