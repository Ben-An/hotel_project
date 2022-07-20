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
		<h3>숙소 등록</h3>
		<hr>
		<div class="container">
			<%-- <div class="row">
				<c:forEach var="item" items="${myPageList }">
					<div class="col-12 col-md-5 col-lg-3 ">
						<div class="card">
							<img src="${item.hotelFileName }" class="card-img-top" alt="" style="height: 250px ">
							<div class="card-body">
								<span class="badge bg-primary "	style="border-radius: 10px; margin-bottom: 10px;">추천</span>
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
                    				<label>숙소 대표 이미지</label>
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
							<label>숙소 이름</label>
						</div>
						<div class="form_section_content">
							<input name="hotelName">
						</div>
					</div>
					<div class="form_section">
						<div class="form_section_title">
							<label>대표주소</label>
						</div>
						<div class="form_section_content">
							<input name="mainAddress" id="md" type="text">
						</div>
					</div>
					<div class="form_section">
						<div class="form_section_title">
							<label>상세주소</label>
						</div>
						<div class="form_section_content">
							<input name="address">
						</div>
					</div>
					<div class="form_section">
						<div class="form_section_title">
							<label>대표전화번호</label>
						</div>
						<div class="form_section_content">
							<input name="hotelPhoneNo">
						</div>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="buffet_exist">조식 포함 </label>
						<div></div>
						<input type="radio" class="btn-check" name="buffet"
							id="buffet_yes" value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="buffet_yes">예</label>
						<input type="radio" class="btn-check" name="buffet" id="buffet_no"
							value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="buffet_no">아니요</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="swim_exist">수영장 포함</label>
						<div></div>
						<input type="radio" class="btn-check" name="swim" id="swim_yes"
							value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="swim_yes">예</label>
						<input type="radio" class="btn-check" name="swim" id="swim_no"
							value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="swim_no">아니요</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="golf_exist">골프장 포함</label>
						<div></div>
						<input type="radio" class="btn-check" name="golf" id="golf_yes"
							value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="golf_yes">예</label>
						<input type="radio" class="btn-check" name="golf" id="golf_no"
							value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="golf_no">아니요</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="pet_exist">반려동물시설 포함</label>
						<div></div>
						<input type="radio" class="btn-check" name="pet" id="pet_yes"
							value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="pet_yes">예</label>
						<input type="radio" class="btn-check" name="pet" id="pet_no"
							value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="pet_no">아니요</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="restaurant_exist">레스토랑 포함</label>
						<div></div>
						<input type="radio" class="btn-check" name="restaurant"
							id="restaurant_yes" value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="restaurant_yes">예</label>
						<input type="radio" class="btn-check" name="restaurant"
							id="restaurant_no" value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="restaurant_no">아니요</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="fitness_exist">헬스장 포함</label>
						<div></div>
						<input type="radio" class="btn-check" name="fitness"
							id="fitness_yes" value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="fitness_yes">예</label>
						<input type="radio" class="btn-check" name="fitness"
							id="fitness_no" value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="fitness_no">아니요</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="parking_exist">주차장 포함</label>
						<div></div>
						<input type="radio" class="btn-check" name="parking"
							id="parking_yes" value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="parking_yes">예</label>
						<input type="radio" class="btn-check" name="parking"
							id="parking_no" value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="parking_no">아니요</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="wifi_exist">와이파이 포함</label>
						<div></div>
						<input type="radio" class="btn-check" name="wifi" id="wifi_yes"
							value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="wifi_yes">예</label>
						<input type="radio" class="btn-check" name="wifi" id="wifi_no"
							value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="wifi_no">아니요</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="kitchen_exist">취식 포함</label>
						<div></div>
						<input type="radio" class="btn-check" name="kitchen"
							id="kitchen_yes" value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="kitchen_yes">예</label>
						<input type="radio" class="btn-check" name="kitchen"
							id="kitchen_no" value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="kitchen_no">아니요</label>
					</div>
					<div class="col-md-12 mt-3 gender_wrap">
						<label class="mb-3 mr-1" for="smoke_exist">금연방 포함</label>
						<div></div>
						<input type="radio" class="btn-check" name="smoke" id="smoke_yes"
							value='t'> <label
							class="btn btn-sm btn-outline-secondary" for="smoke_yes">예</label>
						<input type="radio" class="btn-check" name="smoke" id="smoke_no"
							value='f'> <label
							class="btn btn-sm btn-outline-secondary" for="smoke_no">아니요</label>
					</div>
				</form>
				<div class="btn_section">
					<button id="enrollBtn" class="btn enroll_btn">등 록</button>
					<button id="cancelBtn" class="btn">취 소</button>
				</div>
			</div>
		</div>
	</div>
</div>


<%@include file="../includes/footer.jsp"%>

<script>
	let enrollForm = $("#enrollForm")

	/* 취소 버튼 */
	$("#cancelBtn").click(function() {

		location.href = "/admin/main"

	});

	/* 숙소 등록 버튼 */
	$("#enrollBtn").on("click", function(e) {

		e.preventDefault();

		enrollForm.submit();

	});
	
	/* 이미지 업로드 */
	$("input[type='file']").on("change", function(e){
		
		/* 이미지 존재시 삭제 */
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
	    		alert("이미지 파일이 아닙니다.");
	    	}
		});
	});
	
	/* 이미지 형식 체크*/
	let regex = new RegExp("(.*?)\.(jpg|png)$");
	let maxSize = 1048576; //1MB	
	
	function fileCheck(fileName, fileSize){

		if(fileSize >= maxSize){
			//alert("파일 사이즈 초과");
			return false;
		}
			  
		if(!regex.test(fileName)){
			//alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		
		return true;		
		
	}
	
	/* 이미지 출력 */
	function showUploadImage(uploadResultArr){
		/* 전달받은 데이터 검증 */
		if(!uploadResultArr || uploadResultArr.length == 0){return}
		
		let uploadResult = $("#uploadResult");
		let obj = uploadResultArr[0];
		let str = "";
		let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.hotelFileName);
		 
		console.log("파일경로"+fileCallPath);
		console.log("파일경로"+obj.hotelFileName);
		str += "<div id='result_card'>";
		str += "<img src='/hotel/display?fileName=" + fileCallPath +"'>";
		str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
		str += "<input type='hidden' name='imageList[0].hotelFileName' value='"+ obj.hotelFileName +"'>";
		str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
		str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";		
		str += "</div>";		
		
   		uploadResult.append(str);  

	}
	/* 이미지 삭제 버튼 동작 */
	$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
		
		deleteFile();
		
	});
	/* 파일 삭제 메서드 */
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
				
				alert("파일을 삭제하지 못하였습니다.")
			}
		});
	}
</script>
