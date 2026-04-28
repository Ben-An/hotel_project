package org.zerock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.zerock.config.BackendConfig;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.MainVO;
import org.zerock.domain.ReplyListVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/hotel/*")
@Log4j
public class MainController {

	@Autowired
	private RestTemplate restTemplate;

	private static final String API = BackendConfig.BACKEND_URL + "/hotel";

	@GetMapping("/index")
	public void list(@RequestParam(defaultValue = "1") int pageNum,
					 @RequestParam(defaultValue = "8") int amount,
					 Model model) {
		// 숙소 목록 조회
		String url = API + "/index?pageNum=" + pageNum + "&amount=" + amount;
		List<MainVO> list = restTemplate.exchange(
				url,
				HttpMethod.GET,
				null,
				new ParameterizedTypeReference<List<MainVO>>() {}).getBody();
		model.addAttribute("list", list);

		// 총 건수 조회 → 페이지네이션 계산
		Integer total = restTemplate.getForObject(API + "/index/count", Integer.class);
		if (total == null) total = 0;

		int endPage = (int)(Math.ceil(pageNum / 10.0)) * 10;
		int startPage = endPage - 9;
		int realEnd = (int)(Math.ceil((total * 1.0) / amount));
		if (realEnd < endPage) endPage = realEnd;
		if (endPage <= 0) endPage = 1;
		boolean prev = startPage > 1;
		boolean next = endPage < realEnd;

		Map<String, Object> pageMaker = new HashMap<>();
		pageMaker.put("startPage", startPage);
		pageMaker.put("endPage", endPage);
		pageMaker.put("prev", prev);
		pageMaker.put("next", next);
		pageMaker.put("total", total);
		pageMaker.put("pageNum", pageNum);
		pageMaker.put("amount", amount);
		model.addAttribute("pageMaker", pageMaker);
	}

	@ResponseBody
	@GetMapping(value = "/replyList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ReplyListVO>> replyList() {
		List<ReplyListVO> list = restTemplate.exchange(
				API + "/replyList",
				HttpMethod.GET,
				null,
				new ParameterizedTypeReference<List<ReplyListVO>>() {}).getBody();
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(@RequestParam String fileName) {
		return restTemplate.getForEntity(API + "/display?fileName=" + fileName, byte[].class);
	}

	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachImageVO>> getAttachList(@RequestParam long hotelNo) {
		List<AttachImageVO> list = restTemplate.exchange(
				API + "/getAttachList?hotelNo=" + hotelNo,
				HttpMethod.GET,
				null,
				new ParameterizedTypeReference<List<AttachImageVO>>() {}).getBody();
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	@GetMapping(value = "/popularRegions", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<Map<String, Object>>> popularRegions(
			@RequestParam(defaultValue = "8") int limit) {
		List<Map<String, Object>> list = restTemplate.exchange(
				API + "/popularRegions?limit=" + limit,
				HttpMethod.GET,
				null,
				new ParameterizedTypeReference<List<Map<String, Object>>>() {}).getBody();
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
}
