package org.zerock.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.FileBlobVO;
import org.zerock.domain.HotelVO;
import org.zerock.domain.PageDTO;
import org.zerock.domain.RelyVO;
import org.zerock.mapper.FileBlobMapper;
import org.zerock.service.AdminService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/admin")
public class AdminApiController {

	@Autowired
	private AdminService adminService;

	@Autowired
	private FileBlobMapper fileBlobMapper;

	/* 전체 숙소 리스트 */
	@GetMapping("/hotelList")
	public ResponseEntity<Map<String, Object>> adminHotelList(Criteria cri) {
		if (cri.getPageNum() == 0) cri.setPageNum(1);
		if (cri.getAmount() == 0) cri.setAmount(10);

		Map<String, Object> result = new HashMap<>();
		result.put("list", adminService.adminHotelListAll(cri));
		result.put("pageMaker", new PageDTO(cri, adminService.hotelGetTotalWithSearch(cri)));
		result.put("totalCount", adminService.hotelGetTotal());
		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	/* 관리자 메인 페이지 데이터 */
	@GetMapping("/main")
	public ResponseEntity<Map<String, Object>> adminMain(Criteria cri) {
		if (cri.getPageNum() == 0) cri.setPageNum(1);
		if (cri.getAmount() == 0) cri.setAmount(10);

		Map<String, Object> result = new HashMap<>();

		// 전체 숙소 리스트 (페이징 + 검색)
		result.put("list", adminService.adminHotelListAll(cri));
		result.put("pageMaker", new PageDTO(cri, adminService.hotelGetTotalWithSearch(cri)));
		result.put("totalCount", adminService.hotelGetTotal());

		List list_reser = adminService.adminReservationList();
		result.put("list_reser", list_reser);

		List list_review = adminService.adminReviewList();
		result.put("list_review", list_review);

		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	/* 첨부 파일 업로드 — file_blob에 저장 */
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<AttachImageVO>> uploadAjaxAction(MultipartFile[] uploadFile) {
		log.info("uploadAjaxAction..........");

		for (MultipartFile multipartFile : uploadFile) {
			if (!isImage(multipartFile)) {
				return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
			}
		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String datePath = sdf.format(new Date());

		List<AttachImageVO> list = new ArrayList<>();
		for (MultipartFile multipartFile : uploadFile) {
			String originalName = multipartFile.getOriginalFilename();
			String uuid = UUID.randomUUID().toString();

			// 응답 형태 유지 — FE는 uploadPath/uuid_hotelFileName 으로 fileName 조합
			AttachImageVO vo = new AttachImageVO();
			vo.setHotelFileName(originalName);
			vo.setUploadPath(datePath);
			vo.setUuid(uuid);

			saveBlob(datePath + "/" + uuid + "_" + originalName, multipartFile);
			list.add(vo);
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	/* 숙소 등록 */
	@PostMapping(value = "/hotelEnroll", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public ResponseEntity<Map<String, Object>> hotelEnroll(
			@Valid @RequestPart("hotel") HotelVO hotel,
			@RequestPart(value = "uploadFile", required = false) MultipartFile[] uploadFile) {
		log.info("hotelEnroll......" + hotel);

		// 이미지 파일이 있으면 file_blob에 저장 후 imageList에 세팅
		if (uploadFile != null && uploadFile.length > 0) {
			List<AttachImageVO> imageList = new ArrayList<>();

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String datePath = sdf.format(new Date());

			for (MultipartFile file : uploadFile) {
				if (file.isEmpty()) continue;

				String originalName = file.getOriginalFilename();
				String uuid = UUID.randomUUID().toString();
				// 전체 상대경로를 file_blob의 키이자 hotelFileName으로 사용
				String fileName = datePath + "/" + uuid + "_" + originalName;

				saveBlob(fileName, file);

				AttachImageVO imageVO = new AttachImageVO();
				imageVO.setHotelFileName(fileName);
				imageVO.setUuid(uuid);
				imageVO.setUploadPath(datePath);
				imageList.add(imageVO);
			}

			if (!imageList.isEmpty()) {
				hotel.setImageList(imageList);
			}
		}

		if (hotel.getImageList() == null || hotel.getImageList().isEmpty()) {
			Map<String, Object> errorResult = new HashMap<>();
			errorResult.put("success", false);
			errorResult.put("errors", List.of(
				Map.of("field", "imageList", "message", "호텔 이미지를 하나 이상 등록해주세요")));
			return new ResponseEntity<>(errorResult, HttpStatus.BAD_REQUEST);
		}

		adminService.hotelEnroll(hotel);
		Map<String, Object> result = new HashMap<>();
		result.put("enroll_result", hotel.getHotelName());
		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	/* 이미지 파일 삭제 */
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(@RequestParam String fileName) {
		log.info("deleteFile........" + fileName);
		try {
			fileBlobMapper.deleteBlob(URLDecoder.decode(fileName, "UTF-8"));
		} catch (Exception e) {
			log.error("이미지 삭제 실패: " + fileName, e);
			return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	/* 신고 리뷰 삭제 */
	@PostMapping("/reviewDelete")
	public ResponseEntity<String> reviewDelete(@RequestBody RelyVO rely) throws Exception {
		adminService.reviewDelete(rely);
		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	/* 이미지 표시 — file_blob에서 조회 */
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(@RequestParam String fileName) {
		FileBlobVO blob = fileBlobMapper.selectBlob(fileName);
		if (blob == null || blob.getImageData() == null) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		HttpHeaders header = new HttpHeaders();
		if (blob.getContentType() != null) {
			header.add("Content-type", blob.getContentType());
		}
		return new ResponseEntity<>(blob.getImageData(), header, HttpStatus.OK);
	}

	/* ===== 내부 헬퍼 ===== */

	/* 이미지 파일 여부 (확장자 기반) */
	private boolean isImage(MultipartFile file) {
		try {
			String type = Files.probeContentType(new File(file.getOriginalFilename()).toPath());
			return type != null && type.startsWith("image");
		} catch (IOException e) {
			log.warn("컨텐츠 타입 확인 실패: " + file.getOriginalFilename(), e);
			return false;
		}
	}

	/* MultipartFile을 file_blob에 저장 */
	private void saveBlob(String fileName, MultipartFile file) {
		try {
			FileBlobVO blob = new FileBlobVO();
			blob.setFileName(fileName);
			blob.setContentType(resolveContentType(file));
			blob.setImageData(file.getBytes());
			fileBlobMapper.insertBlob(blob);
		} catch (IOException e) {
			log.error("이미지 저장 실패: " + fileName, e);
		}
	}

	/* 컨텐츠 타입 결정 — 업로드 헤더 우선, 없으면 확장자 추론 */
	private String resolveContentType(MultipartFile file) {
		String type = file.getContentType();
		if (type == null || type.isEmpty()) {
			try {
				type = Files.probeContentType(new File(file.getOriginalFilename()).toPath());
			} catch (IOException ignore) {
				// 무시 — 아래 기본값 사용
			}
		}
		return type != null ? type : MediaType.APPLICATION_OCTET_STREAM_VALUE;
	}
}
