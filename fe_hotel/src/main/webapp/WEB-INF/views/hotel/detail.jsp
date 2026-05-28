<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%@include file="../includes/header.jsp"%>

<div class="container py-4">

	<!-- 숙소명 / 주소 -->
	<div class="mb-3">
		<h1 class="fw-bold mb-1"><c:out value="${detailList.realhotelname}"/></h1>
		<p class="text-muted mb-0">
			<i class="bi bi-geo-alt"></i> <c:out value="${detailList.roadaddr}"/>
		</p>
	</div>

	<!-- Image Carousel -->
	<div class="position-relative">
		<div id="carouselExampleControls" class="carousel slide rounded overflow-hidden" data-bs-ride="carousel" style="max-height:400px;">
			<div class="carousel-inner" id="carousel"></div>
			<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
		<c:if test="${member.memberRole == 'MASTER' or member.memberRole == 'ADMIN'}">
		<div class="mt-2 d-flex gap-2">
			<button type="button" class="btn btn-sm btn-outline-hotel" id="btnAddImage"><i class="bi bi-plus-lg"></i> 사진 추가</button>
			<button type="button" class="btn btn-sm btn-outline-danger-hotel" id="btnManageImages"><i class="bi bi-pencil"></i> 사진 관리</button>
		</div>
		</c:if>
	</div>

	<!-- 찜하기 -->
	<div class="mt-3">
		<button type="button" class="btn btn-outline-danger-hotel" id="btnWish" data-wished="false">
			<i class="bi bi-heart" id="wishIcon"></i> <span id="wishLabel">찜하기</span>
		</button>
	</div>

	<!-- 인기 편의 시설/서비스 -->
	<section class="mt-5">
		<div class="d-flex align-items-center justify-content-between">
			<h3 class="section-heading mb-0">인기 편의 시설/서비스</h3>
			<c:if test="${member.memberRole == 'MASTER' or member.memberRole == 'ADMIN'}">
			<button type="button" class="btn btn-sm btn-primary-hotel btn-add-amenity" data-type="POPULAR"><i class="bi bi-plus-lg"></i> 추가</button>
			</c:if>
		</div>
		<div class="d-flex flex-wrap gap-4 mt-3 amenityPopular"></div>
		<a href="#amenities-detail" class="text-decoration-none mt-2 d-inline-block" data-bs-toggle="collapse" style="color:#1a73e8;">모두 보기 &raquo;</a>
	</section>

	<!-- 주요 편의 시설 및 서비스 -->
	<section class="mt-5 collapse" id="amenities-detail">
		<div class="d-flex align-items-center justify-content-between mb-3">
			<h5 class="fw-bold mb-0"><i class="bi bi-building"></i> 주요 편의 시설 및 서비스 <span class="amenityMainCount"></span></h5>
			<c:if test="${member.memberRole == 'MASTER' or member.memberRole == 'ADMIN'}">
			<button type="button" class="btn btn-sm btn-outline-hotel btn-add-amenity" data-type="MAIN"><i class="bi bi-plus-lg"></i> 추가</button>
			</c:if>
		</div>
		<div class="row g-2 amenityMain"></div>
	</section>

	<!-- 집처럼 편안한 숙소 -->
	<section class="mt-4">
		<h5 class="fw-bold mb-3"><i class="bi bi-house-heart"></i> 집처럼 편안한 숙소 (6)</h5>
		<div class="row g-2">
			<div class="col-md-4"><i class="bi bi-check-lg text-success"></i> 냉장고</div>
			<div class="col-md-4"><i class="bi bi-check-lg text-success"></i> 전용 욕실</div>
			<div class="col-md-4"><i class="bi bi-check-lg text-success"></i> 헤어드라이어</div>
			<div class="col-md-4"><i class="bi bi-check-lg text-success"></i> 전기 포트</div>
			<div class="col-md-4"><i class="bi bi-check-lg text-success"></i> 슬리퍼</div>
			<div class="col-md-4"><i class="bi bi-check-lg text-success"></i> 욕실 용품</div>
		</div>
	</section>

	<!-- 이 숙박시설을 좋아하는 이유 -->
	<section class="mt-5">
		<div class="d-flex align-items-center justify-content-between">
			<h3 class="section-heading mb-0">이 숙박시설을 좋아하는 이유</h3>
			<c:if test="${member.memberRole == 'MASTER' or member.memberRole == 'ADMIN'}">
			<button type="button" class="btn btn-sm btn-primary-hotel" id="btnAddReason"><i class="bi bi-plus-lg"></i> 이유 추가</button>
			</c:if>
		</div>
		<div class="row g-4 mt-2 reasonDetail"></div>
	</section>

	<!-- Rooms -->
	<section class="mt-5 mb-5">
		<c:if test="${member.memberRole == 'MASTER' or member.memberRole == 'ADMIN'}">
		<div class="mb-3">
			<button type="button" class="btn btn-sm btn-primary-hotel" id="btnAddRoom"><i class="bi bi-plus-lg"></i> 객실 추가</button>
		</div>
		</c:if>

		<div class="row g-3 roomDetail"></div>
	</section>

	<!-- 이용 후기 (Reviews) -->
	<section class="mt-5 mb-5" id="reviews">
		<div class="d-flex align-items-center justify-content-between mb-3">
			<h3 class="section-heading mb-0">이용 후기 <span class="review-count text-muted fs-6"></span></h3>
			<div class="review-avg fw-bold"></div>
		</div>

		<c:if test="${member != null}">
		<div class="card border shadow-sm mb-4">
			<div class="card-body">
				<h6 class="fw-bold mb-3">후기 작성</h6>
				<div class="mb-2" style="max-width:160px;">
					<label class="form-label mb-1">평점</label>
					<select class="form-select form-select-sm" id="reviewGrade">
						<option value="5">★★★★★ (5)</option>
						<option value="4">★★★★ (4)</option>
						<option value="3">★★★ (3)</option>
						<option value="2">★★ (2)</option>
						<option value="1">★ (1)</option>
					</select>
				</div>
				<div class="mb-2">
					<textarea class="form-control" id="reviewContent" rows="3" maxlength="500"
						placeholder="숙소 이용 경험을 10자 이상 남겨주세요. (최대 500자)"></textarea>
				</div>
				<div class="text-end">
					<button type="button" class="btn btn-primary-hotel btn-sm" id="btnReviewSubmit">
						<i class="bi bi-pencil-square"></i> 등록
					</button>
				</div>
			</div>
		</div>
		</c:if>
		<c:if test="${member == null}">
		<div class="alert alert-light border mb-4">
			후기를 작성하시려면 <a href="/member/login">로그인</a>이 필요합니다.
		</div>
		</c:if>

		<div class="reviewList"></div>
		<nav class="mt-3"><ul class="pagination justify-content-center reviewPaging mb-0"></ul></nav>
	</section>
</div>

<c:if test="${member.memberRole == 'MASTER' or member.memberRole == 'ADMIN'}">
<!-- Image Upload Modal -->
<div class="modal fade" id="imageUploadModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">사진 추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<input type="file" class="form-control" id="imageFileInput" accept="image/*" multiple>
				<div class="mt-2" id="imagePreview"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary-hotel" id="btnUploadImageConfirm">업로드</button>
				<button type="button" class="btn btn-outline-secondary-hotel" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- Image Manage Modal -->
<div class="modal fade" id="imageManageModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">사진 관리</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row g-2" id="imageManageList"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-secondary-hotel" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- Reason Add/Edit Modal -->
<div class="modal fade" id="reasonModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="reasonModalTitle">이유 추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="reasonModalReasonNo">
				<input type="hidden" id="reasonModalImage">
				<div class="mb-3">
					<label class="form-label">제목</label>
					<input type="text" class="form-control" id="reasonModalTitleInput" placeholder="예: 깨끗하고 가치가 있는 음식">
				</div>
				<div class="mb-3">
					<label class="form-label">내용</label>
					<textarea class="form-control" id="reasonModalContent" rows="4" placeholder="이유에 대한 상세 설명"></textarea>
				</div>
				<div class="mb-3">
					<label class="form-label">대표 이미지</label>
					<input type="file" class="form-control" id="reasonModalFile" accept="image/*">
					<div class="mt-2" id="reasonModalPreview"></div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary-hotel" id="btnReasonSave">저장</button>
				<button type="button" class="btn btn-outline-secondary-hotel" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- Room Add/Edit Modal -->
<div class="modal fade" id="roomModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="roomModalTitle">객실 추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="roomModalRoomno">
				<div class="mb-3">
					<label class="form-label">객실명</label>
					<input type="text" class="form-control" id="roomModalName" placeholder="예: 디럭스 더블">
				</div>
				<div class="mb-3">
					<label class="form-label">가격</label>
					<input type="text" class="form-control" id="roomModalPrice" placeholder="예: 150000">
				</div>
				<div class="mb-3">
					<label class="form-label">수용 인원</label>
					<input type="number" class="form-control" id="roomModalBedno" placeholder="예: 2">
				</div>
				<div class="mb-3">
					<label class="form-label">객실 정보</label>
					<textarea class="form-control" id="roomModalInfo" rows="3" placeholder="객실 상세 정보"></textarea>
				</div>
				<div class="row">
					<div class="col-6 mb-3">
						<label class="form-label">체크인</label>
						<input type="date" class="form-control" id="roomModalCheckIn">
					</div>
					<div class="col-6 mb-3">
						<label class="form-label">체크아웃</label>
						<input type="date" class="form-control" id="roomModalCheckOut">
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary-hotel" id="btnRoomSave">저장</button>
				<button type="button" class="btn btn-outline-secondary-hotel" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- Amenity Add/Edit Modal -->
<div class="modal fade" id="amenityModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="amenityModalTitle">편의 시설 추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="amenityModalAmenityNo">
				<div class="mb-3">
					<label class="form-label">시설명</label>
					<input type="text" class="form-control" id="amenityModalName" placeholder="예: 무료 WiFi" maxlength="100">
				</div>
				<div class="mb-3">
					<label class="form-label">아이콘 클래스</label>
					<input type="text" class="form-control" id="amenityModalIcon" placeholder="예: bi-wifi, bi-snow, bi-check-lg" maxlength="100">
					<small class="text-muted">Bootstrap Icons 클래스명 (<a href="https://icons.getbootstrap.com/" target="_blank">목록</a>)</small>
				</div>
				<div class="mb-3">
					<label class="form-label">분류</label>
					<select class="form-select" id="amenityModalType">
						<option value="POPULAR">인기 편의 시설 (POPULAR)</option>
						<option value="MAIN">주요 편의 시설 (MAIN)</option>
					</select>
				</div>
				<div class="mb-3">
					<label class="form-label">정렬 순서</label>
					<input type="number" class="form-control" id="amenityModalOrder" value="0" min="0">
					<small class="text-muted">작은 값이 먼저 표시됩니다</small>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary-hotel" id="btnAmenitySave">저장</button>
				<button type="button" class="btn btn-outline-secondary-hotel" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
</c:if>

<script type="text/javascript" src="/resources/js/util.js"></script>
<script type="text/javascript" src="/resources/js/detail.js"></script>

<script type="text/javascript">

/* (star rating removed - review section no longer used) */

$(document).ready(function() {

	showList();

	function showList() {
		var hotelValue = '<c:out value="${detailList.hotelno}"/>';
		var imageUL = $(".carousel-inner");

		detailService.list({ hotelno: hotelValue }, function(list) {
			var str = "";
			for (var i = 0; i < list.length; i++) {
				str += "<div class='carousel-item'><img src='/hotel/display?fileName=" + list[i].roomfilename +
					"' class='d-block w-100' alt='...' style='height:400px; object-fit:cover;'></div>";
			}
			imageUL.html(str);
			roomService();
			reasonRender();
			amenityRender();
			$("#carousel").find('.carousel-item:first-child').addClass('active');
		});
	}

	function amenityRender() {
		var hotelValue = '<c:out value="${detailList.hotelno}"/>';
		var $popular = $('.amenityPopular');
		var $main = $('.amenityMain');
		var $mainCount = $('.amenityMainCount');

		detailService.amenityList({ hotelno: hotelValue }, function(list) {
			var popularStr = '';
			var mainStr = '';
			var mainCount = 0;

			if (!list || list.length === 0) {
				$popular.html("<div class='text-muted'>등록된 편의 시설이 없습니다.</div>");
				$main.html("<div class='col-12 text-muted'>등록된 편의 시설이 없습니다.</div>");
				$mainCount.text('');
				return;
			}

			for (var i = 0; i < list.length; i++) {
				var a = list[i];
				var name = escapeHtml(a.amenityName);
				var icon = escapeAttr(a.amenityIcon || 'bi-check-lg');
				var adminBtns = '';
				if (isAdmin) {
					adminBtns = "<span class='ms-1 d-inline-flex gap-1 align-middle'>"
						+ "<button type='button' class='btn btn-sm btn-link p-0 btn-edit-amenity' "
						+ "data-amenityno='" + a.amenityNo + "' "
						+ "data-name='" + escapeAttr(a.amenityName) + "' "
						+ "data-icon='" + escapeAttr(a.amenityIcon || '') + "' "
						+ "data-type='" + escapeAttr(a.amenityType) + "' "
						+ "data-order='" + (a.amenityOrder || 0) + "'"
						+ " title='수정'><i class='bi bi-pencil text-secondary'></i></button>"
						+ "<button type='button' class='btn btn-sm btn-link p-0 btn-delete-amenity' "
						+ "data-amenityno='" + a.amenityNo + "' title='삭제'><i class='bi bi-trash text-danger'></i></button>"
						+ "</span>";
				}
				if (a.amenityType === 'MAIN') {
					mainStr += "<div class='col-md-4'><i class='bi " + icon + " text-success'></i> " + name + adminBtns + "</div>";
					mainCount++;
				} else {
					popularStr += "<div class='d-flex align-items-center gap-2'><i class='bi " + icon + " fs-5 text-primary'></i><span>" + name + "</span>" + adminBtns + "</div>";
				}
			}

			var emptyAdminHint = isAdmin ? " '추가' 버튼을 눌러 등록해 주세요." : "";
			$popular.html(popularStr || ("<div class='text-muted'>등록된 인기 편의 시설이 없습니다." + emptyAdminHint + "</div>"));
			$main.html(mainStr || ("<div class='col-12 text-muted'>등록된 주요 편의 시설이 없습니다." + emptyAdminHint + "</div>"));
			$mainCount.text(mainCount > 0 ? '(' + mainCount + ')' : '');
		}, function() {
			$popular.html("<div class='text-danger'>편의 시설 정보를 불러오지 못했습니다.</div>");
			$main.html("<div class='col-12 text-danger'>편의 시설 정보를 불러오지 못했습니다.</div>");
		});
	}

	var isAdmin = '<c:out value="${member.memberRole}"/>' === 'ADMIN' || '<c:out value="${member.memberRole}"/>' === 'MASTER';

	function escapeHtml(s) {
		if (s == null) return '';
		return String(s).replace(/[&<>"']/g, function(c) {
			return ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'})[c];
		});
	}

	function escapeAttr(s) {
		return escapeHtml(s);
	}

	function reasonRender() {
		var hotelValue = '<c:out value="${detailList.hotelno}"/>';
		var $list = $('.reasonDetail');

		detailService.reasonList({ hotelno: hotelValue }, function(reasons) {
			var str = '';
			if (!reasons || reasons.length === 0) {
				if (isAdmin) {
					str = "<div class='col-12'><p class='text-muted text-center py-4'>등록된 이유가 없습니다. '이유 추가' 버튼을 눌러 추가해 주세요.</p></div>";
				} else {
					str = "<div class='col-12'><p class='text-muted text-center py-4'>등록된 이유가 없습니다.</p></div>";
				}
			} else {
				for (var i = 0; i < reasons.length; i++) {
					var r = reasons[i];
					var imgSrc = r.reasonImage
						? "/hotel/display?fileName=" + encodeURIComponent(r.reasonImage)
						: "/resources/hotel/file_repo/1/hotel3.jpg";
					str += "<div class='col-md-6'>";
					str += "<div class='rounded overflow-hidden shadow-sm border h-100 position-relative'>";
					str += "<img src='" + imgSrc + "' alt='" + escapeAttr(r.reasonTitle) + "' class='w-100' style='height:200px; object-fit:cover;'>";
					str += "<div class='p-3'>";
					str += "<h5 class='fw-bold'>" + escapeHtml(r.reasonTitle) + "</h5>";
					str += "<p class='text-muted mb-0'>" + escapeHtml(r.reasonContent) + "</p>";
					str += "</div>";
					if (isAdmin) {
						str += "<div class='position-absolute top-0 end-0 m-2 d-flex gap-1'>";
						str += "<button type='button' class='btn btn-sm btn-light shadow-sm btn-edit-reason' "
							+ "data-reasonno='" + r.reasonNo + "' "
							+ "data-title='" + escapeAttr(r.reasonTitle) + "' "
							+ "data-content='" + escapeAttr(r.reasonContent || '') + "' "
							+ "data-image='" + escapeAttr(r.reasonImage || '') + "'>"
							+ "<i class='bi bi-pencil'></i></button>";
						str += "<button type='button' class='btn btn-sm btn-light shadow-sm text-danger btn-delete-reason' "
							+ "data-reasonno='" + r.reasonNo + "'>"
							+ "<i class='bi bi-trash'></i></button>";
						str += "</div>";
					}
					str += "</div>";
					str += "</div>";
				}
			}
			$list.html(str);
		});
	}

	function roomService() {
		var hotelValue = '<c:out value="${detailList.hotelno}"/>';
		var roomUL = $(".roomDetail");

		detailService.roomList({ hotelno: hotelValue }, function(roomList) {
			var str = "";
			for (var i = 0; i < roomList.length; i++) {
				var bedno = roomList[i].bedno || 1;
				str += "<div class='col-md-4 room-item' data-bedno='" + bedno + "'>";
				str += "<div class='card h-100 border shadow-sm rounded overflow-hidden'>";
				/* Room Image */
				str += "<div class='position-relative'>";
				str += "<img src='/resources/hotel/file_repo/1/hotel3.jpg' class='card-img-top' alt='" + roomList[i].roomname + "' style='height:200px; object-fit:cover;'>";
				str += "<span class='position-absolute top-0 end-0 m-2 badge bg-white text-dark shadow-sm'><i class='bi bi-images'></i> " + (i + 3) + "</span>";
				str += "</div>";
				/* Room Body */
				str += "<div class='card-body d-flex flex-column'>";
				str += "<h6 class='fw-bold mb-2'>" + roomList[i].roomname + "</h6>";
				str += "<div class='small text-muted mb-2'>";
				str += "<div class='mb-1'><i class='bi bi-person'></i> " + bedno + "인 전용</div>";
				str += "<div class='mb-1'><i class='bi bi-arrows-fullscreen'></i> 25㎡</div>";
				str += "<div class='mb-1'><i class='bi bi-droplet'></i> 욕실 1개</div>";
				str += "<div class='mb-1'><i class='bi bi-people'></i> 최대 " + bedno + "명</div>";
				if (roomList[i].infoRoom) {
					str += "<div class='mb-1'><i class='bi bi-info-circle'></i> " + roomList[i].infoRoom + "</div>";
				}
				str += "</div>";
				str += "<a href='#' class='text-decoration-none small mb-3' style='color:#1a73e8;'>자세히 보기 &raquo;</a>";
				str += "<div class='mt-auto'>";
				str += "<button type='button' class='btn btn-primary-hotel w-100 btn-show-rates' data-roomno='" + roomList[i].roomno + "'>요금 보기</button>";
				str += "</div>";
				if (isAdmin) {
					str += "<div class='d-flex gap-1 mt-2 justify-content-end'>";
					str += "<button type='button' class='btn btn-sm btn-outline-secondary-hotel btn-edit-room' data-roomno='" + roomList[i].roomno + "' data-roomname='" + roomList[i].roomname + "' data-roomprice='" + roomList[i].roomprice + "' data-bedno='" + roomList[i].bedno + "' data-inforoom='" + (roomList[i].infoRoom || '') + "' data-checkin='" + (roomList[i].checkInDate || '') + "' data-checkout='" + (roomList[i].checkOutDate || '') + "'><i class='bi bi-pencil'></i></button>";
					str += "<button type='button' class='btn btn-sm btn-outline-danger-hotel btn-delete-room' data-roomno='" + roomList[i].roomno + "'><i class='bi bi-trash'></i></button>";
					str += "</div>";
				}
				str += "</div>";
				str += "</div>";
				str += "</div>";
			}
			roomUL.html(str);
		});
	}

	/* 요금 보기 버튼 → 검색 바로 스크롤 + focus */
	$(document).on('click', '.btn-show-rates', function(e) {
		e.preventDefault();
		var wrapper = document.querySelector('.search-bar-wrapper');
		if (!wrapper) return;
		if (!wrapper.hasAttribute('tabindex')) wrapper.setAttribute('tabindex', '-1');
		wrapper.scrollIntoView({ behavior: 'smooth', block: 'start' });
		wrapper.focus({ preventScroll: true });
	});

	/* (place and review services removed) */

	/* ===== Admin Functions ===== */
	if (isAdmin) {
		var hotelNo = '<c:out value="${detailList.hotelno}"/>';

		/* --- Image Upload --- */
		$('#btnAddImage').on('click', function() {
			$('#imageFileInput').val('');
			$('#imagePreview').html('');
			new bootstrap.Modal(document.getElementById('imageUploadModal')).show();
		});

		$('#imageFileInput').on('change', function() {
			var preview = $('#imagePreview');
			preview.html('');
			var files = this.files;
			for (var i = 0; i < files.length; i++) {
				var reader = new FileReader();
				reader.onload = function(e) {
					preview.append("<img src='" + e.target.result + "' style='width:80px;height:80px;object-fit:cover;border-radius:4px;margin:4px;'>");
				};
				reader.readAsDataURL(files[i]);
			}
		});

		$('#btnUploadImageConfirm').on('click', function() {
			var files = $('#imageFileInput')[0].files;
			if (files.length === 0) { alert('파일을 선택해주세요.'); return; }

			var formData = new FormData();
			for (var i = 0; i < files.length; i++) {
				formData.append('uploadFile', files[i]);
			}

			// 1) Upload files to backend via admin proxy
			$.ajax({
				url: '/admin/uploadAjaxAction',
				type: 'POST',
				data: formData,
				contentType: false,
				processData: false,
				success: function(uploadList) {
					// 2) Register each image in DB
					var completed = 0;
					for (var i = 0; i < uploadList.length; i++) {
						var fileName = uploadList[i].uploadPath + '/' + uploadList[i].uuid + '_' + uploadList[i].hotelFileName;
						$.ajax({
							url: '/hotel/image',
							type: 'POST',
							contentType: 'application/json',
							data: JSON.stringify({ hotelNo: hotelNo, hotelFileName: fileName }),
							success: function() {
								completed++;
								if (completed === uploadList.length) {
									bootstrap.Modal.getInstance(document.getElementById('imageUploadModal')).hide();
									alert('사진이 추가되었습니다.');
									showList();
								}
							}
						});
					}
				},
				error: function() { alert('업로드에 실패했습니다.'); }
			});
		});

		/* --- Image Manage (delete) --- */
		$('#btnManageImages').on('click', function() {
			var listEl = $('#imageManageList');
			listEl.html('<div class="text-center py-3"><div class="spinner-border text-warning" role="status"></div></div>');
			new bootstrap.Modal(document.getElementById('imageManageModal')).show();

			$.getJSON('/hotel/getAttachList', { hotelNo: hotelNo }, function(list) {
				var str = '';
				for (var i = 0; i < list.length; i++) {
					str += "<div class='col-4 col-md-3 position-relative'>";
					str += "<img src='/hotel/display?fileName=" + list[i].hotelFileName + "' style='width:100%;height:120px;object-fit:cover;border-radius:6px;'>";
					str += "<button type='button' class='btn btn-sm btn-danger-hotel position-absolute top-0 end-0 m-1 btn-delete-image' data-id='" + list[i].hotelImageId + "' data-filename='" + list[i].hotelFileName + "' style='border-radius:50%;width:28px;height:28px;padding:0;'><i class='bi bi-x'></i></button>";
					str += "</div>";
				}
				if (list.length === 0) str = "<p class='text-muted text-center w-100'>등록된 사진이 없습니다.</p>";
				listEl.html(str);
			});
		});

		$(document).on('click', '.btn-delete-image', function() {
			if (!confirm('이 사진을 삭제하시겠습니까?')) return;
			var $btn = $(this);
			var imageId = $btn.data('id');
			var fileName = $btn.data('filename');

			$.ajax({
				url: '/hotel/image/' + imageId,
				type: 'DELETE',
				success: function() {
					// Also delete physical file
					$.post('/admin/deleteFile', { fileName: fileName });
					$btn.closest('.col-4, .col-md-3').fadeOut(300, function() { $(this).remove(); });
					showList();
				},
				error: function() { alert('삭제에 실패했습니다.'); }
			});
		});

		/* --- Room Add --- */
		$('#btnAddRoom').on('click', function() {
			$('#roomModalTitle').text('객실 추가');
			$('#roomModalRoomno').val('');
			$('#roomModalName').val('');
			$('#roomModalPrice').val('');
			$('#roomModalBedno').val('');
			$('#roomModalInfo').val('');
			$('#roomModalCheckIn').val('');
			$('#roomModalCheckOut').val('');
			new bootstrap.Modal(document.getElementById('roomModal')).show();
		});

		/* --- Room Edit --- */
		$(document).on('click', '.btn-edit-room', function() {
			var $btn = $(this);
			$('#roomModalTitle').text('객실 수정');
			$('#roomModalRoomno').val($btn.data('roomno'));
			$('#roomModalName').val($btn.data('roomname'));
			$('#roomModalPrice').val($btn.data('roomprice'));
			$('#roomModalBedno').val($btn.data('bedno'));
			$('#roomModalInfo').val($btn.data('inforoom'));

			var checkin = $btn.data('checkin');
			var checkout = $btn.data('checkout');
			if (checkin) $('#roomModalCheckIn').val(formatDateForInput(checkin));
			if (checkout) $('#roomModalCheckOut').val(formatDateForInput(checkout));

			new bootstrap.Modal(document.getElementById('roomModal')).show();
		});

		function formatDateForInput(dateVal) {
			if (!dateVal) return '';
			var d = new Date(dateVal);
			if (isNaN(d.getTime())) return '';
			var month = ('0' + (d.getMonth() + 1)).slice(-2);
			var day = ('0' + d.getDate()).slice(-2);
			return d.getFullYear() + '-' + month + '-' + day;
		}

		/* --- Room Save (Add/Edit) --- */
		$('#btnRoomSave').on('click', function() {
			var roomno = $('#roomModalRoomno').val();
			var data = {
				hotelno: parseInt(hotelNo),
				roomname: $('#roomModalName').val(),
				roomprice: $('#roomModalPrice').val(),
				bedno: parseInt($('#roomModalBedno').val()) || 0,
				infoRoom: $('#roomModalInfo').val(),
				checkInDate: $('#roomModalCheckIn').val() || null,
				checkOutDate: $('#roomModalCheckOut').val() || null
			};

			if (!data.roomname) { alert('객실명을 입력해주세요.'); return; }
			if (!data.roomprice) { alert('가격을 입력해주세요.'); return; }

			if (roomno) {
				data.roomno = parseInt(roomno);
				$.ajax({
					url: '/hotel/room',
					type: 'PUT',
					contentType: 'application/json',
					data: JSON.stringify(data),
					success: function() {
						bootstrap.Modal.getInstance(document.getElementById('roomModal')).hide();
						alert('객실이 수정되었습니다.');
						roomService();
					},
					error: function() { alert('수정에 실패했습니다.'); }
				});
			} else {
				$.ajax({
					url: '/hotel/room',
					type: 'POST',
					contentType: 'application/json',
					data: JSON.stringify(data),
					success: function() {
						bootstrap.Modal.getInstance(document.getElementById('roomModal')).hide();
						alert('객실이 추가되었습니다.');
						roomService();
					},
					error: function() { alert('추가에 실패했습니다.'); }
				});
			}
		});

		/* --- Room Delete --- */
		$(document).on('click', '.btn-delete-room', function() {
			if (!confirm('이 객실을 삭제하시겠습니까?')) return;
			var roomno = $(this).data('roomno');
			$.ajax({
				url: '/hotel/room/' + roomno,
				type: 'DELETE',
				success: function() {
					alert('객실이 삭제되었습니다.');
					roomService();
				},
				error: function() { alert('삭제에 실패했습니다.'); }
			});
		});

		/* ===== 좋아하는 이유 관리 ===== */
		function resetReasonModal() {
			$('#reasonModalReasonNo').val('');
			$('#reasonModalImage').val('');
			$('#reasonModalTitleInput').val('');
			$('#reasonModalContent').val('');
			$('#reasonModalFile').val('');
			$('#reasonModalPreview').html('');
		}

		function showReasonPreview(fileName) {
			if (!fileName) { $('#reasonModalPreview').html(''); return; }
			$('#reasonModalPreview').html(
				"<img src='/hotel/display?fileName=" + encodeURIComponent(fileName) +
				"' style='width:120px;height:80px;object-fit:cover;border-radius:4px;'>"
			);
		}

		$('#btnAddReason').on('click', function() {
			$('#reasonModalTitle').text('이유 추가');
			resetReasonModal();
			new bootstrap.Modal(document.getElementById('reasonModal')).show();
		});

		$(document).on('click', '.btn-edit-reason', function() {
			var $btn = $(this);
			$('#reasonModalTitle').text('이유 수정');
			resetReasonModal();
			$('#reasonModalReasonNo').val($btn.data('reasonno'));
			$('#reasonModalTitleInput').val($btn.data('title'));
			$('#reasonModalContent').val($btn.data('content'));
			$('#reasonModalImage').val($btn.data('image'));
			showReasonPreview($btn.data('image'));
			new bootstrap.Modal(document.getElementById('reasonModal')).show();
		});

		/* 파일 선택 시 미리보기 */
		$('#reasonModalFile').on('change', function() {
			var file = this.files && this.files[0];
			if (!file) return;
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#reasonModalPreview').html(
					"<img src='" + e.target.result + "' style='width:120px;height:80px;object-fit:cover;border-radius:4px;'>"
				);
			};
			reader.readAsDataURL(file);
		});

		function uploadReasonImage(file, callback) {
			var formData = new FormData();
			formData.append('uploadFile', file);
			$.ajax({
				url: '/admin/uploadAjaxAction',
				type: 'POST',
				data: formData,
				contentType: false,
				processData: false,
				success: function(uploadList) {
					if (!uploadList || uploadList.length === 0) { callback(null); return; }
					var u = uploadList[0];
					callback(u.uploadPath + '/' + u.uuid + '_' + u.hotelFileName);
				},
				error: function() { callback(null); }
			});
		}

		$('#btnReasonSave').on('click', function() {
			var reasonNo = $('#reasonModalReasonNo').val();
			var title = $('#reasonModalTitleInput').val().trim();
			var content = $('#reasonModalContent').val().trim();
			var existingImage = $('#reasonModalImage').val();
			var file = $('#reasonModalFile')[0].files[0];

			if (!title) { alert('제목을 입력해주세요.'); return; }
			if (!content) { alert('내용을 입력해주세요.'); return; }

			function submit(imagePath) {
				var data = {
					hotelNo: parseInt(hotelNo),
					reasonTitle: title,
					reasonContent: content,
					reasonImage: imagePath || ''
				};
				if (reasonNo) {
					data.reasonNo = parseInt(reasonNo);
					detailService.updateReason(data, function() {
						bootstrap.Modal.getInstance(document.getElementById('reasonModal')).hide();
						alert('수정되었습니다.');
						reasonRender();
					}, function() { alert('수정에 실패했습니다.'); });
				} else {
					detailService.addReason(data, function() {
						bootstrap.Modal.getInstance(document.getElementById('reasonModal')).hide();
						alert('추가되었습니다.');
						reasonRender();
					}, function() { alert('추가에 실패했습니다.'); });
				}
			}

			if (file) {
				uploadReasonImage(file, function(path) {
					if (!path) { alert('이미지 업로드에 실패했습니다.'); return; }
					submit(path);
				});
			} else {
				submit(existingImage);
			}
		});

		$(document).on('click', '.btn-delete-reason', function() {
			if (!confirm('이 이유를 삭제하시겠습니까?')) return;
			var reasonNo = $(this).data('reasonno');
			detailService.deleteReason(reasonNo, function() {
				alert('삭제되었습니다.');
				reasonRender();
			}, function() { alert('삭제에 실패했습니다.'); });
		});

		/* ===== 편의 시설/서비스 관리 ===== */
		function resetAmenityModal() {
			$('#amenityModalAmenityNo').val('');
			$('#amenityModalName').val('');
			$('#amenityModalIcon').val('');
			$('#amenityModalType').val('POPULAR');
			$('#amenityModalOrder').val(0);
		}

		$(document).on('click', '.btn-add-amenity', function() {
			var presetType = $(this).data('type') || 'POPULAR';
			$('#amenityModalTitle').text('편의 시설 추가');
			resetAmenityModal();
			$('#amenityModalType').val(presetType);
			new bootstrap.Modal(document.getElementById('amenityModal')).show();
		});

		$(document).on('click', '.btn-edit-amenity', function() {
			var $btn = $(this);
			$('#amenityModalTitle').text('편의 시설 수정');
			resetAmenityModal();
			$('#amenityModalAmenityNo').val($btn.data('amenityno'));
			$('#amenityModalName').val($btn.data('name'));
			$('#amenityModalIcon').val($btn.data('icon'));
			$('#amenityModalType').val($btn.data('type') || 'POPULAR');
			$('#amenityModalOrder').val($btn.data('order') || 0);
			new bootstrap.Modal(document.getElementById('amenityModal')).show();
		});

		$('#btnAmenitySave').on('click', function() {
			var amenityNo = $('#amenityModalAmenityNo').val();
			var name = $('#amenityModalName').val().trim();
			var icon = $('#amenityModalIcon').val().trim();
			var type = $('#amenityModalType').val();
			var order = parseInt($('#amenityModalOrder').val(), 10);
			if (isNaN(order)) order = 0;

			if (!name) { alert('시설명을 입력해주세요.'); return; }
			if (!icon) { alert('아이콘 클래스를 입력해주세요. (예: bi-wifi)'); return; }
			if (type !== 'POPULAR' && type !== 'MAIN') { alert('분류를 선택해주세요.'); return; }

			var data = {
				hotelNo: parseInt(hotelNo),
				amenityName: name,
				amenityIcon: icon,
				amenityType: type,
				amenityOrder: order
			};

			if (amenityNo) {
				data.amenityNo = parseInt(amenityNo);
				detailService.updateAmenity(data, function() {
					bootstrap.Modal.getInstance(document.getElementById('amenityModal')).hide();
					alert('수정되었습니다.');
					amenityRender();
				}, function() { alert('수정에 실패했습니다.'); });
			} else {
				detailService.addAmenity(data, function() {
					bootstrap.Modal.getInstance(document.getElementById('amenityModal')).hide();
					alert('추가되었습니다.');
					amenityRender();
				}, function() { alert('추가에 실패했습니다.'); });
			}
		});

		$(document).on('click', '.btn-delete-amenity', function() {
			if (!confirm('이 편의 시설을 삭제하시겠습니까?')) return;
			var amenityNo = $(this).data('amenityno');
			detailService.deleteAmenity(amenityNo, function() {
				alert('삭제되었습니다.');
				amenityRender();
			}, function() { alert('삭제에 실패했습니다.'); });
		});
	}
});
</script>

<!-- ===== 이용 후기 (Reviews) ===== -->
<script type="text/javascript">
$(function() {
	var hotelno = '<c:out value="${detailList.hotelno}"/>';
	var myNo = '<c:out value="${member.memberNo}"/>';
	var myNick = '<c:out value="${member.memberNickname}"/>';
	var role = '<c:out value="${member.memberRole}"/>';
	var isAdminR = (role === 'ADMIN' || role === 'MASTER');
	var curPage = 1;

	function esc(s) {
		if (s == null) return '';
		return String(s).replace(/[&<>"']/g, function(c) {
			return ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'})[c];
		});
	}

	function stars(g) {
		g = parseInt(g, 10) || 0;
		var s = '';
		for (var i = 0; i < 5; i++) {
			s += '<i class="bi ' + (i < g ? 'bi-star-fill' : 'bi-star') + '"></i>';
		}
		return s;
	}

	function render(page) {
		curPage = page || 1;
		detailService.getList({ hotelno: hotelno, page: curPage }, function(cnt, list) {
			list = list || [];
			$('.review-count').text('(' + cnt + ')');

			if (list.length) {
				var sum = 0;
				list.forEach(function(r) { sum += (r.grade || 0); });
				var avg = (sum / list.length).toFixed(1);
				$('.review-avg').html('<span class="text-warning">' + stars(Math.round(avg)) + '</span> <span class="ms-1">' + avg + '</span>');
			} else {
				$('.review-avg').html('');
			}

			var str = '';
			if (!list.length) {
				str = '<div class="text-muted text-center py-4">아직 등록된 후기가 없습니다.</div>';
			} else {
				for (var i = 0; i < list.length; i++) {
					var r = list[i];
					var own = (myNick !== '' && r.memberNickname === myNick);
					str += '<div class="border-bottom py-3">';
					str += '<div class="d-flex justify-content-between align-items-center mb-1">';
					str += '<div><strong>' + esc(r.memberNickname) + '</strong>'
						+ '<span class="text-warning ms-2">' + stars(r.grade) + '</span></div>';
					str += '<div class="text-muted small">' + esc(r.reviewDate) + '</div>';
					str += '</div>';
					str += '<div>' + esc(r.reviewContent) + '</div>';
					if (own || isAdminR) {
						str += '<div class="text-end mt-1">'
							+ '<button type="button" class="btn btn-sm btn-link text-danger p-0 btn-del-review" data-no="' + r.reviewNo + '">삭제</button>'
							+ '</div>';
					}
					str += '</div>';
				}
			}
			$('.reviewList').html(str);

			var totalPages = Math.ceil(cnt / 10) || 1;
			var pg = '';
			for (var p = 1; p <= totalPages; p++) {
				pg += '<li class="page-item ' + (p === curPage ? 'active' : '')
					+ '"><a class="page-link btn-review-page" href="#" data-page="' + p + '">' + p + '</a></li>';
			}
			$('.reviewPaging').html(totalPages > 1 ? pg : '');
		}, function() {
			$('.reviewList').html('<div class="text-danger text-center py-4">후기를 불러오지 못했습니다.</div>');
		});
	}

	$(document).on('click', '.btn-review-page', function(e) {
		e.preventDefault();
		render($(this).data('page'));
	});

	$('#btnReviewSubmit').on('click', function() {
		var grade = parseInt($('#reviewGrade').val(), 10);
		var content = $('#reviewContent').val().trim();
		if (content.length < 10) { alert('후기는 10자 이상 입력해주세요.'); return; }
		if (content.length > 500) { alert('후기는 500자 이하로 입력해주세요.'); return; }

		detailService.add({
			memberNo: parseInt(myNo, 10),
			hotelNo: parseInt(hotelno, 10),
			grade: grade,
			reviewContent: content
		}, function() {
			$('#reviewContent').val('');
			render(1);
		}, function() {
			alert('후기 등록에 실패했습니다. 입력 내용을 확인해주세요.');
		});
	});

	$(document).on('click', '.btn-del-review', function() {
		if (!confirm('이 후기를 삭제하시겠습니까?')) return;
		var no = $(this).data('no');
		detailService.deleteReply(no, function() {
			render(curPage);
		}, function() {
			alert('삭제에 실패했습니다.');
		});
	});

	render(1);
});
</script>

<!-- ===== 찜하기 (Wishlist) ===== -->
<script type="text/javascript">
$(function() {
	var hotelNo = '<c:out value="${detailList.hotelno}"/>';
	var isLoggedIn = '<c:out value="${member.memberNo}"/>' !== '';
	var $btn = $('#btnWish');

	function paint(wished) {
		$btn.attr('data-wished', wished ? 'true' : 'false');
		$('#wishIcon').attr('class', wished ? 'bi bi-heart-fill' : 'bi bi-heart');
		$('#wishLabel').text(wished ? '찜 완료' : '찜하기');
		$btn.toggleClass('btn-danger-hotel', wished).toggleClass('btn-outline-danger-hotel', !wished);
	}

	// 초기 상태 조회 (로그인한 경우만)
	if (isLoggedIn) {
		$.getJSON('/member/wish/check?hotelNo=' + hotelNo, function(wished) {
			paint(wished === true);
		});
	}

	$btn.on('click', function() {
		if (!isLoggedIn) {
			if (confirm('찜하기는 로그인이 필요합니다. 로그인하시겠습니까?')) {
				location.href = '/member/login';
			}
			return;
		}
		var wished = $btn.attr('data-wished') === 'true';
		$.ajax({
			url: '/member/wish?hotelNo=' + hotelNo,
			type: wished ? 'DELETE' : 'POST',
			success: function() { paint(!wished); },
			error: function() { alert('찜 처리에 실패했습니다.'); }
		});
	});
});
</script>

<%@include file="../includes/footer.jsp"%>
