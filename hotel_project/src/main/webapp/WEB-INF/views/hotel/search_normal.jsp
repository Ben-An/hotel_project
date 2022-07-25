<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<style>
	.filtered {
		display: none !important; 
	}
	
</style>

<%@include file="../includes/header.jsp"%>


<div style="display: flex; flex-direction: row; margin:30px 0 30px;">
	<%@include file="../includes/search_filter.jsp"%>
	
	<div style="margin-left: 20px;" id="contentList">
	<%-- <c:set var="hotelNo" value="0"/> --%>
		<c:forEach var="item" items="${list }">
			<%-- <c:set var="hotelNo" value="${hotelNo+1 }"/>  --%> 
			<a href="/hotel/detail?hotelno=${item.hotelno }&memberNo=${member.memberNo}">
		    <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative hotelContent" style="width: 1000px;">
			    
				    <div class="col-auto d-none d-lg-block">
				    	<img src="${item.hotelFileName }" class="card-img-top" alt="" style="width: 200px; height: 150px; ">
				    </div>
				    <div class="col p-4 d-flex flex-column position-static">
					    <h3 class="mb-0">${item.realhotelName }</h3>
					    <div class="mb-1 text-muted averageGrade">${item.ag }</div>
					    <p class="card-text mb-auto roomPrice" >${item.roomPrice }원</p>
				    </div>  
				    <span class="facility" style="display:none">
				    ${item.hotelno } ${item.state } ${item.buffet == 'T'? 'buffet': '' } ${item.swim == 'T'? 'swim': '' } 
				    ${item.golf == 'T'? 'golf': '' } ${item.pet == 'T'? 'pet': '' } ${item.restaurant == 'T'? 'restaurant': '' } 
				    ${item.fitness == 'T'? 'fitness': '' } ${item.parking == 'T'? 'parking': '' } ${item.wifi == 'T'? 'wifi': '' } 
				    ${item.kitchen == 'T'? 'kitchen': '' } ${item.smoke == 'T'? 'smoke': '' }		
			    	</span>
				
		    </div>
		    </a>
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
				
		$("#slider-range").on("slidechange", function( event, ui ) { 
			filterApply();
		});
	
		//checkbox event
		let optionFilters = $("input[name='option']");
		console.log("optionFilters >>>> ", optionFilters);
		
		optionFilters.on("change", function () {
			filterApply();
		}); 
	});	
	//별점 이벤트
	const drawStar = function(target){
		  $('.star span').css({ width: target.value * 20+"%" });  
		  filterApply();
	}
	
	//filter 조건
	let allHotels = $('.hotelContent '); 
	let roomPrice = 0;
	let lowPrice;
	let highPrice;
	let searchGrade;
	let selectedFilters;
	let facility;
	
	//filter 함수
	const filterApply = function (){
		
		$('.hotelContent ').removeClass("filtered");
		
		lowPrice = $("#slider-range").children('span')[0].style.left;
		lowPrice = lowPrice.replace('%', "");
		lowPrice = parseInt(lowPrice) * 1000;
	 	highPrice = $("#slider-range").children('span')[1].style.left;
	 	highPrice = highPrice.replace('%', "");
	 	highPrice = parseInt(highPrice) * 1000;
		console.log("lowPrice >>> ", lowPrice);
	  	console.log("highPrice >>> ", highPrice);  
	  	let searchGrade = document.getElementById("grade").value;
	  	console.log("searchGrade >>>>>>>>>>> ", searchGrade);
	  	let selectedFilters = $("input[name='option']:checked");
		console.log("selectedFilters >>>> ", selectedFilters);
		let leng = selectedFilters.length;
		console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");
		for(let i = 0; i < allHotels.length; i++) {
			let hotel = allHotels[i];
			// 가격
			roomPrice =  hotel.querySelector('.roomPrice').innerText;
			roomPrice = roomPrice.replace(/,/g, "");
			roomPrice = roomPrice.replace(/원/g, "");
			roomPrice = parseInt(roomPrice);
			console.log("roomPrice >>> ", roomPrice);
			// 별점
			averageGrade = hotel.querySelector('.averageGrade').innerText;
			console.log("averageGrade >>> ", averageGrade);
			//시설
			facility = hotel.querySelector(".facility").innerText;
			console.log("facility >>> ", facility);
			selectedFilters.length
			
			
			if(roomPrice < lowPrice || roomPrice > highPrice){
				hotel.classList.add("filtered");
			}else if(averageGrade < searchGrade){
				hotel.classList.add("filtered");
			}else if(leng > 0){
				for(let i = 0; i < leng; i++){
					console.log("selectedFilters[i] >>>>>>>> ", selectedFilters[i].value);
					let value = selectedFilters[i].value.toLowerCase();
					console.log("value >>>>>>>> ", value);
					if(facility.indexOf(value) < 0 ){
						hotel.classList.add("filtered");
						break;
					}
				}
			
			}else{
				hotel.classList.remove("filtered");
			} 
		}
		
		
		
		
	}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	/* 	
		if(roomPrices != null){
			for(var i = 0; i < roomPrices.length; i++){
				let roomPrice = roomPrices[i].innerText;
				console.log("lowPrice >>> ", lowPrice);
			  	console.log("highPrice >>> ", highPrice); 
				roomPrice = roomPrice.replace(/,/g, "");
				roomPrice = roomPrice.replace(/원/g, "");
				roomPrice = parseInt(roomPrice);
				
				if(roomPrice < lowPrice || roomPrice > highPrice){
					roomPrices[i].closest(".hotelContent").style.display = "none";
				}else{
					//roomPrices[i].closest(".hotelContent").style.display = "flex";
					if(averageGrades != null){
						//for(var i = 0; i < ags.length; i++){
							let ag = averageGrades[i].innerText;
							//console.log(ag);
							if(ag < searchGrade){
								averageGrades[i].closest(".hotelContent").style.display = "none";
							}else{
								//ags[i].closest(".hotelContent").style.display = "flex";
								if(selectedFilters != null){
									if(selectedFilters.length == 0){
										//filter_cond_spans.parent().show();	
										filter_cond_spans.parent().style.display = "flex";	
									}else{
										$.each(selectedFilters, function (index, item) {
											let value = $(item).val().toLowerCase();
											console.log("value >>>>>>>> ", value);
											$.each(filter_cond_spans, function (index, item) {
												if($(this).text().toLowerCase().indexOf(value) > -1){
													//$(this).parent().show();
													$(this).parent().style.display = "flex";
												}else{
													//$(this).parent().hide();
													$(this).parent().style.display = "none";
												}
												
											});
										});
									}
								}
								
							}
						//}
					}
				}
			}  	
		} */
		/* 
		if(selectedFilters != null){
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
		} */
		
		
    	//paging
		/* let actionForm = $("#actionForm");
		
		$(".page-item a").on("click", function(e){
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		}); 
		
	}*/
	
</script>
