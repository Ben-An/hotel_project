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
				  		<td>${item.realMember }</td>
				  		<td>${item.reviewContent }</td>
				 		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${item.reviewDate }" /></td>
				  	</tr>
			  	</tbody>
		  	</c:forEach>
		</table>
	</div>
</div>


<%@include file="../includes/footer.jsp"%>
