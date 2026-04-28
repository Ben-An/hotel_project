package org.zerock.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.zerock.config.BackendConfig;
import org.zerock.domain.MapVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/map/*")
@Log4j
public class MapController {

	@Autowired
	private RestTemplate restTemplate;

	private static final String API = BackendConfig.BACKEND_URL + "/map";

	@GetMapping("/mapside")
	public void mapList(Model model, @RequestParam("state") String state) {
		List<MapVO> list = restTemplate.exchange(
				API + "/mapside?state=" + state,
				HttpMethod.GET, null,
				new ParameterizedTypeReference<List<MapVO>>() {}).getBody();
		model.addAttribute("getmap", list);
	}

	@GetMapping("/nearby")
	@ResponseBody
	public List<MapVO> nearbyList(
			@RequestParam("lat") double lat,
			@RequestParam("lng") double lng,
			@RequestParam(value = "radius", defaultValue = "10") double radius) {
		List<MapVO> list = restTemplate.exchange(
				API + "/nearby?lat=" + lat + "&lng=" + lng + "&radius=" + radius,
				HttpMethod.GET, null,
				new ParameterizedTypeReference<List<MapVO>>() {}).getBody();
		return list;
	}

	@GetMapping("/searchList")
	public void searchInfo(Model model) {
		Map<String, Object> result = restTemplate.getForObject(API + "/searchList", Map.class);
		if (result != null) {
			model.addAttribute("hotelList", result.get("hotelList"));
		}
	}
}
