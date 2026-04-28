<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>




<%@include file="../includes/header.jsp"%>
















<div class="mapside-container">
	<!-- Sidebar: Hotel List -->
	<div class="mapside-sidebar">
		<div class="mapside-sidebar-header">
			<h5><i class="bi bi-building"></i> 검색 결과 <span class="badge bg-secondary">${getmap.size()}</span></h5>
		</div>
		<div class="mapside-hotel-list">
			<c:choose>
				<c:when test="${not empty getmap}">
					<c:forEach var="item" items="${getmap}">
						<a href="/hotel/detail?hotelno=${item.hotelno}" class="hotel-list-card">
							<img src="${item.hotelfilename}" class="card-img-left" alt="${item.realhotelname}">
							<div class="card-body">
								<h6 class="card-title">${item.realhotelname}</h6>
								<p class="text-muted mb-1" style="font-size:0.85rem;"><i class="bi bi-door-open"></i> 객실 ${item.bedNo}개</p>
								<p class="card-price">${item.roomPrice}원</p>
							</div>
						</a>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="mapside-empty">
						<i class="bi bi-search"></i>
						<p>해당 지역의 숙소가 없습니다</p>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<!-- Map -->
	<div class="mapside-map">
		<div id="map"></div>
	</div>
</div>






<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=466f81d1ecaad40dd3b39fec58f9ab91"></script>



<script>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
	center: new kakao.maps.LatLng(37.4, 127.0), // 경기도 중심좌표
    level: 9 // 지도의 확대 레벨
};

	// 지도를 생성한다 
	var map = new kakao.maps.Map(mapContainer, mapOption);


	
		
	// 마커를 표시할 지도 객체

	var positions = [	
		<c:forEach items="${getmap}" var="list">
		
	
		 
		{
		      
			content: '<div class="iw-wrap">' +
	            '<div class="iw-img"><img src="<c:out value="${list.hotelfilename}"/>" alt="<c:out value="${list.realhotelname}"/>"></div>' +
	            '<div class="iw-body">' +
	            '<h6 class="iw-title"><c:out value="${list.realhotelname}"/></h6>' +
	            '<p class="iw-addr"><c:out value="${list.roadaddr}"/></p>' +
	            '<div class="iw-rating review"><div class="rating" data-rate="<c:out value="${list.grade}"/>">' +
	            '<i class="fas fa-star"></i> <i class="fas fa-star"></i> ' +
	            '<i class="fas fa-star"></i> <i class="fas fa-star"></i> <i class="fas fa-star"></i>' +
	            '</div></div>' +
	            '<a href="/hotel/detail?hotelno=${list.hotelno}" class="btn-iw">숙소보기</a>' +
	            '</div></div>',
	            
		 		 latlng: new kakao.maps.LatLng(${list.lat},${list.logt})
		 	
		
					
		    },
		    

		
		    </c:forEach> 
		 
		    
		
		    
	];
	
	
	
	
	
	
	
	
	// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
	var bounds = new kakao.maps.LatLngBounds();    

	 
	
	

	var i, marker, overlay;
	for (i = 0; i < positions.length; i ++) {
		
		 	 marker = new kakao.maps.Marker({
		     	map: map,
		        position: positions[i].latlng
		    
		    });
		 	 
		 	 
		 	 
	
		 	 var iwContent = positions[i].content,
		 	 iwRemoveable = true;
		 	 
		 	 var infowindow = new kakao.maps.InfoWindow({
		 		content: iwContent,
		 		removable : iwRemoveable
		 		 
		 	 });
		 	 
		 	 
		     bounds.extend(positions[i].latlng);

		 	  
		
		 	 
		 	kakao.maps.event.addListener(marker, 'click', function(info, mark) {
		 	    return function() { 
		 	        info.open(map, mark);
		 	    }
		 	}(infowindow, marker));
		 	 
		 	
		  }
	
	

	
    // LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
    // 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
    map.setBounds(bounds);

	
	
	

</script>		


<script type="text/javascript">
/*  별점받기 */
$(function() {

	var rating = $('.review .rating');
	rating.each(function() {
		var targetScore = $(this).attr('data-rate');
		$(this).find('svg:nth-child(-n+' + targetScore + ')').css({
			color : '#F05522'
		});
	});

});

</script>

		






















<%@include file="../includes/footer.jsp"%>

