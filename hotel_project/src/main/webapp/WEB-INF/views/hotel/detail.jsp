<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<%@include file="../includes/header.jsp"%>






<div class="container mt-4">
	<div class="row">
		<div class="col-12">



			<div id="carouselExampleControls" class="carousel slide"
				data-bs-ride="carousel">
				
				
				<div class="carousel-inner" id="carousel" ></div>
				
				
				
				
				
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
			style="padding: 15px; border: 1px solid  rgb(0,0,0,0.2); margin-top: 15px; border-radius: 5px;">
			<h3>
				숙소이름 :
				${detailList.realhotelname }
			</h3>
			<h4>
				주소 :
				${detailList.roadaddr }
			</h4>
			
			
			
			
		</div>
		
	


	</div>

</div>




<div class="container mt-4">

	<h2>숙소정보</h2>
	<hr>
	
<!-- 	<form>
	<div class="datepicker-to-from">
    <input type="date" id="dates-available-from" class="date-picker" value="11/18/2012 05:45">

    <input type="date" id="dates-available-to" class="date-picker" value="04/09/2014 5:00">
	</div>
		
	</form> -->
	<div class="row roomDetail">
	
	
	
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
	
	<div></div>
	
<div class="relyChat"></div>
	<!-- <div class="row">
		<div class="col-2">

			<div class="row">
				<div class="col-8">


					<div class="rating" data-rate="3">
						<i class="fas fa-star"></i> <i class="fas fa-star"></i> 
						<i class="fas fa-star"></i> <i class="fas fa-star"></i> <i class="fas fa-star"></i>

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
	
		



		</div>

		<hr class="mt-4">



		
	




	</div> -->

	


</div>

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
	




<div class="container mt-3">


	<div
		class="bg-white rounded shadow-sm p-4 mb-5 rating-review-select-page">

		<h5 class="mb-4">댓글</h5>
		
		<form action="/hotel/new.do" method="post" class="replyForm">
		
	
			<input type="radio" name="grade" value="5" id="rate1">
			<label for="rate1">⭐</label>
			<input type="radio" name="grade" value="4" id="rate2">
			<label for="rate2">⭐</label>
			<input type="radio" name="grade" value="3" id="rate3">
			<label for="rate3">⭐</label>
			<input type="radio" name="grade" value="2" id="rate4">
			<label for="rate4">⭐</label>
			<input type="radio" name="grade" value="1" id="rate5">
			<label for="rate5">⭐</label>
		

	
			<input type="hidden" name="memberNo" value="${member.memberNo }" />
			<input type="hidden" name="hotelNo" value="${detailList.hotelno }"/>
			<div class="form-group">
	
			<textarea class="small_text mt-3" name="reviewContent" style="width:100%; height: 200px; border-color: #dadada; padding: 10px 10px 10px 10px" placeholder="리뷰를 작성해주세요."><c:if test="${empty member.memberId}">로그인이 필요합니다.</c:if></textarea>
			
	
			</div>
			<div class="form-group mt-4">
				<button id='registerBtn' type="button" class="btn" style="background-color:#FF8C00; color:#FFFFFF;">제출</button>
			</div>
		</form>


	</div>

</div>




</div>




	<div class="modal fade" id="MyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">댓글</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form>
         
          <div class="mb-3">
            <label for="message-text" class="col-form-label">댓글 수정해주세요:</label>
            <textarea class="form-control" name="reviewContent"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button  id="replyUpdateBtn" type="button" class="btn" style="background-color:#FF8C00; color:#FFFFFF">수정하기</button>
        <button type="button" class="btn" data-bs-dismiss="modal"  style="background-color:#FF8C00; color:#FFFFFF">닫기</button>
      </div>
    </div>
  </div>
</div>







<!-- util.js 시간 추가  -->
<script type="text/javascript" src="/resources/js/util.js"></script>




<!-- detail 처리를 위한 객체 포함 등록  -->
<script type="text/javascript" src="/resources/js/detail.js"></script>


<!-- 객체를 위한 실제적은 처리 가능함  -->
<script type="text/javascript">

/*  별점받기 */
$(function() {

	var rating = $('.rating');
	rating.each(function() {
		var targetScore = $(this).attr('data-rate');
		$(this).find('svg:nth-child(-n+' + targetScore + ')').css({
			color : '#F05522'
		});
	});

});





	$(document)
			.ready(
					function() {
						
						showList();
						
				
							
				function showList(){
					
							var hotelValue = '<c:out value="${detailList.hotelno}"/>';
							var imageUL = $(".carousel-inner");
								detailService
								.list(
										{
											hotelno : hotelValue
										},
										function(list) {

											console.log("list>>>>>>>>" + list);

											var str = "";

									 		for (var i = 0; i < list.length; i++) {

												str += "<div class='carousel-item'><img src='"+list[i].roomfilename+ 
														"'class='d-block w-100' alt='...' style='height:300px;'></div>";

											} 
											
											
										
											

											imageUL.html(str);
											
											roomService();
											
											
											$("#carousel").find('.carousel-item:first-child').addClass('active');
											

										});
										
			
								
								
								
							}
				
				
				function roomService(){
					
					var hotelValue = '<c:out value="${detailList.hotelno}"/>';
					
					var roomUL =$(".roomDetail");
					
					detailService.roomList(
							{
								
								hotelno : hotelValue
													
							},
							function(roomList) {
								
								console.log("roomList>>>>>>"+roomList);
								
								
								
								var str ="";
								
							for(var i = 0; i<roomList.length; i++){
								str+="<div class='mt-3' style='border:1px solid rgb(0,0,0,0.2); padding:10px; border-radius:5px'>";
								
								str +="<div class='row'>"
								str +="<div class='col-9'>";
								str +="<div class='d-flex'>";
								str +="<div class='flex-shrink-0'>";
								str +="	<img alt='' src='/resources/hotel/file_repo/1/hotel3.jpg' style='height: 200px; width: 200px'>";
								str +="</div>";
								str +="<div class='flex-grow-1 ms-2'>";	
								str +="<h6 class='mb-0 mt-2'>방이름: "+roomList[i].roomname+"</h6>";
								str +="<h6 class='mb-1 mt-3'>수용 가능 인원: "+roomList[i].bedno+"</h6>";
								str +="<h6 class='mb-2 mt-3'>방 정보 : "+ roomList[i].infoRoom+"</h6>";
								str +="<p class='mt-3'>예약정보 :"+detailService.displayDate(roomList[i].checkInDate)+"~"+detailService.displayDate(roomList[i].checkOutDate)+"</p>";
								str +="</div>";
								
								str +="</div>";
								str +="</div>";
								
								str +="<div class='col-3 mt-5'>";
								str +="	<div class='row'>";
								str +="<div class='col-6'>";
								str +="<h6>가격: "+roomList[i].roomprice+"원</h6>";
								str +="</div>";
								str +="<div class='col-6'>";
								str +="<a href='/hotel/reservation?roomno="+roomList[i].roomno+"'> <button type='button' class='btn' style='background-color:#FF8C00; color:#FFFFFF; padding:10px 30px'>방예약</button> </a>";
								str +="</div>";

								str +="</div>";
								str +="</div>";
								
								str +="</div>";
								str +="</div>";
								
								
							}
							
						
						
								
							roomUL.html(str);
							relyService();
						
							
							
						}); //end roomList functions
						
					
				}
				
				
				
				function relyService(){
					var hotelno = '<c:out value="${detailList.hotelno}"/>';
					var relyUL =$(".relyChat");
					
					
					detailService.relyList(
							{
								
								hotelno : hotelno
													
							},
							function(relyList) {
								
								console.log("roomList>>>>>>"+relyList);
								
								
								
							var str ="";
								
							for(var i = 0; i<relyList.length; i++){
								
								
								str +="<div class='row'>";
								
								str+="<div style='display:none;' id='replyData' data-reply='"+relyList[i].reviewNo+"' ></div>"
								
								str +="<div class='col-2'>";
								
								str +="<div class='row'>";
								str +="<div class='col-8'>";
						 		str +="<div id='rating' data-rate='"+relyList[i].grade+"'>";
								str +="<i class='fas fa-star'></i><i class='fas fa-star'></i>";
						 		str +="<i class='fas fa-star'></i><i class='fas fa-star'></i><i class='fas fa-star'></i>";
						 		str +="</div>";
						 		
						 		
								str +="</div>";
								
								str +="<div class='col-8 mt-2'>";
								str +="<h3>"+relyList[i].memberNickname+"</h3>";
								str +="	</div>";
								
								
								str +="	</div>";
								
								str +="	</div>";
								
								
								
								
								str +="<div class='col-10' style='background-color: #ddd; height: 200px; border-radius: 5px'>";
								
								str +="<p class='py-3'>"+relyList[i].reviewContent +"</p>";
								
								str +="<p style='margin-top:80px'>"+detailService.displayTime(relyList[i].reviewDate)+"</p>";
								
								
								str +="<div class='row position-relative'>";
								str+="<div class='col-5 position-absolute top-100 start-100 translate-middle d-flex'>";
								str+="<button type='button' class='btn' style='background-color:#FF8C00; color:#FFFFFF' data-bs-toggle='modal' data-bs-target='#MyModal'>수정</button>";
								str+="<button type='button' class='btn' style='background-color:#FF8C00; color:#FFFFFF; margin-left:25px' data-delete='"+relyList[i].reviewNo+"'id='replyDeleteBtn'>삭제</button>";
								
								
								str+="</div>";
								
								
								str+="</div>";
								
								
								
								
								
								str +="	</div>";
								
								str +="	<hr class='mt-4'>";
								
								
								str +="	</div>";
								
								
								
								
				
								
							}
							
						
						
								
							relyUL.html(str);
							
						
							
						}); //end relyList function 
					
					
				}
				
				
				var replyForms= $(".replyForm");	
				var registerBtn = $("#registerBtn");
				var hotelValue = '<c:out value="${detailList.hotelno}"/>';
				var inputGrade = $('input[name=grade]');
				var inputReviewContent = replyForms.find("textarea[name='reviewContent']");
				var memberIdValue = '<c:out value="${member.memberNo}"/>';
				var relyUL =$(".relyChat");
				
				
				
				
				
				
				
				//댓글 작성
				registerBtn.on("click",function(e){
					
					var reply = {
							grade:inputGrade.val(), 
							reviewContent:inputReviewContent.val(),
							hotelNo:hotelValue,
							memberNo:memberIdValue
							
							
							
							
							
					};
					
					
					console.log(reply);
					
					detailService.add(reply, function(result){
						alert(result);
						
						
						replyForms.find("input").val("");
						
						
						
						showList();
					});
					
					
				});
				
				
				
					
				
			 $(document).on("click","#replyDeleteBtn", function(e){

					
						var reviewNo = $(this).data("delete");
						
						console.log("reviewNo>>>>>>>>>>>>"+reviewNo);
					
						detailService.deleteReply(reviewNo, function(result){
						
						alert(result);
						showList();
						
					});
					
					
					
					
				});  
			 
			 
			 
			 $("#replyUpdateBtn").on("click", function(e){
				
				 	var reviewNo = $("#replyData").data("reply");
				 
				 	var modal = $("#MyModal");
				 	
				 	var reviewContent = modal.find("textarea[name='reviewContent']").val();
				 	
				 	
				 	console.log("modalReivew>>>>>>>>>>>>"+reviewContent);
				 	
					var reply = {reviewNo : reviewNo, reviewContent : reviewContent}; 	
				 	
				 	
					detailService.update(reply,function(result){
						
						alert(result);
						
						modal.modal("hide");
						
						showList();
						
					
					
					});
					
				 
				 
			 });
		
				

			
				
				
				//datepicker range
			/* 	var fromDate = new Date();
				$('#dates-available-from').daterangepicker({
				  singleDatePicker: true,
				  showDropdowns: true,
				  autoApply:true,
				  locale: {
				    format: 'YYYY-MM-DD'
				  },
				 minDate:new Date()
				 },
				 function(start, end, label) {
				  fromDate =  start.format('YYYY-MM-DD');   
				  $('dates-available-to').daterangepicker({
				    singleDatePicker: true,
				    showDropdowns: true,
				    autoApply:true,
				    locale: {
				      format: 'YYYY-MM-DD'
				    },
				    minDate:fromDate
				 });
				}); */
				
				
				
			
				
			
							
							
			
		
		
		
		
		
		
						

					});
	
	
	
	
	
	
	
	
</script>

















<%@include file="../includes/footer.jsp"%>