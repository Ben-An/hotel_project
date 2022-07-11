<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%@include file="../includes/header.jsp"%>


<div style="display: flex; flex-direction: row; margin:30px 0 30px;">
	<%@include file="../includes/search_filter.jsp"%>
	<div style="margin-left: 20px;">
	<c:set var="hotelNo" value="0"/>
		<c:forEach var="item" items="${list }">
			<c:set var="hotelNo" value="${hotelNo+1 }"/>  
		    <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative" style="width: 1000px;">
			    <div class="col-auto d-none d-lg-block">
			    	<img src="${item.hotelFileName }" class="card-img-top" alt="" style="width: 200px; height: 150px; ">
			    </div>
			    <div class="col p-4 d-flex flex-column position-static">
				    <h3 class="mb-0">${item.realhotelName }</h3>
				    <div class="mb-1 text-muted">평균 별점</div>
				    <p class="card-text mb-auto">상세 조건</p>
			    </div>  
		    </div>
		</c:forEach>
		<%-- <nav aria-label="Page navigation example">
			<ul class="pagination" style="justify-content: center;">
				<c:if test="${pageMaker.prev }">
					<li class="page-item">
						<a class="page-link" href="${pageMaker.startPage -1}">Previous</a>
					</li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
					<li class="page-item ${pageMaker.cri.pageNum == num ? "active" : "" }">
						<a class="page-link" href="${num }">${num }</a>
					</li>
				</c:forEach>
				<c:if test="${pageMaker.next }">
					<li class="page-item">
						<a class="page-link" href="${pageMaker.endPage +1}">Next</a>
					</li>
				</c:if>
			</ul>			    
		</nav> --%>
	</div>
</div>


<%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
	$(document).ready(function(){
		var actionForm = $("#actionForm");
		
		$(".page-item a").on("click", function(e){
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
	});	
</script>
