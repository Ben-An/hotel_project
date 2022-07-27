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
		<h3>사용자 정보</h3>
		<hr>
			<table class="table">	
					<tbody>
							<tr>
								<th scope="row">이름</th>
								<td>${member.memberName }<td>
							</tr>
							<tr>
								<th scope="row">아이디</th>
								<td>${member.memberId }<td>
							</tr>
							<tr>
								<th scope="row">닉네임</th>
								<td>${member.memberNickname }<td>
							</tr>
					</tbody>		
			</table>
			
		<div style="text-align: right;"><a href="${contextPath }/member/myPage_memberUpdate?memberNo=${member.memberNo}">수정<i class="fa-solid fa-angle-right"></i></a>
		<a href="${contextPath }/member/myPage_memberDelete?memberNo=${member.memberNo}">탈퇴<i class="fa-solid fa-angle-right"></i></a></div>
	</div>

	<div class="myPageContainer">
		<h3>예약 내역 조회</h3>
		<hr>
			<table class="table table-sm">
			  		<thead>
				  		<tr>
				  			<th>예약 호텔</th>
				  			<th>투숙자</th>
				  			<th>예약 인원</th>
				  			<th>예약 날짜</th>
				  		</tr>
			  		</thead>
			  		<tbody>
					  		<tr class = "reservation_List">
					  			<c:if test = "${item.reservationNo != null}">
						  			<td>${item.realhotelName }</td>
						  			<c:if test = "${item.realUser != null }">
						  				<td>${item.realUser }</td>
						  			</c:if>
						  			<c:if test = "${item.realUser == null }">
						  				<td>${item.memberName }</td>
						  			</c:if>
						  			<td>${item.userAmount }</td>
						  			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${item.checkInDate }" />
						  			~ <fmt:formatDate pattern="yyyy-MM-dd" value="${item.checkOutDate }" /></td>
					  			</c:if>
					  			<c:if test = "${item.reservationNo == null}">
						  			<td>예약 내역이 없습니다.</td>
					  			</c:if>
					  		</tr>
			  		</tbody>
		  		
			</table>
			
			<div style="text-align: right;"><a href="${contextPath}/member/myPage_reservationList?memberNo=${item.memberNo }">전체보기<i class="fa-solid fa-angle-right"></i></a></div>
		</div>
	
	<div class="myPageContainer">	
		<h3>내가 쓴 리뷰</h3>
		<hr>
		<table class="table table-sm">
		  		<thead>
			  		<tr>
			  			<th>호텔</th>
				  		<th>이용자</th>
				  		<th>리뷰내용</th>
				  		<th>작성일</th>
					</tr>
			  	</thead>
			  	<tbody>
			  		<c:forEach var="item" items="${myReviewList }">
				 	<tr>	 		
					  		<td>${item.realhotelName }</td>
					  		<td>${item.memberNickname }</td>
					  		<td>${item.reviewContent }</td>
					 		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${item.reviewDate }" /></td>	
				  	</tr>
				  	</c:forEach>
			  	</tbody>
		  	
		</table>
		<div style="text-align: right;"><a href="${contextPath}/member/myPage_reviewList?memberNo=${item.memberNo }">전체보기<i class="fa-solid fa-angle-right"></i></a></div>
	</div>
	
	<div class="myPageContainer">
		<h3>내가 찜한 숙소</h3>
		<hr>
		<div class="container">
			<div class="row">
				<c:forEach var="item" items="${myWishList }" begin="0" end="5" step="1" varStatus="status">
					<c:if test = "${item.wishListNo != null }">
						<div class="col-12 col-md-5 col-lg-3 ">
							<div class="card">
								<img src="${item.hotelFileName }" class="card-img-top" alt="" style="height: 250px ">
								<div class="card-body">
									<h5 class="card-title">${item.realhotelName }</h5>
									<p>${item.state }</p>
								</div>
							</div>
						</div>
					</c:if>
					<c:if test = "${item.wishListNo == null }">
						<p>찜한 숙소가 없습니다</p>
					</c:if>
				</c:forEach>
			</div>
		</div>
		<div style="text-align: right;"><a href="${contextPath}/member/myPage_wishList?memberNo=${item.memberNo }">전체보기<i class="fa-solid fa-angle-right"></i></a></div>
	</div>
</div>

<script>
	function fn_update(){
    
	    var form = document.getElementById("viewForm");
	    
	    form.action = "<c:url value='/board/memberUpdate.do'/>";
	    form.submit();
	}
	
/* 	$(document)
	.ready(
			function() {
				function reservationList(){
					var memberno = 
				}
			} */
</script>


<%@include file="../includes/footer.jsp"%>
