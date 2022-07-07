<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>




<%@include file="../includes/header.jsp"%>
















<div class="row" style="margin-top: 30px;">

	<div class="col-6">

		<div class="row" style="margin-left: 10px">
			<c:forEach var="item" items="${getmap }">

				<div class="col-6">
<a href="#">
					<div class="card" style="width: 23rem; border: none">
						<img src="${item.hotelfilename }"
							class="card-img-top" alt="..." style="height: 250px">
						<div class="card-body">
							<div class=row>
								<div class="col-10" style="">
									<h3 class="card-title">${item.realhotelname }</h3>
								</div>
								<div class="col-2">
								<!-- 	<h5 class="card-title">벌점</h5> -->
								</div>
							</div>

							<h5 class="card-subtitle">방갯수:${item.bedNo}<h5>
							<h6 class="card-prices">가격:${item.roomPrice }원</h6>
						</div>
					</div>
</a>

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

		<div id="map" style="width: 1150px; height: 1500px;"></div>


	</div>

</div>






<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=466f81d1ecaad40dd3b39fec58f9ab91"></script>



<script>

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new kakao.maps.LatLng(37.6254389,126.7122455), // 지도의 중심좌표
		level : 9, // 지도의 확대 레벨
		mapTypeId : kakao.maps.MapTypeId.ROADMAP
	// 지도종류
	};

	// 지도를 생성한다 
	var map = new kakao.maps.Map(mapContainer, mapOption);

	// 지도 확대 레벨 변화 이벤트를 등록한다
	kakao.maps.event.addListener(map, 'zoom_changed', function() {
		console.log('지도의 현재 확대레벨은 ' + map.getLevel() + '레벨 입니다.');
	});
	
		
	// 마커를 표시할 지도 객체

	var positions = [	
	
		
		 <c:forEach items="${getmap}" var="list">
		 
		{
		       
		        latlng: new kakao.maps.LatLng(${list.lat},${list.logt})
		    },



		    </c:forEach> 
		    
		
		    
	];
	
	
	for (var i = 0; i < positions.length; i ++) {
		
		  var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng
		    
		    });
		  
		  }
</script>		
	
		






















<%@include file="../includes/footer.jsp"%>

