package org.zerock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.FileBlobVO;
import org.zerock.domain.MainVO;
import org.zerock.domain.PageDTO;
import org.zerock.domain.ReplyListVO;
import org.zerock.mapper.AttachMapper;
import org.zerock.mapper.FileBlobMapper;
import org.zerock.service.HotelImageService;
import org.zerock.service.HotelSearchService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/hotel")
public class MainApiController {

	@Autowired
	private HotelImageService service;

	@Autowired
	private AttachMapper attachMapper;

	@Autowired
	private HotelSearchService searchService;

	@Autowired
	private FileBlobMapper fileBlobMapper;

	@GetMapping("/index")
	public ResponseEntity<List<MainVO>> list(Criteria cri) {
		if (cri.getPageNum() == 0) cri.setPageNum(1);
		if (cri.getAmount() == 0) cri.setAmount(8);
		return new ResponseEntity<>(service.List(cri), HttpStatus.OK);
	}

	@GetMapping("/index/count")
	public ResponseEntity<Integer> getTotal() {
		return new ResponseEntity<>(service.getTotal(), HttpStatus.OK);
	}

	@GetMapping(value = "/replyList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ReplyListVO>> replyList() {
		return new ResponseEntity<>(service.replyList(), HttpStatus.OK);
	}

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

	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<AttachImageVO>> getAttachList(@RequestParam long hotelNo) {
		return new ResponseEntity<>(attachMapper.getAttachList(hotelNo), HttpStatus.OK);
	}

	@GetMapping(value = "/popularRegions", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Map<String, Object>>> popularRegions(
			@RequestParam(defaultValue = "8") int limit) {
		return new ResponseEntity<>(searchService.getPopularRegions(limit), HttpStatus.OK);
	}
}
