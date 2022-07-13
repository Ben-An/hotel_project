<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<%@include file="../includes/header.jsp"%>










<div class="container mt-4 d-flex">
	<div class="row">
		<div class="col">






			<div id="carouselExampleControls" class="carousel slide"
				data-bs-ride="carousel">
				
				
				<div class="carousel-inner">
					
			
				
				</div>
				
				
				
				
				
				<button class="carousel-control-prev" type="button"
					data-bs-target="#carouselExampleControls" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="#carouselExampleControls" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div> 

		</div>




	</div>



</div>








<div class="container">
	<div class="row">

		<div class="col-12"
			style="padding: 15px; border: 1px solid; margin-top: 15px; border-radius: 5px">
			<h3>
				숙소이름 :
				<c:out value="${detailList.realhotelname }"></c:out>
			</h3>
			<h4>
				주소 :
				<c:out value="${detailList.roadaddr }"></c:out>
			</h4>
		</div>



	</div>

</div>




<div class="container mt-4">

	<h2>숙소정보</h2>
	<hr>
	<div class="row roomDetail" style="border:1px solid; padding:10px; border-radius:15px">
	
		<!-- <div class="col-9">
			<div class="d-flex">

				<div class="flex-shrink-0">
					<img alt="" src="/resources/hotel/file_repo/1/hotel3.jpg"
						style="height: 100px; width: 100px">
				</div>

				<div class="flex-grow-1 ms-2">
					<h6 class="mb-0">방이름</h6>
					<h6 class="mb-1">수용 가능 인원</h6>
					<h6 class="mb-2">방정보</h6>

				</div>


			</div>


		</div>


		<div class="col-3 mt-3  mt-md-1">
			<div class="row">

				<div class="col-6">

					<p>방가격</p>
				</div>

				<div class="col-6">
					<button>방예약</button>

				</div>

			</div>

		</div>
 -->
	</div>

</div>



<div class="container mt-4">
	<h3>고객 이용 후기</h3>
	
	<hr>

	<div class="row">
		<div class="col-2">

			<div class="row">
				<div class="col-8">


					<div class="rating" data-rate="3">
						<i class="fas fa-star"></i> <i class="fas fa-star"></i> <i
							class="fas fa-star"></i> <i class="fas fa-star"></i> <i
							class="fas fa-star"></i>

					</div>




				</div>

				<div class="col-8 mt-2">
					<h3>닉네임</h3>
				</div>


			</div>

		</div>

		<div class="col-10"
			style="background-color: #ddd; height: 200px; border-radius: 5px">



			<p class="py-3">Service of staff is exceptional and goes out of
				their way to satisfy your needs. All staff speaks English. The room
				is comfortable and sparkling clean with cleaning twice daily. The
				teabags given were from TWG and toiletries from Molten Brown. Didn't
				know they provide fetching service when we arrive and had a hard
				time pushing our luggages up the slope but when we leave they
				offered to fetch us to the shuttle bus waiting point, with the staff
				by our side. Price is high but they make every cent worth!</p>


			<h5>작성일</h5>

			<hr>

			<div></div>



		</div>

		<hr class="mt-4">



		<div>
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<li class="page-item"><a class="page-link" href="#"
						aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
					</a></li>
					<li class="page-item"><a class="page-link" href="#">1</a></li>
					<li class="page-item"><a class="page-link" href="#">2</a></li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					<li class="page-item"><a class="page-link" href="#"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
				</ul>
			</nav>
		</div>




	</div>



</div>




<div class="container mt-3">


	<div
		class="bg-white rounded shadow-sm p-4 mb-5 rating-review-select-page">

		<h5 class="mb-4">Leave Comment</h5>
		<p class="mb-2">Rate the Place</p>
		<div class="mb-4">
			<span class="star-rating"> <a href="#"><i
					class="icofont-ui-rating icofont-2x"></i></a> <a href="#"><i
					class="icofont-ui-rating icofont-2x"></i></a> <a href="#"><i
					class="icofont-ui-rating icofont-2x"></i></a> <a href="#"><i
					class="icofont-ui-rating icofont-2x"></i></a> <a href="#"><i
					class="icofont-ui-rating icofont-2x"></i></a>
			</span>
		</div>
		<form>
			<div class="form-group">
				<label>Your Comment </label>
				<textarea class="form-control"></textarea>
			</div>
			<div class="form-group mt-4">
				<button>작성하기</button>
			</div>
		</form>


	</div>

</div>





</div>




<!-- detail 처리를 위한 객체 포함 등록  -->
<script type="text/javascript" src="/resources/js/detail.js"></script>


<!-- 객체를 위한 실제적은 처리 가능함  -->
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						
						
						
							//carousel .active 설정 하기
						
							
							$('.carousel-control-next').click(function(){
								
								//alert("눌러주셈 ");
								var next = $('.carousel-inner .active').removeClass('active').next();
								
								if(next.length==0){
									
									next = $('.carousel div').first();
									
								}
								
								next.addClass('active');
								
								
								
							});
							
							
							
							
							$('.carousel-control-prev').click(function(){
								
								//alert("눌러주셈 ");
								
								var prev = $('.carousel-inner .active').removeClass('active').prev();
								
								if(prev.length==0){
									
									prev = $('.carousel div').last();
								}
								
								prev.addClass('active');
								
								
								
							});
							
							
							
						
						
						

				
					
		
							var hotelValue = '<c:out value="${detailList.hotelno}"/>'
							var imageUL = $(".carousel-inner");
							var roomUL =$(".roomDetail");
						

							console.log("hotelno>>>>>>>" + hotelValue);
							
				detailService
							.list(
									{
										hotelno : hotelValue
									},
									function(list) {

										console.log("list>>>>>>>>" + list);

										var str = "";

										for (var i = 0; i < list.length; i++) {

											str += "<div class='carousel-item active'>";
											str += "<img src='"+list[i].roomfilename+ 
													"'class='d-block w-100' alt='...' style='height: 300px; width: 200px'></div>";

										}

										imageUL.html(str);

									});
									
				detailService.roomList(
								{
									
									hotelno : hotelValue
														
								},
								function(roomList) {
									
									console.log("roomList>>>>>>"+roomList);
									
									
									
									var str ="";
									
								for(var i = 0; i<roomList.length; i++){
									
									str +="<div class='col-9'>";
									str +="<div class='d-flex'>";
									str +="<div class='flex-shrink-0'>";
									str +="	<img alt='' src='/resources/hotel/file_repo/1/hotel3.jpg' style='height: 100px; width: 100px'>";
									str +="</div>";
									str +="<div class='flex-grow-1 ms-2'>";	
									str +="<h6 class='mb-0'>방이름: "+roomList[i].roomname+"</h6>";
									str +="<h6 class='mb-1'>수용 가능 인원: "+roomList[i].bedno+"</h6>";
									str +="<h6 class='mb-2'>방정보</h6>";
									str +="</div>";
									
									str +="</div>";
									str +="</div>";
									
									str +="<div class='col-3 mt-3  mt-md-1'>";
									str +="	<div class='row'>";
									str +="<div class='col-6'>";
									str +="	<p>"+roomList[i].roomprice+"원</p>";
									str +="</div>";
									str +="<div class='col-6'>";
									str +="<button>방예약</button>";
									str +="</div>";

									str +="</div>";
									str +="</div>";
									
									
								}
								
							
							
									
								roomUL.html(str);
								
								
							}); //end roomList functions
							
							
							
							
							
							
							
					
						
			
										
										
				
							
							
					
						

					});
</script>










<%@include file="../includes/footer.jsp"%>