package org.zerock.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.zerock.domain.Criteria;
import org.zerock.domain.SearchVO;
import org.zerock.service.HotelSearchService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/hotel")
public class SearchApiController {

	@Autowired
	private HotelSearchService service;

	@PostMapping("/search_normal")
	public ResponseEntity<List<SearchVO>> searchNormal(@RequestBody Map<String, Object> filterMap) {
		return new ResponseEntity<>(service.listHotels(filterMap), HttpStatus.OK);
	}

	@PostMapping("/search_filter")
	public ResponseEntity<List<SearchVO>> searchFilter(@RequestBody Map<String, Object> filterMap, Criteria cri) {
		filterMap.put("pageNum", cri.getPageNum());
		filterMap.put("amount", cri.getAmount());
		return new ResponseEntity<>(service.listHotels(filterMap), HttpStatus.OK);
	}
}
