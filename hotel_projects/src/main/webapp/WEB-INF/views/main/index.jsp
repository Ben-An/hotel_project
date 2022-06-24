<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

	
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
 <script src="/resources/js/jquery.min.js"></script>
</head>
<body>
	<div class=mainHotel>

		<c:forEach var="item" items="${list }">
		<%-- 	<c:set var="goods_count" value="${goods_count+1 }" /> --%>
			<div class="hotel ">
				 <img width="121" height="154"
					src="${contextPath}/thumbnails.do?hotelNo=${item.HotelNo}&hotelFileName=${item.hotelFileName}">

				
			</div>
				<%-- <c:if test="${goods_count==15   }"> --%>
			
			
		</c:forEach>

	</div>
	
	<script type="text/javascript">
		$(document).ready(function(){(function(){
			
			$.getJSON("/main/getList", function(arr){
				
				console.log(arr);
				
			});//end getjson
			
			
		});(); 
			
		
		});
	
	</script>
</body>
</html>