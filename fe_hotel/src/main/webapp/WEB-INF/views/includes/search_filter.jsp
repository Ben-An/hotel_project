<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<div class="filter-sidebar">
	<h5><i class="bi bi-sliders"></i> 조건 검색</h5>

	<!-- Map Link -->
	<div class="filter-section">
		<h6>지도로 보기</h6>
		<c:forEach var="item" items="${list}" end="0">
			<a href="${contextPath}/map/mapside?state=${item.state}" class="btn btn-primary-hotel btn-sm w-100">
				<i class="bi bi-map"></i> 지도로 검색
			</a>
		</c:forEach>
	</div>

	<!-- Price Range -->
	<div class="filter-section">
		<h6>가격</h6>
		<input type="text" id="price" name="price" readonly
			class="form-control form-control-sm mb-2"
			style="border:0; color:var(--color-primary); font-weight:600; background:transparent;">
		<div id="slider-range"></div>
	</div>

	<!-- Rating -->
	<div class="filter-section">
		<h6>평점</h6>
		<div class="star-rating">
			&#9733;&#9733;&#9733;&#9733;&#9733;
			<span>&#9733;&#9733;&#9733;&#9733;&#9733;</span>
			<input type="range" id="grade" name="grade" oninput="drawStar(this)" value="0" step="0.5" min="0" max="5">
		</div>
	</div>

	<!-- Facilities -->
	<div class="filter-section">
		<h6>편의 시설</h6>
		<div class="d-flex flex-column gap-2">
			<div class="form-check"><input class="form-check-input" type="checkbox" id="f1" name="option" value="buffet"><label class="form-check-label" for="f1">조식</label></div>
			<div class="form-check"><input class="form-check-input" type="checkbox" id="f2" name="option" value="swim"><label class="form-check-label" for="f2">수영장</label></div>
			<div class="form-check"><input class="form-check-input" type="checkbox" id="f3" name="option" value="golf"><label class="form-check-label" for="f3">골프장</label></div>
			<div class="form-check"><input class="form-check-input" type="checkbox" id="f4" name="option" value="pet"><label class="form-check-label" for="f4">반려동물 동반</label></div>
			<div class="form-check"><input class="form-check-input" type="checkbox" id="f5" name="option" value="restaurant"><label class="form-check-label" for="f5">레스토랑</label></div>
			<div class="form-check"><input class="form-check-input" type="checkbox" id="f6" name="option" value="fitness"><label class="form-check-label" for="f6">피트니스</label></div>
			<div class="form-check"><input class="form-check-input" type="checkbox" id="f7" name="option" value="parking"><label class="form-check-label" for="f7">주차</label></div>
			<div class="form-check"><input class="form-check-input" type="checkbox" id="f8" name="option" value="wifi"><label class="form-check-label" for="f8">와이파이</label></div>
			<div class="form-check"><input class="form-check-input" type="checkbox" id="f9" name="option" value="kitchen"><label class="form-check-label" for="f9">주방</label></div>
		</div>
	</div>

	<!-- Smoking -->
	<div class="filter-section">
		<h6>객실 흡연</h6>
		<div class="form-check"><input class="form-check-input" type="checkbox" id="f10" name="option" value="smoke"><label class="form-check-label" for="f10">흡연 가능</label></div>
	</div>

	<!-- Area -->
	<div class="filter-section">
		<h6>지역</h6>

		<button class="btn btn-sm btn-outline-secondary w-100 mb-2" type="button" data-bs-toggle="collapse" data-bs-target="#area-north">
			<i class="bi bi-chevron-down"></i> 북부
		</button>
		<div class="collapse" id="area-north">
			<div class="d-flex flex-column gap-1 mb-3 ps-2">
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a1" name="area" value="Goyang"><label class="form-check-label" for="a1">고양</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a2" name="area" value="Guri"><label class="form-check-label" for="a2">구리</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a3" name="area" value="Namyangju"><label class="form-check-label" for="a3">남양주</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a4" name="area" value="Dongducheon"><label class="form-check-label" for="a4">동두천</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a5" name="area" value="Yangju"><label class="form-check-label" for="a5">양주</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a6" name="area" value="Uijeongbu"><label class="form-check-label" for="a6">의정부</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a7" name="area" value="Paju"><label class="form-check-label" for="a7">파주</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a8" name="area" value="Pocheon"><label class="form-check-label" for="a8">포천</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a9" name="area" value="Gapyeong"><label class="form-check-label" for="a9">가평</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a10" name="area" value="Yeoncheon"><label class="form-check-label" for="a10">연천</label></div>
			</div>
		</div>

		<button class="btn btn-sm btn-outline-secondary w-100 mb-2" type="button" data-bs-toggle="collapse" data-bs-target="#area-south">
			<i class="bi bi-chevron-down"></i> 남부
		</button>
		<div class="collapse" id="area-south">
			<div class="d-flex flex-column gap-1 ps-2">
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a11" name="area" value="Gwacheon"><label class="form-check-label" for="a11">과천</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a12" name="area" value="Gwangmyeong"><label class="form-check-label" for="a12">광명</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a13" name="area" value="Gwangju"><label class="form-check-label" for="a13">광주</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a14" name="area" value="Gunpo"><label class="form-check-label" for="a14">군포</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a15" name="area" value="Gimpo"><label class="form-check-label" for="a15">김포</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a16" name="area" value="Bucheon"><label class="form-check-label" for="a16">부천</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a17" name="area" value="Seongnam"><label class="form-check-label" for="a17">성남</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a18" name="area" value="Suwon"><label class="form-check-label" for="a18">수원</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a19" name="area" value="Siheung"><label class="form-check-label" for="a19">시흥</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a20" name="area" value="Ansan"><label class="form-check-label" for="a20">안산</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a21" name="area" value="Anseong"><label class="form-check-label" for="a21">안성</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a22" name="area" value="Anyang"><label class="form-check-label" for="a22">안양</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a23" name="area" value="Yeoju"><label class="form-check-label" for="a23">여주</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a24" name="area" value="Osan"><label class="form-check-label" for="a24">오산</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a25" name="area" value="Yongin"><label class="form-check-label" for="a25">용인</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a26" name="area" value="Uiwang"><label class="form-check-label" for="a26">의왕</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a27" name="area" value="Icheon"><label class="form-check-label" for="a27">이천</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a28" name="area" value="Pyeongtaek"><label class="form-check-label" for="a28">평택</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a29" name="area" value="Hanam"><label class="form-check-label" for="a29">하남</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a30" name="area" value="Hwaseong"><label class="form-check-label" for="a30">화성</label></div>
				<div class="form-check"><input class="form-check-input" type="checkbox" id="a31" name="area" value="Yangpyeong"><label class="form-check-label" for="a31">양평</label></div>
			</div>
		</div>
	</div>
</div>
