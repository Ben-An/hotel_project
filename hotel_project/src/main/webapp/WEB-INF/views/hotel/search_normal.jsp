<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%@include file="../includes/header.jsp"%>


<div style="display: flex; flex-direction: row; margin:30px 0 30px;">
	<%@include file="../includes/search_filter.jsp"%>
	<div style="margin-left: 20px;" id="contentList">
	<c:set var="hotelNo" value="0"/>
		<c:forEach var="item" items="${list }">
			<c:set var="hotelNo" value="${hotelNo+1 }"/>  
		    <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative hotelContent" style="width: 1000px;">
			    <div class="col-auto d-none d-lg-block">
			    	<img src="${item.hotelFileName }" class="card-img-top" alt="" style="width: 200px; height: 150px; ">
			    </div>
			    <div class="col p-4 d-flex flex-column position-static">
				    <h3 class="mb-0">${item.realhotelName }</h3>
				    <div class="mb-1 text-muted">평균 별점</div>
				    <p class="card-text mb-auto roomPrice">${item.roomPrice }원</p>
			    </div>  
			    <span class="filter_cond" style="display:none">
			    ${item.buffet == 'T'? 'buffet': '' } ${item.swim == 'T'? 'swim': '' } 	
			    </span>
		    </div>
		</c:forEach>
		<nav aria-label="Page navigation example">
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
		</nav>
	</div>
</div>


<%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
	$(document).ready(function(){
		let actionForm = $("#actionForm");
		
		$(".page-item a").on("click", function(e){
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		let lowPrice = 0;
		let highPrice = 0;
		$( "#slider-range" ).slider({
		      range: true,
		      min: 0,
		      max: 100000,
		      step: 5000,
		      values: [ 0, 100000 ],
		      slide: function( event, ui ) {
		      	lowPrice = ui.values[0];
		    	highPrice = ui.values[1];
		    	//console.log("lowPrice >>> ", lowPrice);    
			  	//console.log("highPrice >>> ", highPrice);
		        $( "#price" ).val( "₩" + lowPrice + " ~ ₩" + highPrice );
		      }
		    });
		    $( "#price" ).val( "₩" + $( "#slider-range" ).slider( "values", 0 ) +
		      " ~ ₩" + $( "#slider-range" ).slider( "values", 1 ) ); 
		
		
		console.log("lowPrice >>> ", lowPrice);
	  	console.log("highPrice >>> ", highPrice);
		   
		let optionFilters = $("input[name='option']");
		
		let filter_cond_spans = $(".filter_cond");
		
		console.log("optionFilters >>>> ", optionFilters);
		
		let roomPrices = document.getElementsByClassName('roomPrice');
		//roomPrice = roomPrice.replace(/,/g, "");
		//roomPrice = parseInt(roomPrice);
		console.log(roomPrices[0]);
		
		optionFilters.on("change", function () {
			let selectedFilters = $("input[name='option']:checked");
			console.log("selectedFilters >>>> ", selectedFilters);
			if(selectedFilters.length == 0){
				filter_cond_spans.parent().show();
			}else{
				$.each(selectedFilters, function (index, item) {
					let value = $(item).val().toLowerCase();
					console.log("value >>>>>>>> ", value);
					filter_cond_spans.filter(function() {
						$(this).parent().toggle($(this).text().toLowerCase().indexOf(value) > -1);
					});
				});
			}
		}); 
	});	
	
	/* $( function() {
	    $( "#slider-range" ).slider({
	      range: true,
	      min: 0,
	      max: 100000,
	      values: [ 0, 100000 ],
	      slide: function( event, ui ) {
	    	let lowPrice = ui.values[0];
	    	let highPrice = ui.values[1];
	        $( "#price" ).val( "₩" + lowPrice + " ~ ₩" + highPrice );
	      }
	    });
	    $( "#price" ).val( "₩" + $( "#slider-range" ).slider( "values", 0 ) +
	      " ~ ₩" + $( "#slider-range" ).slider( "values", 1 ) ); 
	  }); */
	
</script>
