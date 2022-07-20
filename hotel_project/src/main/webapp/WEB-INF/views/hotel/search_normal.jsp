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
		    <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative hotelContent selectable_price selectable_grade selectable_option" style="width: 1000px;">
			    <div class="col-auto d-none d-lg-block">
			    	<img src="${item.hotelFileName }" class="card-img-top" alt="" style="width: 200px; height: 150px; ">
			    </div>
			    <div class="col p-4 d-flex flex-column position-static">
				    <h3 class="mb-0">${item.realhotelName }</h3>
				    <div class="mb-1 text-muted averageGrade">${item.ag }</div>
				    <p class="card-text mb-auto roomPrice" >${item.roomPrice }원</p>
			    </div>  
			    <span class="filter_cond" style="display:none">
			    ${item.state } ${item.buffet == 'T'? 'buffet': '' } ${item.swim == 'T'? 'swim': '' } 	
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

	if($("hotelContent").hasClass("selectable_price") === true) {

		$("hotelContent").show();

	} else {

		$("hotelContent").hide();

	}
	
	$( "#slider-range" ).slider({
	      range: true,
	      min: 0,
	      max: 100000,
	      step: 5000,
	      values: [ 0, 100000 ],
	      slide: function( event, ui ) {
	        $( "#price" ).val( "₩" + ui.values[0] + " ~ ₩" + ui.values[1] );
	      }
	    });
    $( "#price" ).val( "₩" + $( "#slider-range" ).slider( "values", 0 ) +
      " ~ ₩" + $( "#slider-range" ).slider( "values", 1 ) ); 
	
    
	$(document).ready(function(){
		
		let actionForm = $("#actionForm");
		
		$(".page-item a").on("click", function(e){
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		let lowPrice =0;	
		let highPrice =0;	
		
		$("#slider-range").on("slide", function( event, ui ) {    
			lowPrice = ui.values[0];
			highPrice = ui.values[1];
			console.log("lowPrice >>> ", lowPrice);
		  	console.log("highPrice >>> ", highPrice);  
		  	let roomPrices = document.getElementsByClassName('roomPrice');
			for(var i = 0; i < roomPrices.length; i++){
				let roomPrice = roomPrices[i].innerText;
				roomPrice = roomPrice.replace(/,/g, "");
				roomPrice = roomPrice.replace(/원/g, "");
				roomPrice = parseInt(roomPrice);
				console.log(roomPrice);
				if(roomPrice < lowPrice || roomPrice > highPrice){
					//roomPrices[i].closest(".hotelContent, selectable").style.display = "none";
					roomPrices[i].closest(".hotelContent, selectable_price").classList.remove("selectable_price");
				}else{
					//roomPrices[i].closest(".hotelContent").style.display = "flex";
					roomPrices[i].closest(".hotelContent").classList.add("selectable_price");
				}
			}  	
		});
		
	  	
			let optionFilters = $("input[name='option']");
			
			
			console.log("optionFilters >>>> ", optionFilters);
			
			optionFilters.on("change", function () {
				let selectedFilters = $("input[name='option']:checked");
				console.log("selectedFilters >>>> ", selectedFilters);
				let filter_cond_spans = $(".selectable > .filter_cond");
				
				if(selectedFilters.length == 0){
					filter_cond_spans.parent().show();
				}else{
					$.each(selectedFilters, function (index, item) {
						let value = $(item).val().toLowerCase();
						console.log("value >>>>>>>> ", value);
						$.each(filter_cond_spans, function (index, item) {
							if($(this).text().toLowerCase().indexOf(value) > -1){
								$(this).parent().show().addClass('selectable_option');
							}else{
								$(this).parent().hide().removeClass('selectable_option');
							}
							
						});
					});
				}
					
				
			});
		
	});	
	
</script>
