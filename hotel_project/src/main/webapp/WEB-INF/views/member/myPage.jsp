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
				<c:forEach var="item" items="${myPageList }">
					<tbody>
						<tr>
							<th scope="row">이름</th>
							<td>${item.memberName }<td>
						</tr>
						<tr>
							<th scope="row">아이디</th>
							<td>${item.memberId }<td>
						</tr>
						<tr>
							<th scope="row">닉네임</th>
							<td>${item.memberNickname }<td>
						</tr>
					</tbody>		
				</c:forEach>
			</table>
			
		<div style="text-align: right;"><a href="#">수정<i class="fa-solid fa-angle-right"></i></a></div>
	</div>

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
		<h3>내가 쓴 리뷰</h3>
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
	
	<div class="myPageContainer">
		<h3>내가 찜한 숙소</h3>
		<hr>
		<div class="container">
			<div class="row">
				<c:forEach var="item" items="${myPageList }">
					<div class="col-12 col-md-5 col-lg-3 ">
						<div class="card">
							<img src="${item.hotelFileName }" class="card-img-top" alt="" style="height: 250px ">
							<div class="card-body">
								<span class="badge bg-primary "	style="border-radius: 10px; margin-bottom: 10px;">추천</span>
								<h5 class="card-title">${item.hotelName }</h5>
								<%-- <p>${item.mainAddress }</p> --%>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div style="text-align: right;"><a href="${contextPath}/member/myPage_wishList?memberNo=${item.memberNo }">전체보기<i class="fa-solid fa-angle-right"></i></a></div>
	</div>
</div>


<%@include file="../includes/footer.jsp"%>
