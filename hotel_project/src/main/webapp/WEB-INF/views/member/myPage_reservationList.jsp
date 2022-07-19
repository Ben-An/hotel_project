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
		<h3>전체 예약 내역</h3>
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
				  			<td>${item.memberAmount }</td>
				  			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${item.checkInDate }" />
				  			~ <fmt:formatDate pattern="yyyy-MM-dd" value="${item.checkOutDate }" /></td>
				  		</tr>
			  		</tbody>
		  		</c:forEach>
			</table>
		</div>
</div>


<%@include file="../includes/footer.jsp"%>
