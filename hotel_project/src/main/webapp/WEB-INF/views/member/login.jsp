<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>심사숙소 로그인</title>

<!-- Bootstrap core CSS -->
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/css/bootstrap.css" rel="stylesheet">

<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/adac482b14.js"
	crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@700&display=swap"
	rel="stylesheet">
<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<style>
/* html,
body {
  height: 100%;
}

body {
  display: flex;
  align-items: center;
  padding-top: 40px;
  padding-bottom: 40px;
  background-color: #f5f5f5;
}

.form-signin {
  max-width: 330px;
  padding: 15px;
}

.form-signin .form-floating:focus-within {
  z-index: 2;
}

.form-signin input[type="email"] {
  margin-bottom: -1px;
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
}

.form-signin input[type="password"] {
  margin-bottom: 10px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}

      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      .b-example-divider {
        height: 3rem;
        background-color: rgba(0, 0, 0, .1);
        border: solid rgba(0, 0, 0, .15);
        border-width: 1px 0;
        box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
      }

      .b-example-vr {
        flex-shrink: 0;
        width: 1.5rem;
        height: 100vh;
      }

      .bi {
        vertical-align: -.125em;
        fill: currentColor;
      }

      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      } */
@import url('https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@700&display=swap');
/* 로그인 실패시 경고글 */
.login_warn{
    margin: 10px;
    text-align: center;
    color : red;
} 
html,
body {
font-family: 'Gowun Batang', serif;
  height: 100%;
}

body {
  display: flex;
  align-items: center;
  padding-top: 40px;
  padding-bottom: 40px;
}

.card {
	border: none;
	height: 320px
	 max-width: 330px;
  padding: 15px;
}

.forms-inputs {
	position: relative
}

.forms-inputs span {
	position: absolute;
	top: -18px;
	left: 10px;
	background-color: #fff;
	padding: 5px 10px;
	font-size: 15px
}

.forms-inputs input {
	height: 50px;
	border: 2px solid #eee
}

.forms-inputs input:focus {
	box-shadow: none;
	outline: none;
	border: 2px solid #000
}

.btn {
	height: 50px
}

.success-data {
	display: flex;
	flex-direction: column
}

.bxs-badge-check {
	font-size: 90px
}
</style>

</head>
<body style="background-color: #FF8C00;">

	<%--   <form id="login_form" method="post">
    <span class="fs-4"><strong>심사숙소</strong></span>
    <h1 class="h3 mb-3 fw-normal">Please sign in</h1>

    <div class="form-floating">
      <input class="form-control" id="memberId" name="memberId" placeholder="name">
      <label for="memberId">ID</label>
    </div>
    <div class="form-floating">
      <input type="password" class="form-control" id="memberPassword" name="memberPassword" placeholder="Password">
      <label for="memberPassword">Password</label>
    </div>

    <div class="checkbox mb-3">
      <label>
        <input type="checkbox" value="remember-me"> Remember me
      </label>
    </div>
      <c:if test = "${result == 0 }">
                <div class = "login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
            </c:if>
    <button class="w-100 btn btn-lg btn-primary login_button" type="submit">Sign in</button>
    <p class="mt-5 mb-3 text-muted">&copy; 심사숙소 2022</p>

  </form> --%>
	<div class="container mt-5">
		<div class="row d-flex justify-content-center">
		<form id="login_form" method="post">
			<div class="col-md-6" style="float: none; margin:0 auto;">
				<div class="card px-5 py-5" id="form1">
					<div class="form-data">
						<div class="forms-inputs mb-4">
							<span>ID</span> 
							<input type="text" class="form-control" id="memberId" name="memberId">
						</div>
						<div class="forms-inputs mb-4">
							<span>Password</span> 
							<input type="password" class="form-control" id="memberPassword" name="memberPassword">
						</div>
						<c:if test = "${result == 0 }">
               				 <div class = "login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
            			</c:if>
						<div class="mb-3">
							<button class="btn btn-dark w-100" type="submit">Login</button>
						</div>
					</div>
				</div>
			</div>
			</form>
		</div>
	</div>

	<script>
		/* 로그인 버튼 클릭 메서드 */
		$(".login_button").click(function() {
			/* 로그인 메서드 서버 요청 */
			$("#login_form").attr("action", "/member/login");
			$("#login_form").submit();
		});
	}
	
	</script>

</body>
</html>