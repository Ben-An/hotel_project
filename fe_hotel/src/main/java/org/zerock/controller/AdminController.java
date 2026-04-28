package org.zerock.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.IOException;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.cfg.CoercionAction;
import com.fasterxml.jackson.databind.cfg.CoercionInputShape;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.config.BackendConfig;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.HotelVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.MyPageVO;
import org.zerock.domain.RelyVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping(value = "/admin")
public class AdminController {

	@Autowired
	private RestTemplate restTemplate;

	private final ObjectMapper objectMapper;
	{
		objectMapper = new ObjectMapper();
		objectMapper.configure(DeserializationFeature.ACCEPT_SINGLE_VALUE_AS_ARRAY, true);
		objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		objectMapper.coercionConfigDefaults()
				.setCoercion(CoercionInputShape.EmptyString, CoercionAction.AsNull);
	}

	private static final String API = BackendConfig.BACKEND_URL + "/admin";

/* 관리자 메인 페이지 */
	@RequestMapping(value = "main", method = RequestMethod.GET)
	public void adminMainGET(Criteria cri, Model model) {
		if (cri.getPageNum() == 0) cri.setPageNum(1);
		if (cri.getAmount() == 0) cri.setAmount(10);

		String url = API + "/main?pageNum=" + cri.getPageNum() + "&amount=" + cri.getAmount();
		if (cri.getKeyword() != null && !cri.getKeyword().isEmpty()) {
			url += "&keyword=" + cri.getKeyword();
		}
		Map<String, Object> result = restTemplate.getForObject(url, Map.class);

		if (result != null) {
			model.addAttribute("list", objectMapper.convertValue(
					result.get("list"), new TypeReference<List<HotelVO>>(){}));
			model.addAttribute("list_reser", objectMapper.convertValue(
					result.get("list_reser"), new TypeReference<List<MyPageVO>>(){}));
			model.addAttribute("list_review", objectMapper.convertValue(
					result.get("list_review"), new TypeReference<List<RelyVO>>(){}));
			model.addAttribute("pageMaker", result.get("pageMaker"));
			model.addAttribute("totalCount", result.get("totalCount"));
		}
		model.addAttribute("keyword", cri.getKeyword());
	}

	/* 첨부 파일 업로드 프록시 */
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachImageVO>> uploadAjaxAction(@RequestParam("uploadFile") MultipartFile[] uploadFile) throws IOException {
		MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
		for (MultipartFile file : uploadFile) {
			if (!file.isEmpty()) {
				ByteArrayResource resource = new ByteArrayResource(file.getBytes()) {
					@Override
					public String getFilename() {
						return file.getOriginalFilename();
					}
				};
				body.add("uploadFile", resource);
			}
		}
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.MULTIPART_FORM_DATA);
		HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
		ResponseEntity<List<AttachImageVO>> response = restTemplate.exchange(
				API + "/uploadAjaxAction",
				HttpMethod.POST,
				requestEntity,
				new ParameterizedTypeReference<List<AttachImageVO>>() {});
		return response;
	}

	/* 숙소 등록 페이지 */
	@RequestMapping(value = "addHotel", method = RequestMethod.GET)
	public void addHotelGET() {
		log.info("숙소 등록 페이지 접속");
	}

	/* 숙소 등록 */
	@PostMapping("/hotelEnroll")
	public String hotelEnrollPOST(HotelVO hotel, @RequestParam(value = "uploadFile", required = false) MultipartFile[] uploadFile, HttpSession session, RedirectAttributes rttr) throws IOException {
		MemberVO member = (MemberVO) session.getAttribute("member");
		if (member != null) {
			hotel.setMemberNo(member.getMemberNo());
		}
		MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();

		// hotel 데이터를 JSON part로 추가
		HttpHeaders jsonHeaders = new HttpHeaders();
		jsonHeaders.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<HotelVO> hotelPart = new HttpEntity<>(hotel, jsonHeaders);
		body.add("hotel", hotelPart);

		// 이미지 파일이 있으면 file part로 추가
		if (uploadFile != null) {
			for (MultipartFile file : uploadFile) {
				if (!file.isEmpty()) {
					ByteArrayResource resource = new ByteArrayResource(file.getBytes()) {
						@Override
						public String getFilename() {
							return file.getOriginalFilename();
						}
					};
					body.add("uploadFile", resource);
				}
			}
		}

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.MULTIPART_FORM_DATA);
		HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

		try {
			Map result = restTemplate.postForObject(API + "/hotelEnroll", requestEntity, Map.class);
			if (result != null) {
				rttr.addFlashAttribute("enroll_result", result.get("enroll_result"));
			}
			return "redirect:/admin/main";
		} catch (HttpClientErrorException e) {
			log.error("숙소 등록 실패: " + e.getStatusCode() + " - " + e.getResponseBodyAsString());
			rttr.addFlashAttribute("error_msg", "숙소 등록에 실패했습니다. 입력 정보를 확인해주세요.");
			return "redirect:/admin/addHotel";
		} catch (RestClientException e) {
			log.error("백엔드 연결 오류: ", e);
			rttr.addFlashAttribute("error_msg", "서버 연결에 실패했습니다. 잠시 후 다시 시도해주세요.");
			return "redirect:/admin/addHotel";
		}
	}

	/* 이미지 파일 삭제 */
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(@RequestParam String fileName) {
		String result = restTemplate.postForObject(
				API + "/deleteFile?fileName=" + fileName, null, String.class);
		return ResponseEntity.ok(result);
	}

	/* 신고 리뷰 삭제 */
	@RequestMapping(value = "/reviewDelete", method = RequestMethod.POST)
	public String reviewDelete(HttpServletRequest request, RelyVO rely) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<RelyVO> entity = new HttpEntity<>(rely, headers);
		restTemplate.postForObject(API + "/reviewDelete", entity, String.class);

		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/admin/main";
	}

	/* 이미지 표시 */
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(@RequestParam String fileName) {
		return restTemplate.getForEntity(API + "/display?fileName=" + fileName, byte[].class);
	}
}
