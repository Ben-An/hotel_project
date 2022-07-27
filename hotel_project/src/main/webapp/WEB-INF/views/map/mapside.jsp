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
<a href="/hotel/detail?hotelno=${item.hotelno}">
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

		<div id="map" style="width:90%; height:90%;"></div>


	</div>

</div>






<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=466f81d1ecaad40dd3b39fec58f9ab91"></script>



<script>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
	center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 9 // 지도의 확대 레벨
};

	// 지도를 생성한다 
	var map = new kakao.maps.Map(mapContainer, mapOption);


	
		
	// 마커를 표시할 지도 객체

	var positions = [	
		<c:forEach items="${getmap}" var="list">
		
	
		 
		{
		      
			content: '<div class="wrap">' + 
	            '    <div class="info">' + 
	            '        <div class="title">' + 
	            '         <div class="title-name"> <c:out value="${list.realhotelname}"/></div>' + 
	            '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
	            '        </div>' + 
	            '        <div class="body">' + 
	            '            <div class="img">' +
	            '                <img src="<c:out value="${list.hotelfilename}"/>" width="73" height="70">' +
	            '           </div>' + 
	            '            <div class="desc">' + 
	            '                <div class="ellipsis"><c:out value="${list.roadaddr}"/></div>' + 
	            '         			    <div class="review">'+
	         	'					   <div class="rating" data-rate="<c:out value="${list.grade}"/>">'+
	         	'						<i class="fas fa-star"></i> <i class="fas fa-star"></i>'+
	         	'						<i class="fas fa-star"></i> <i class="fas fa-star"></i> <i class="fas fa-star"></i>'+
	            '									</div>' +  
	            '                <button><a href="/hotel/detail?hotelno=${list.hotelno}" class="btn" style="background-color:#FF8C00; color:#FFFFFF;" >숙소보기</a></button>' + 
	            '            </div>' + 
	            '        </div>' + 
	            '    </div>' +    
	            '</div>',
	            /*   <div class="jibun ellipsis">(우) 63309 (지번) 영평동 2181</div>' +  */
	            
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

