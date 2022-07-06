<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>




<%@include file="../includes/header.jsp"%>
















<div class="row" style="margin-top: 30px;">

	<div class="col-6">

		<div class="row" style="margin-left: 50px">
			<c:forEach var="item" items="${getmap }">

				<div class="col-6">

					<div class="card" style="width: 23rem; border: none">
						<img src="/resources/hotel/file_repo/1/hotel1.jpg"
							class="card-img-top" alt="...">
						<div class="card-body">
							<div class=row>
								<div class="col-9">
									<h3 class="card-title">${item.hotelName }</h3>
								</div>
								<div class="col-3">
									<h5 class="card-title">벌점</h5>
								</div>
							</div>

							<h5 class="card-subtitle">침대 갯수</h5>
							<h6 class="card-prices">호텔값</h6>
						</div>
					</div>


				</div>
			</c:forEach>

			<!-- 			<div class="col-6">

				<div class="card" style="width: 23rem; border: none">
					<img src="/resources/hotel/file_repo/1/hotel1.jpg"
						class="card-img-top" alt="...">
					<div class="card-body">
						<div class=row>
							<div class="col-9">
								<h3 class="card-title">호텔이름</h3>
							</div>
							<div class="col-3">
								<h5 class="card-title">벌점</h5>
							</div>
						</div>

						<h5 class="card-subtitle">침대 갯수</h5>
						<h6 class="card-prices">호텔값</h6>
					</div>
				</div>


			</div>
 -->
		</div>

	</div>




	<div class="col-6">

		<div id="map" style="width: 1300px; height: 1500px;"></div>


	</div>

</div>






<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=466f81d1ecaad40dd3b39fec58f9ab91"></script>


<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new kakao.maps.LatLng(37.55173, 126.98403), // 지도의 중심좌표
		level : 4, // 지도의 확대 레벨
		mapTypeId : kakao.maps.MapTypeId.ROADMAP
	// 지도종류
	};

	// 지도를 생성한다 
	var map = new kakao.maps.Map(mapContainer, mapOption);

	// 지도 확대 레벨 변화 이벤트를 등록한다
	kakao.maps.event.addListener(map, 'zoom_changed', function() {
		console.log('지도의 현재 확대레벨은 ' + map.getLevel() + '레벨 입니다.');
	});

	// 지도에 마커를 생성하고 표시한다
	var marker = new kakao.maps.Marker({
		position : new kakao.maps.LatLng(37.55073, 126.97886), // 마커의 좌표
		map : map
	// 마커를 표시할 지도 객체
	});

	// 커스텀 오버레이를 생성하고 지도에 표시한다
	var customOverlay = new kakao.maps.CustomOverlay({
		map : map,
		content : '<div style="padding:0 5px;background:#fff;">안녕하세요 ㅋㅋ</div>',
		position : new kakao.maps.LatLng(37.55073, 126.97886), // 커스텀 오버레이를 표시할 좌표
		xAnchor : 0.5, // 컨텐츠의 x 위치
		yAnchor : 0
	// 컨텐츠의 y 위치
	});
</script>






















<%@include file="../includes/footer.jsp"%>

