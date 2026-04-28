package org.zerock.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.MainVO;
import org.zerock.domain.PageDTO;
import org.zerock.domain.ReplyListVO;
import org.zerock.mapper.AttachMapper;
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

	@Value("${app.upload-path}")
	private String uploadPath;

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
