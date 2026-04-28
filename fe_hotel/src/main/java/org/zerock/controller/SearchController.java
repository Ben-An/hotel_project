package org.zerock.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.zerock.config.BackendConfig;
import org.zerock.domain.Criteria;
import org.zerock.domain.SearchVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/hotel/*")
@Log4j
public class SearchController {

	@Autowired
	private RestTemplate restTemplate;

	private static final String API = BackendConfig.BACKEND_URL + "/hotel";

	@GetMapping("/search_normal")
	public void list(@RequestParam Map<String, Object> filterMap, Model model) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<Map<String, Object>> entity = new HttpEntity<>(filterMap, headers);

		List<SearchVO> list = restTemplate.exchange(
				API + "/search_normal",
				HttpMethod.POST,
				entity,
				new ParameterizedTypeReference<List<SearchVO>>() {}).getBody();
		model.addAttribute("list", list);
	}

	@PostMapping("/search_filter")
	@ResponseBody
	public List<SearchVO> listFilter(@RequestBody Map<String, Object> filterMap, Criteria cri) {
		filterMap.put("pageNum", cri.getPageNum());
		filterMap.put("amount", cri.getAmount());

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<Map<String, Object>> entity = new HttpEntity<>(filterMap, headers);

		return restTemplate.exchange(
				API + "/search_filter",
				HttpMethod.POST,
				entity,
				new ParameterizedTypeReference<List<SearchVO>>() {}).getBody();
	}
}
