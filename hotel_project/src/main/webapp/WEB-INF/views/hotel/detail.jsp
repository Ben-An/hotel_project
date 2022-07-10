<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

    
<%@include file="../includes/header.jsp"%>



<div class="container" >
	<div class="row" >
		<div class="col-12" style="padding:15px; border:1px solid; margin-top:15px;border-radius:5px">
			<h3>숙소이름 </h3>
				<h4>주소</h4>
		</div>
		
	
	
	</div>

</div>


<div class="container mt-4">
	<div class="row">
		<div class="col">
		
		
			<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="/resources/hotel/file_repo/1/hotel1.jpg" class="d-block w-100" alt="..." style="height:300px"> 
    </div>
    <div class="carousel-item">
      <img src="/resources/hotel/file_repo/1/hotel2.jpg" class="d-block w-100" alt="..." style="height:300px">
    </div>
    <div class="carousel-item">
      <img src="/resources/hotel/file_repo/1/hotel3.jpg" class="d-block w-100" alt="..." style="height:300px">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
		
		</div>
	
	</div>

</div>

<div class="container mt-4"> 
	<div class="row">
		<h2>숙소정보</h2>
	
		<div class="col-9">
			<div class="d-flex">
				
				<div class="flex-shrink-0">
					<img alt="" src="/resources/hotel/file_repo/1/hotel3.jpg" style="height:100px;width:100px">
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
	
	</div>

</div>



<div class="container mt-4">
	<h3>고객 이용 후기</h3>
	
	<hr>
</div>







<script type="text/javascript">

</script>










<%@include file="../includes/footer.jsp"%>