package org.zerock.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
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

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.HotelVO;
import org.zerock.domain.PageDTO;
import org.zerock.domain.RelyVO;
import org.zerock.service.AdminService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/admin")
public class AdminApiController {

	@Autowired
	private AdminService adminService;

	@Value("${app.upload-path}")
	private String uploadPath;

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

	/* 첨부 파일 업로드 */
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<AttachImageVO>> uploadAjaxAction(MultipartFile[] uploadFile) {
		log.info("uploadAjaxAction..........");

		for (MultipartFile multipartFile : uploadFile) {
			File checkfile = new File(multipartFile.getOriginalFilename());
			String type = null;
			try {
				type = Files.probeContentType(checkfile.toPath());
			} catch (IOException e) {
				e.printStackTrace();
			}
			if (!type.startsWith("image")) {
				return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
			}
		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String str = sdf.format(new Date());
		File uploadDir = new File(uploadPath, str);
		if (!uploadDir.exists()) {
			uploadDir.mkdir();
		}

		List<AttachImageVO> list = new ArrayList<>();
		for (MultipartFile multipartFile : uploadFile) {
			AttachImageVO vo = new AttachImageVO();
			String uploadFileName = multipartFile.getOriginalFilename();
			vo.setHotelFileName(uploadFileName);
			vo.setUploadPath(str);

			String uuid = UUID.randomUUID().toString();
			vo.setUuid(uuid);
			uploadFileName = uuid + "_" + uploadFileName;

			File saveFile = new File(uploadDir, uploadFileName);
			try {
				multipartFile.transferTo(saveFile);

				File thumbnailFile = new File(uploadDir, "s_" + uploadFileName);
				BufferedImage bo_image = ImageIO.read(saveFile);
				double ratio = 3;
				int width = (int) (bo_image.getWidth() / ratio);
				int height = (int) (bo_image.getHeight() / ratio);
				BufferedImage bt_image = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);
				Graphics2D graphic = bt_image.createGraphics();
				graphic.drawImage(bo_image, 0, 0, width, height, null);
				ImageIO.write(bt_image, "jpg", thumbnailFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
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

		// 이미지 파일이 있으면 저장 후 imageList에 세팅
		if (uploadFile != null && uploadFile.length > 0) {
			List<AttachImageVO> imageList = new ArrayList<>();

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String datePath = sdf.format(new Date());
			File uploadDir = new File(uploadPath, datePath);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs();
			}

			for (MultipartFile file : uploadFile) {
				if (file.isEmpty()) continue;
				try {
					String originalName = file.getOriginalFilename();
					String uuid = UUID.randomUUID().toString();
					String savedFileName = uuid + "_" + originalName;

					// 원본 파일 저장
					File saveFile = new File(uploadDir, savedFileName);
					file.transferTo(saveFile);

					// 썸네일 생성
					File thumbnailFile = new File(uploadDir, "s_" + savedFileName);
					BufferedImage bo_image = ImageIO.read(saveFile);
					double ratio = 3;
					int width = (int) (bo_image.getWidth() / ratio);
					int height = (int) (bo_image.getHeight() / ratio);
					BufferedImage bt_image = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);
					Graphics2D graphic = bt_image.createGraphics();
					graphic.drawImage(bo_image, 0, 0, width, height, null);
					ImageIO.write(bt_image, "jpg", thumbnailFile);

					// AttachImageVO 생성 — 전체 상대경로를 hotelFileName에 저장
					AttachImageVO imageVO = new AttachImageVO();
					imageVO.setHotelFileName(datePath + "/" + uuid + "_" + originalName);
					imageVO.setUuid(uuid);
					imageVO.setUploadPath(datePath);
					imageList.add(imageVO);
				} catch (Exception e) {
					log.error("이미지 저장 실패: " + file.getOriginalFilename(), e);
				}
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
			File file = new File(uploadPath + "\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			String originFileName = file.getAbsolutePath().replaceFirst("s_", "");
			new File(originFileName).delete();
		} catch (Exception e) {
			e.printStackTrace();
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

	/* 이미지 표시 */
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(@RequestParam String fileName) {
		File file = new File(uploadPath + "\\" + fileName);
		// 직접 경로에 없으면 하위 디렉터리에서 파일명 포함 검색 (레거시 데이터 호환)
		if (!file.exists()) {
			File uploadDir = new File(uploadPath);
			File[] subDirs = uploadDir.listFiles(File::isDirectory);
			if (subDirs != null) {
				for (File dir : subDirs) {
					File[] matches = dir.listFiles((d, name) -> name.endsWith(fileName));
					if (matches != null && matches.length > 0) {
						file = matches[0];
						break;
					}
				}
			}
		}
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-type", Files.probeContentType(file.toPath()));
			return new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
