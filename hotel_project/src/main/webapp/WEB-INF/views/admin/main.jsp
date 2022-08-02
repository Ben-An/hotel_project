<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<style>
	.myPageContainer{
		margin-top: 100px;
		margin-bottom: 100px;
	}
	.myPageContainer table{
		text-align: center;
	}
</style>

<%@include file="../includes/header.jsp"%>

<div style="width: 60%; margin: auto">
	<div class="myPageContainer">
		<h3>예약 내역 조회</h3>
		<hr>
			<table class="table table-sm">
				<c:forEach var="item" items="${myPageList }">
			  		<thead>
				  		<tr>
				  			<th>예약 호텔</th>
				  			<th>예약 인원</th>
				  			<th>예약 날짜</th>
				  		</tr>
			  		</thead>
			  		<tbody>
				  		<tr>
				  			<td>${item.hotelName }</td>
				  			<td>${item.userAmount }</td>
				  			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${item.checkInDate }" />
				  			~ <fmt:formatDate pattern="yyyy-MM-dd" value="${item.checkOutDate }" /></td>
				  		</tr>
			  		</tbody>
		  		</c:forEach>
			</table>
			
			<div style="text-align: right;"><a href="${contextPath}/member/myPage_reservationList?memberNo=${item.memberNo }">전체보기<i class="fa-solid fa-angle-right"></i></a></div>
		</div>
		
	<div class="myPageContainer">
		<h3>숙소 등록</h3>
		<hr>
		<div class="container">
			<div class="row">
				<c:forEach items="${list}" var="list">
				<c:set var="imagePath" value="${uploadPath}" />
				<c:set var="imageName" value="${hotelFileName}" />
					<div class="col-12 col-md-5 col-lg-3 ">
						<div class="card">
						<img src="${contextPath}/C:upload/${list.uploadPath}/${list.uuid}_${list.hotelFileName}">
							<%-- <div class="image_wrap" data-bookid="${list.imageList[0].hotelNo}" data-path="${list.imageList[0].uploadPath}" data-uuid="${list.imageList[0].uuid}" data-filename="${list.imageList[0].hotelFileName}">
								<img>
							</div> --%>
							<div id="uploadReslut">
																		
									</div>

<!-- 									<img src="http:\\localhost:8080\upload\2022\07\20\${list.hotelFileName }">
									<img src="http:\\localhost:8080\upload\2022\07\20\hoteltext.png"> -->
							<div class="card-body">
								<span class="badge bg-primary "	style="border-radius: 10px; margin-bottom: 10px;">${list.mainAddress }</span>
								<h5 class="card-title">${list.hotelName }</h5>
								<h5 class="card-title">${list.uploadPath }</h5>
								<p><fmt:formatDate value="${list.hotelRegistDate}" pattern="yyyy-MM-dd"/></p>
								<%-- <p>${item.mainAddress }</p> --%>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
<%-- 			<!-- 페이지 이름 인터페이스 영역 -->
                	<div class="pageMaker_wrap">
                		<ul class="pageMaker">
                			
                			<!-- 이전 버튼 -->
                			<c:if test="${pageMaker.prev }">
                				<li class="pageMaker_btn prev">
                					<a href="${pageMaker.startPage -1}">이전</a>
                				</li>
                			</c:if>
                			
                			<!-- 페이지 번호 -->
                			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
                				<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? 'active':''}">
                					<a href="${num}">${num}</a>
                				</li>	
                			</c:forEach>
                		
	                    	<!-- 다음 버튼 -->
	                    	<c:if test="${pageMaker.next}">
	                    		<li class="pageMaker_btn next">
	                    			<a href="${pageMaker.endPage + 1 }">다음</a>
	                    		</li>
	                    	</c:if>
	                    </ul>
                	</div>
                	<form id="moveForm" action="/admin/main" method="get" >
 						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
						<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
                	</form>
		</div> --%>
		<div style="text-align: right;"><a href="${contextPath}/admin/addHotel">숙소등록<i class="fa-solid fa-angle-right"></i></a></div>
	</div>
	
	<div class="myPageContainer">	
		<h3>신고 리뷰 조회</h3>
		<hr>
		<table class="table table-sm">
			<c:forEach var="item" items="${myPageList }">
		  		<thead>
			  		<tr>
			  			<th>호텔</th>
				  		<th>이용자</th>
				  		<th>리뷰내용</th>
				  		<th>작성일</th>
					</tr>
			  	</thead>
			  	<tbody>
				 	<tr>
				  		<td>${item.hotelName }</td>
				  		<td>${item.realUser }</td>
				  		<td>${item.reviewContent }</td>
				 		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${item.reviewDate }" /></td>
				  	</tr>
			  	</tbody>
		  	</c:forEach>
		</table>
		<div style="text-align: right;"><a href="${contextPath}/member/myPage_reviewList?memberNo=${item.memberNo }">전체보기<i class="fa-solid fa-angle-right"></i></a></div>
	</div>
	
</div>

<%@include file="../includes/footer.jsp"%>
<script>

let moveForm = $('#moveForm');

$(document).ready(function(){
	/* 이미지 출력 */
	let uploadResult = $("#uploadResult");
	//let obj = uploadResultArr[0];
	//let str = "";
	//let fileCallPath = "/s_" + obj.uuid + "_" + obj.hotelFileName;
	
	//console.log("파일경로"+fileCallPath);
	//console.log("파일경로"+obj.hotelFileName);
	
	str += "<div id='result_card'>";
	str += "<img src='/hotel/display?fileName=" + fileCallPath +"'>";
	str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
	str += "<input type='hidden' name='imageList[0].hotelFileName' value='"+ obj.hotelFileName +"'>";
	str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
	str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";		
	str += "</div>";		
	
		uploadResult.append(str);  
});

/* 페이지 이동 버튼 */
$(".pageMaker_btn a").on("click", function(e){
	
	e.preventDefault();
	
	moveForm.find("input[name='pageNum']").val($(this).attr("href"));
	
	moveForm.submit();
	
});

</script>
