<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!-- Bootstrap core CSS -->
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/css/bootstrap.css" rel="stylesheet">

<style>
.myPageContainer {
	margin-top: 100px;
	margin-bottom: 100px;
}

.myPageContainer table {
	text-align: center;
}

.search_input>:nth-child(1) {
	width: 18rem;
}

.search_input>:nth-last-child(2) {
	width: 11rem;
	border: none;
}

.search_input>:nth-last-child(1) {
	width: 65px;
	border: none;
}

.search_input>:nth-last-child(1):hover {
	background: none;
}

.search_input>div div, .search_input>div input, .small_search_input>div div,
	.small_search_input>div input {
	width: 70%;
	margin: auto;
	border: none;
	text-align: left;
}

.search_input>div:hover, .small_search_input>div:hover {
	padding: 10px 0;
	background-color: #FFEBD2;
	border-radius: 110px;
	cursor: pointer;
}

.search_input input, .small_search_input input {
	cursor: default;
	background: transparent;
}

.search_button, .small_search_button {
	width: 45px;
	height: 45px;
	border: none;
	border-radius: 50%;
	background-color: #FF8607;
}

.search_button:hover, .small_search_button:hover {
	background-color: #FF7602;
}

.search_icon, .small_search_icon {
	color: white;
	border-color: #FFFFFF;
}
#result_card img{
		max-width: 90%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
	#result_card {
		position: relative;
	}
	.imgDeleteBtn{
	    position: absolute;
	    top: 0;
	    right: 5%;
	    background-color: #ef7d7d;
	    color: wheat;
	    font-weight: 900;
	    width: 30px;
	    height: 30px;
	    border-radius: 50%;
	    line-height: 26px;
	    text-align: center;
	    border: none;
	    display: block;
	    cursor: pointer;	
	}
</style>

<%@include file="../includes/header.jsp"%>

<div style="width: 60%; margin: auto">
	<div class="myPageContainer">
		<h3>?????? ??????</h3>
		<hr>
		<div class="container">
			<%-- <div class="row">
				<c:forEach var="item" items="${myPageList }">
					<div class="col-12 col-md-5 col-lg-3 ">
						<div class="card">
							<img src="${item.hotelFileName }" class="card-img-top" alt="" style="height: 250px ">
							<div class="card-body">
								<span class="badge bg-primary "	style="border-radius: 10px; margin-bottom: 10px;">??????</span>
								<h5 class="card-title">${item.hotelName }</h5>
								<p>${item.mainAddress }</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div> --%>


			<div class="admin_content_main m-auto">
				<form action="/admin/hotelEnroll" method="post" id="enrollForm">
					<div class="form_section">
					<div class="form_section_title">
                    				<label>?????? ?????? ?????????</label>
                    			</div>
                    			<div class="form_section_content">
									<input type="file" id ="fileItem" name='uploadFile' style="height: 30px;">
									<div id="uploadResult">
										<!-- <div id="result_card">
											<div class="imgDeleteBtn">x</div>
											<img src="/hotel/display?fileName=test.png">
										</div> -->
									</div>
                    			</div>
						<div class="form_section_title">
							<label>?????? ??????</label>
						</div>
						<div class="form_section_content">
							<input name="hotelName">
						</div>
					</div>
					<div class="form_section">
						<div class="form_section_title">
							<label>????????????</label>
						</div>
						<div class="form_section_content">
							<input name="mainAddress" id="md" type="text">
						</div>
					</div>
					<div class="form_section">
						<div class="form_section_title">
							<label>????????????</label>
						</div>
						<div class="form_section_content">
							<input name="address">
						</div>
					</div>
					<div class="form_section">
						<div class="form_section_title">
							<label>??????????????????</label>
						</div>
						<div class="form_section_content">
							<input name="hotelPhoneNo">
						</div>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="buffet_exist">?????? ?????? </label>
						<div></div>
						<input type="radio" class="btn-check" name="buffet"
							id="buffet_yes" value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="buffet_yes">???</label>
						<input type="radio" class="btn-check" name="buffet" id="buffet_no"
							value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="buffet_no">?????????</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="swim_exist">????????? ??????</label>
						<div></div>
						<input type="radio" class="btn-check" name="swim" id="swim_yes"
							value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="swim_yes">???</label>
						<input type="radio" class="btn-check" name="swim" id="swim_no"
							value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="swim_no">?????????</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="golf_exist">????????? ??????</label>
						<div></div>
						<input type="radio" class="btn-check" name="golf" id="golf_yes"
							value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="golf_yes">???</label>
						<input type="radio" class="btn-check" name="golf" id="golf_no"
							value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="golf_no">?????????</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="pet_exist">?????????????????? ??????</label>
						<div></div>
						<input type="radio" class="btn-check" name="pet" id="pet_yes"
							value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="pet_yes">???</label>
						<input type="radio" class="btn-check" name="pet" id="pet_no"
							value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="pet_no">?????????</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="restaurant_exist">???????????? ??????</label>
						<div></div>
						<input type="radio" class="btn-check" name="restaurant"
							id="restaurant_yes" value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="restaurant_yes">???</label>
						<input type="radio" class="btn-check" name="restaurant"
							id="restaurant_no" value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="restaurant_no">?????????</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="fitness_exist">????????? ??????</label>
						<div></div>
						<input type="radio" class="btn-check" name="fitness"
							id="fitness_yes" value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="fitness_yes">???</label>
						<input type="radio" class="btn-check" name="fitness"
							id="fitness_no" value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="fitness_no">?????????</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="parking_exist">????????? ??????</label>
						<div></div>
						<input type="radio" class="btn-check" name="parking"
							id="parking_yes" value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="parking_yes">???</label>
						<input type="radio" class="btn-check" name="parking"
							id="parking_no" value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="parking_no">?????????</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="wifi_exist">???????????? ??????</label>
						<div></div>
						<input type="radio" class="btn-check" name="wifi" id="wifi_yes"
							value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="wifi_yes">???</label>
						<input type="radio" class="btn-check" name="wifi" id="wifi_no"
							value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="wifi_no">?????????</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="kitchen_exist">?????? ??????</label>
						<div></div>
						<input type="radio" class="btn-check" name="kitchen"
							id="kitchen_yes" value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="kitchen_yes">???</label>
						<input type="radio" class="btn-check" name="kitchen"
							id="kitchen_no" value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="kitchen_no">?????????</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="smoke_exist">????????? ??????</label>
						<div></div>
						<input type="radio" class="btn-check" name="smoke" id="smoke_yes"
							value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="smoke_yes">???</label>
						<input type="radio" class="btn-check" name="smoke" id="smoke_no"
							value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="smoke_no">?????????</label>
					</div>
				</form>
				<div class="btn_section">
					<button id="enrollBtn" class="btn enroll_btn">??? ???</button>
					<button id="cancelBtn" class="btn">??? ???</button>
				</div>
			</div>
		</div>
	</div>
</div>


<%@include file="../includes/footer.jsp"%>

<script>
	let enrollForm = $("#enrollForm")

	/* ?????? ?????? */
	$("#cancelBtn").click(function() {

		location.href = "/admin/main"

	});

	/* ?????? ?????? ?????? */
	$("#enrollBtn").on("click", function(e) {

		e.preventDefault();

		enrollForm.submit();

	});
	
	/* ????????? ????????? */
	$("input[type='file']").on("change", function(e){
		
		/* ????????? ????????? ?????? */
		if($(".imgDeleteBtn").length > 0){
			deleteFile();
		}
		
		let formData = new FormData();
		let fileInput = $('input[name="uploadFile"]');
		let fileList = fileInput[0].files;
		let fileObj = fileList[0];
		
		if(!fileCheck(fileObj.name, fileObj.size)){
			return false;
		} 
		
		//alert(fileObj.name);
		formData.append("uploadFile", fileObj);
		
		$.ajax({
			url: '/admin/uploadAjaxAction',
	    	processData : false,
	    	contentType : false,
	    	data : formData,
	    	type : 'POST',
	    	dataType : 'json',
	    	success : function(result){
	    		console.log(result);
	    		showUploadImage(result);
	    	},
	    	error : function(result){
	    		alert("????????? ????????? ????????????.");
	    	}
		});
	});
	
	/* ????????? ?????? ??????*/
	let regex = new RegExp("(.*?)\.(jpg|png)$");
	let maxSize = 1048576; //1MB	
	
	function fileCheck(fileName, fileSize){

		if(fileSize >= maxSize){
			//alert("?????? ????????? ??????");
			return false;
		}
			  
		if(!regex.test(fileName)){
			//alert("?????? ????????? ????????? ???????????? ??? ????????????.");
			return false;
		}
		
		return true;		
		
	}
	
	/* ????????? ?????? */
	function showUploadImage(uploadResultArr){
		/* ???????????? ????????? ?????? */
		if(!uploadResultArr || uploadResultArr.length == 0){return}
		
		let uploadResult = $("#uploadResult");
		let obj = uploadResultArr[0];
		let str = "";
		let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.hotelFileName);
		 
		console.log("????????????"+fileCallPath);
		console.log("????????????"+obj.hotelFileName);
		str += "<div id='result_card'>";
		str += "<img src='/hotel/display?fileName=" + fileCallPath +"'>";
		str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
		str += "<input type='hidden' name='imageList[0].hotelFileName' value='"+ obj.hotelFileName +"'>";
		str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
		str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";		
		str += "</div>";		
		
   		uploadResult.append(str);  

	}
	/* ????????? ?????? ?????? ?????? */
	$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
		
		deleteFile();
		
	});
	/* ?????? ?????? ????????? */
	function deleteFile(){
		
		let targetFile = $(".imgDeleteBtn").data("file");
		let targetDiv = $("#result_card");

		$.ajax({
			url: '/admin/deleteFile',
			data : {fileName : targetFile},
			dataType : 'text',
			type : 'POST',
			success : function(result){
				console.log(result);
				
				targetDiv.remove();
				$("input[type='file']").val("");
				
			},
			error : function(result){
				console.log(result);
				
				alert("????????? ???????????? ??????????????????.")
			}
		});
	}
</script>
