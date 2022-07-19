<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">


	
<div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 280px; margin-left: 300px;">
    <a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none">
      <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
      <span class="fs-4">조건 검색</span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
      <li> 
      	<p>지도로 보기</p>
      	<a href="#">
	        <button type="button" class="btn btn-primary" style="display: block;">
				지도로 검색
			</button>
		</a>
	  </li>
	  <hr>
      <li>
      	<p>
		  <label for="price">가격</label>
		  <input type="text" id="price" name="price" readonly style="border:0; color:#f6931f; font-weight:bold;">
		</p>
 
		<div id="slider-range"></div>
      </li>
      <hr>
      <li>
      	<p>평점</p>
        <span class="star">
  		★★★★★
  			<span>★★★★★</span>
  			<input type="range" oninput="drawStar(this)" value="1" step="1" min="0" max="10">
		</span>
      </li>
      <hr>
      <li>
        <p>편의 시설</p>
        <div class="form-check">
			<input class="form-check-input" type="checkbox" id="f1" name = "option" value="buffet">
			<label class="form-check-label" for="f1">조식</label>
		</div>
		<div class="form-check">
			<input class="form-check-input" type="checkbox" id="f2" name = "option" value="swim">
			<label class="form-check-label" for="f2">수영장</label>
		</div>
        <div class="form-check">
			<input class="form-check-input" type="checkbox" id="f3" name = "option" value="golf">
			<label class="form-check-label" for="f3">골프장</label>
		</div>
		<div class="form-check">
			<input class="form-check-input" type="checkbox" id="f4" name = "option" value="pet">
			<label class="form-check-label" for="f4">반려동물 동반</label>
		</div>
        <div class="form-check">
			<input class="form-check-input" type="checkbox" id="f5" name = "option" value="restaurant">
			<label class="form-check-label" for="f5">레스토랑</label>
		</div>
		<div class="form-check">
			<input class="form-check-input" type="checkbox" id="f6" name = "option" value="fitness">
			<label class="form-check-label" for="f6">피트니스</label>
		</div>
        <div class="form-check">
			<input class="form-check-input" type="checkbox" id="f7" name = "option" value="parking">
			<label class="form-check-label" for="f7">주차</label>
		</div>
		<div class="form-check">
			<input class="form-check-input" type="checkbox" id="f8" name = "option" value="wifi">
			<label class="form-check-label" for="f8">와이파이</label>
		</div>
        <div class="form-check">
			<input class="form-check-input" type="checkbox" id="f9" name = "option" value="kitchen">
			<label class="form-check-label" for="f9">주방</label>
		</div>
      </li>
      <hr>
      <li>
        <p>객실 흡연</p>
        <div class="form-check">
	  		<input class="form-check-input" type="checkbox" id="f10" name="option" value="smoke">
			<label class="form-check-label" for="f10">흡연</label>
		</div>
      </li>
      <hr>
      <li>
        <p>동네</p>
        <ul class="list-unstyled ps-0">
	        <li class="mb-1">
		        <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#dashboard-collapse" aria-expanded="false">
		          	북부
		        </button>
		        <div class="collapse" id="dashboard-collapse">
		          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a1" name="area" value="Goyang">
							<label class="form-check-label" for="a1">고양</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a2" name="area" value="Guri">
							<label class="form-check-label" for="a2">구리</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a3" name="area" value="Namyangju">
							<label class="form-check-label" for="a3">남양주</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a4" name="area" value="Dongducheon">
							<label class="form-check-label" for="a4">동두천</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a5" name="area" value="Yangju">
							<label class="form-check-label" for="a5">양주</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a6" name="area" value="Uijeongbu">
							<label class="form-check-label" for="a6">의정부</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a7" name="area" value="Paju">
							<label class="form-check-label" for="a7">파주</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a8" name="area" value="Pocheon">
							<label class="form-check-label" for="a8">포천</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a9" name="area" value="Gapyeong">
							<label class="form-check-label" for="a9">가평</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a10" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a10">연천</label>
						</div>
					</li>
		          </ul>
		        </div>
      		</li>
      	</ul>
        <ul class="list-unstyled ps-0">
	        <li class="mb-1">
		        <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#others-collapse" aria-expanded="false">
		          	남부
		        </button>
		        <div class="collapse" id="others-collapse">
		          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a11" name="area" value="Gwacheon">
							<label class="form-check-label" for="a11">과천</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a12" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a12">광명</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a13" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a13">광주</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a14" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a14">군포</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a15" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a15">김포</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a16" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a16">부천</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a17" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a17">성남</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a18" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a18">수원</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a19" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a19">시흥</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a20" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a20">안산</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a21" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a21">안성</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a22" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a22">안양</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a23" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a23">여주</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a24" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a24">오산</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a25" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a25">용인</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a26" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a26">의왕</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a27" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a27">이천</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a28" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a28">평택</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a29" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a29">하남</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a30" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a30">화성</label>
						</div>
					</li>
		            <li>
		            	<div class="form-check">
							<input class="form-check-input" type="checkbox" id="a31" name="area" value="Yeoncheon">
							<label class="form-check-label" for="a31">양평</label>
						</div>
					</li>
		          </ul>
		        </div>
      		</li>
      	</ul>
      </li>
    </ul>
    <hr>   
  </div>

<script>
	const drawStar = function(target){
		  $('.star span').css({ width: target.value * 10+"%" });
	}
	
	
</script>
</body>


</html>
