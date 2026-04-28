<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<style>
/* ===== Add Hotel Form ===== */
.add-hotel-wrap {
	max-width: 720px;
	margin: var(--space-3xl) auto;
	padding: 0 var(--space-lg);
}

.add-hotel-header {
	margin-bottom: var(--space-2xl);
}

.add-hotel-header h2 {
	font-weight: 700;
	font-size: 1.75rem;
	color: var(--color-gray-900);
	margin: 0;
}

.add-hotel-header p {
	color: var(--color-gray-500);
	font-size: 0.9rem;
	margin-top: var(--space-sm);
}

/* Card sections */
.form-card {
	background: var(--color-white);
	border: 1px solid var(--color-gray-300);
	border-radius: var(--radius-lg);
	padding: var(--space-xl);
	margin-bottom: var(--space-lg);
	transition: box-shadow var(--transition-fast);
}

.form-card:hover {
	box-shadow: var(--shadow-sm);
}

.form-card-title {
	font-weight: 700;
	font-size: 1.1rem;
	color: var(--color-gray-900);
	margin-bottom: var(--space-lg);
	padding-bottom: var(--space-md);
	border-bottom: 2px solid var(--color-gray-300);
	display: flex;
	align-items: center;
	gap: var(--space-sm);
}

.form-card-title i {
	color: var(--color-primary);
}

/* Form fields */
.field-group {
	margin-bottom: var(--space-lg);
}

.field-group:last-child {
	margin-bottom: 0;
}

.field-group label {
	display: block;
	font-weight: 600;
	font-size: 0.875rem;
	color: var(--color-gray-700);
	margin-bottom: var(--space-sm);
}

.field-group input[type="text"],
.field-group input[type="tel"] {
	width: 100%;
	padding: 0.75rem 1rem;
	border: 2px solid var(--color-gray-300);
	border-radius: var(--radius-md);
	font-size: 0.9rem;
	color: var(--color-gray-900);
	transition: border-color var(--transition-fast), box-shadow var(--transition-fast);
	background: var(--color-white);
}

.field-group input[type="text"]:focus,
.field-group input[type="tel"]:focus {
	outline: none;
	border-color: var(--color-primary);
	box-shadow: 0 0 0 3px rgba(var(--color-primary-rgb), 0.15);
}

.field-group input[type="text"]::placeholder,
.field-group input[type="tel"]::placeholder {
	color: var(--color-gray-500);
}

/* Address search input + button */
.input-with-btn {
	display: flex;
	gap: var(--space-sm);
}

.input-with-btn input[type="text"] {
	flex: 1;
}

.addr-search-btn {
	flex-shrink: 0;
	padding: 0.75rem 1.25rem;
	background: var(--color-primary);
	color: var(--color-white);
	border: 2px solid var(--color-primary);
	border-radius: var(--radius-md);
	font-size: 0.875rem;
	font-weight: 600;
	cursor: pointer;
	transition: background var(--transition-fast);
	white-space: nowrap;
	display: flex;
	align-items: center;
	gap: var(--space-xs);
}

.addr-search-btn:hover {
	background: var(--color-primary-hover);
	border-color: var(--color-primary-hover);
}

/* Image upload */
.image-upload-area {
	border: 2px dashed var(--color-gray-300);
	border-radius: var(--radius-lg);
	padding: var(--space-xl);
	text-align: center;
	cursor: pointer;
	transition: all var(--transition-fast);
	background: var(--color-gray-100);
	position: relative;
}

.image-upload-area:hover {
	border-color: var(--color-primary);
	background: var(--color-primary-light);
}

.image-upload-area i {
	font-size: 2rem;
	color: var(--color-gray-500);
	display: block;
	margin-bottom: var(--space-sm);
}

.image-upload-area span {
	font-size: 0.9rem;
	color: var(--color-gray-500);
}

.image-upload-area small {
	display: block;
	color: var(--color-gray-500);
	font-size: 0.8rem;
	margin-top: var(--space-xs);
}

.image-upload-area input[type="file"] {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	opacity: 0;
	cursor: pointer;
}

#uploadResult {
	margin-top: var(--space-md);
	display: flex;
	flex-wrap: wrap;
	gap: var(--space-sm);
}

.result_card {
	position: relative;
	display: inline-block;
	border-radius: var(--radius-md);
	overflow: hidden;
	border: 1px solid var(--color-gray-300);
}

.result_card img {
	width: 120px;
	height: 120px;
	display: block;
	object-fit: cover;
}

.imgDeleteBtn {
	position: absolute;
	top: var(--space-sm);
	right: var(--space-sm);
	background-color: var(--color-danger);
	color: var(--color-white);
	font-weight: 700;
	width: 28px;
	height: 28px;
	border-radius: 50%;
	line-height: 28px;
	text-align: center;
	border: none;
	cursor: pointer;
	font-size: 0.8rem;
	transition: background-color var(--transition-fast);
}

.imgDeleteBtn:hover {
	background-color: #c82333;
}

/* Amenity grid */
.amenity-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
	gap: var(--space-md);
}

.amenity-item {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0.75rem 1rem;
	border: 2px solid var(--color-gray-300);
	border-radius: var(--radius-md);
	transition: all var(--transition-fast);
	cursor: pointer;
	user-select: none;
}

.amenity-item:hover {
	border-color: var(--color-primary);
	background: var(--color-primary-light);
}

.amenity-item.selected {
	border-color: var(--color-primary);
	background: var(--color-primary-light);
}

.amenity-item .amenity-label {
	display: flex;
	align-items: center;
	gap: var(--space-sm);
	font-weight: 500;
	font-size: 0.9rem;
	color: var(--color-gray-700);
}

.amenity-item .amenity-label i {
	font-size: 1.1rem;
	color: var(--color-gray-500);
	width: 20px;
	text-align: center;
}

.amenity-item.selected .amenity-label i {
	color: var(--color-primary);
}

.amenity-toggle {
	display: flex;
	gap: var(--space-xs);
}

.amenity-toggle .toggle-btn {
	padding: 0.25rem 0.75rem;
	border: 1.5px solid var(--color-gray-300);
	border-radius: var(--radius-full);
	font-size: 0.8rem;
	font-weight: 600;
	background: var(--color-white);
	color: var(--color-gray-500);
	cursor: pointer;
	transition: all var(--transition-fast);
}

.amenity-toggle .toggle-btn.active {
	background: var(--color-primary);
	border-color: var(--color-primary);
	color: var(--color-white);
}

.amenity-toggle .toggle-btn:hover:not(.active) {
	border-color: var(--color-primary);
	color: var(--color-primary);
}

/* Form actions */
.form-actions {
	display: flex;
	justify-content: flex-end;
	gap: var(--space-md);
	margin-top: var(--space-xl);
	padding-top: var(--space-lg);
}

.form-actions .btn-cancel {
	padding: 0.75rem 2rem;
	border: 2px solid var(--color-gray-300);
	border-radius: var(--radius-full);
	background: var(--color-white);
	color: var(--color-gray-700);
	font-weight: 600;
	font-size: 0.9rem;
	cursor: pointer;
	transition: all var(--transition-fast);
}

.form-actions .btn-cancel:hover {
	border-color: var(--color-gray-500);
	color: var(--color-gray-900);
}

.form-actions .btn-submit {
	padding: 0.75rem 2.5rem;
	border: none;
	border-radius: var(--radius-full);
	background: var(--color-primary);
	color: var(--color-white);
	font-weight: 600;
	font-size: 0.9rem;
	cursor: pointer;
	transition: all var(--transition-fast);
}

.form-actions .btn-submit:hover {
	background: var(--color-primary-hover);
	transform: translateY(-1px);
	box-shadow: var(--shadow-md);
}

@media (max-width: 576px) {
	.amenity-grid {
		grid-template-columns: 1fr;
	}
	.form-actions {
		flex-direction: column-reverse;
	}
	.form-actions .btn-cancel,
	.form-actions .btn-submit {
		width: 100%;
		text-align: center;
	}
}
</style>

<%@include file="../includes/header.jsp"%>

<div class="add-hotel-wrap">
	<div class="add-hotel-header">
		<h2>숙소 등록</h2>
		<p>새로운 숙소 정보를 입력해주세요.</p>
	</div>

	<c:if test="${not empty error_msg}">
		<div style="background:#fff0f0; border:1px solid #e74c3c; border-radius:8px; padding:12px 16px; margin-bottom:16px; color:#c0392b; font-size:0.9rem;">
			<i class="bi bi-exclamation-triangle"></i> ${error_msg}
		</div>
	</c:if>

	<form action="/admin/hotelEnroll" method="post" id="enrollForm" enctype="multipart/form-data">

		<!-- 대표 이미지 -->
		<div class="form-card">
			<div class="form-card-title">
				<i class="bi bi-image"></i> 대표 이미지
			</div>
			<div class="image-upload-area" id="imageDropArea">
				<i class="bi bi-cloud-arrow-up"></i>
				<span>클릭하여 이미지를 업로드하세요</span>
				<small>JPG, PNG / 최대 20MB / 최대 5장</small>
				<input type="file" id="fileItem" accept=".jpg,.png" multiple>
			</div>
			<div id="uploadResult"></div>
		</div>

		<!-- 기본 정보 -->
		<div class="form-card">
			<div class="form-card-title">
				<i class="bi bi-building"></i> 기본 정보
			</div>
			<div class="field-group">
				<label for="hotelName">숙소 이름</label>
				<input type="text" name="hotelName" id="hotelName" placeholder="숙소 이름을 입력하세요">
			</div>
			<div class="field-group">
				<label for="zipcode">우편번호</label>
				<div class="input-with-btn">
					<input type="text" name="zipcode" id="zipcode" placeholder="우편번호" readonly>
					<button type="button" class="addr-search-btn" id="addrSearchBtn">
						<i class="bi bi-search"></i> 주소 검색
					</button>
				</div>
			</div>
			<div class="field-group">
				<label for="md">대표주소</label>
				<input type="text" name="mainAddress" id="md" placeholder="주소 검색 시 자동 입력됩니다" readonly>
			</div>
			<div class="field-group">
				<label for="address">상세주소</label>
				<input type="text" name="address" id="address" placeholder="상세주소를 입력하세요">
			</div>
			<div class="field-group">
				<label for="hotelPhoneNo">대표 전화번호</label>
				<input type="tel" name="hotelPhoneNo" id="hotelPhoneNo" placeholder="000-0000-0000">
			</div>
		</div>

		<!-- 편의시설 -->
		<div class="form-card">
			<div class="form-card-title">
				<i class="bi bi-stars"></i> 편의시설
			</div>
			<div class="amenity-grid">
				<div class="amenity-item" data-name="buffet">
					<div class="amenity-label">
						<i class="bi bi-cup-hot"></i> 조식
					</div>
					<div class="amenity-toggle">
						<button type="button" class="toggle-btn" data-value="t">예</button>
						<button type="button" class="toggle-btn" data-value="f">아니요</button>
					</div>
					<input type="hidden" name="buffet" value="">
				</div>
				<div class="amenity-item" data-name="swim">
					<div class="amenity-label">
						<i class="bi bi-water"></i> 수영장
					</div>
					<div class="amenity-toggle">
						<button type="button" class="toggle-btn" data-value="t">예</button>
						<button type="button" class="toggle-btn" data-value="f">아니요</button>
					</div>
					<input type="hidden" name="swim" value="">
				</div>
				<div class="amenity-item" data-name="golf">
					<div class="amenity-label">
						<i class="bi bi-flag"></i> 골프장
					</div>
					<div class="amenity-toggle">
						<button type="button" class="toggle-btn" data-value="t">예</button>
						<button type="button" class="toggle-btn" data-value="f">아니요</button>
					</div>
					<input type="hidden" name="golf" value="">
				</div>
				<div class="amenity-item" data-name="pet">
					<div class="amenity-label">
						<i class="bi bi-heart"></i> 반려동물
					</div>
					<div class="amenity-toggle">
						<button type="button" class="toggle-btn" data-value="t">예</button>
						<button type="button" class="toggle-btn" data-value="f">아니요</button>
					</div>
					<input type="hidden" name="pet" value="">
				</div>
				<div class="amenity-item" data-name="restaurant">
					<div class="amenity-label">
						<i class="bi bi-shop"></i> 레스토랑
					</div>
					<div class="amenity-toggle">
						<button type="button" class="toggle-btn" data-value="t">예</button>
						<button type="button" class="toggle-btn" data-value="f">아니요</button>
					</div>
					<input type="hidden" name="restaurant" value="">
				</div>
				<div class="amenity-item" data-name="fitness">
					<div class="amenity-label">
						<i class="bi bi-bicycle"></i> 헬스장
					</div>
					<div class="amenity-toggle">
						<button type="button" class="toggle-btn" data-value="t">예</button>
						<button type="button" class="toggle-btn" data-value="f">아니요</button>
					</div>
					<input type="hidden" name="fitness" value="">
				</div>
				<div class="amenity-item" data-name="parking">
					<div class="amenity-label">
						<i class="bi bi-p-circle"></i> 주차장
					</div>
					<div class="amenity-toggle">
						<button type="button" class="toggle-btn" data-value="t">예</button>
						<button type="button" class="toggle-btn" data-value="f">아니요</button>
					</div>
					<input type="hidden" name="parking" value="">
				</div>
				<div class="amenity-item" data-name="wifi">
					<div class="amenity-label">
						<i class="bi bi-wifi"></i> 와이파이
					</div>
					<div class="amenity-toggle">
						<button type="button" class="toggle-btn" data-value="t">예</button>
						<button type="button" class="toggle-btn" data-value="f">아니요</button>
					</div>
					<input type="hidden" name="wifi" value="">
				</div>
				<div class="amenity-item" data-name="kitchen">
					<div class="amenity-label">
						<i class="bi bi-egg-fried"></i> 취사
					</div>
					<div class="amenity-toggle">
						<button type="button" class="toggle-btn" data-value="t">예</button>
						<button type="button" class="toggle-btn" data-value="f">아니요</button>
					</div>
					<input type="hidden" name="kitchen" value="">
				</div>
				<div class="amenity-item" data-name="smoke">
					<div class="amenity-label">
						<i class="bi bi-slash-circle"></i> 금연방
					</div>
					<div class="amenity-toggle">
						<button type="button" class="toggle-btn" data-value="t">예</button>
						<button type="button" class="toggle-btn" data-value="f">아니요</button>
					</div>
					<input type="hidden" name="smoke" value="">
				</div>
			</div>
		</div>

	</form>

	<!-- 버튼 영역 -->
	<div class="form-actions">
		<button id="cancelBtn" class="btn-cancel">취소</button>
		<button id="enrollBtn" class="btn-submit">숙소 등록</button>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	let enrollForm = $("#enrollForm");

	/* 주소 검색 (Daum Postcode API) */
	$("#addrSearchBtn").on("click", function() {
		new daum.Postcode({
			oncomplete: function(data) {
				$("#zipcode").val(data.zonecode);
				$("#md").val(data.sido + ' ' + data.sigungu);
				$("#address").val(data.roadAddress || data.jibunAddress);
				$("#address").focus();
			}
		}).open();
	});

	/* 취소 버튼 */
	$("#cancelBtn").click(function() {
		location.href = "/admin/main";
	});

	/* 숙소 등록 버튼 */
	$("#enrollBtn").on("click", function(e) {
		e.preventDefault();

		// 기존 동적 file input 제거
		$(".dynamic-file-input").remove();

		// selectedFiles를 hidden file input으로 추가
		for (let i = 0; i < selectedFiles.length; i++) {
			let dt = new DataTransfer();
			dt.items.add(selectedFiles[i]);
			let input = $("<input>").attr({
				type: "file",
				name: "uploadFile",
				class: "dynamic-file-input",
				style: "display:none"
			})[0];
			input.files = dt.files;
			$("#enrollForm").append(input);
		}

		enrollForm.submit();
	});

	/* 편의시설 토글 버튼 */
	$(".amenity-toggle .toggle-btn").on("click", function() {
		let $item = $(this).closest(".amenity-item");
		let val = $(this).data("value");

		// 같은 그룹의 버튼 초기화
		$item.find(".toggle-btn").removeClass("active");
		$(this).addClass("active");

		// hidden input에 값 설정
		$item.find("input[type='hidden']").val(val);

		// 선택 상태 표시
		if (val === 't') {
			$item.addClass("selected");
		} else {
			$item.removeClass("selected");
		}
	});

	/* 이미지 형식 체크 */
	let regex = new RegExp("(.*?)\.(jpg|png)$");
	let maxSize = 20971520; // 20MB
	let maxFiles = 5;
	let selectedFiles = []; // 선택된 파일 관리용 배열

	function fileCheck(fileName, fileSize) {
		if (fileSize >= maxSize) {
			alert("파일 크기는 20MB 이하만 가능합니다.");
			return false;
		}
		if (!regex.test(fileName)) {
			alert("JPG, PNG 파일만 업로드 가능합니다.");
			return false;
		}
		return true;
	}

	/* 이미지 선택 시 클라이언트 미리보기 */
	$("input[type='file']").on("change", function(e) {
		let files = this.files;

		if (!files || files.length === 0) return;

		let totalCount = selectedFiles.length + files.length;
		if (totalCount > maxFiles) {
			alert("이미지는 최대 " + maxFiles + "장까지 업로드 가능합니다.");
			$(this).val("");
			return false;
		}

		for (let i = 0; i < files.length; i++) {
			if (!fileCheck(files[i].name, files[i].size)) {
				$(this).val("");
				return false;
			}
		}

		for (let i = 0; i < files.length; i++) {
			selectedFiles.push(files[i]);
			showPreview(files[i], selectedFiles.length - 1);
		}

		// input 초기화 (같은 파일 재선택 가능하도록)
		$(this).val("");
	});

	/* 클라이언트 미리보기 출력 */
	function showPreview(file, index) {
		let uploadResult = $("#uploadResult");
		let previewUrl = URL.createObjectURL(file);

		let str = "<div class='result_card' data-index='" + index + "'>";
		str += "<img src='" + previewUrl + "'>";
		str += "<div class='imgDeleteBtn'>x</div>";
		str += "</div>";

		uploadResult.append(str);
	}

	/* 미리보기 전체 다시 그리기 */
	function refreshPreviews() {
		$("#uploadResult").empty();
		for (let i = 0; i < selectedFiles.length; i++) {
			showPreview(selectedFiles[i], i);
		}
	}

	/* 이미지 삭제 버튼 동작 */
	$("#uploadResult").on("click", ".imgDeleteBtn", function(e) {
		let index = $(this).closest(".result_card").data("index");
		selectedFiles.splice(index, 1);
		refreshPreviews();
	});
</script>
