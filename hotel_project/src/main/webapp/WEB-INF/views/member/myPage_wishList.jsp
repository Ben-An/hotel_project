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
	</div>
</div>


<%@include file="../includes/footer.jsp"%>
