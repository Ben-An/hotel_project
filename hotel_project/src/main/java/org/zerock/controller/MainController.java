package org.zerock.controller;



import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.HotelImageVO;
import org.zerock.domain.HotelVO;
import org.zerock.mapper.AttachMapper;
import org.zerock.service.HotelImageService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;



@Controller
@RequestMapping("/hotel/*")
@AllArgsConstructor
@Log4j

public class MainController {
	
	@Autowired
	private HotelImageService service;
	
	@Autowired
	private AttachMapper attachMapper;

	@GetMapping("/index")
	public void list(Model model){
		
		model.addAttribute("list",service.List());
		
		System.out.println("model>>>>>>"+model);
}
	
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(String fileName){
		log.info("getImage()..."+fileName);
		
		File file = new File("c:\\upload\\"+fileName);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/* 이미지 정보 반환 */
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> getAttachList(long hotelNo){
		
		log.info("getAttachList.........." + hotelNo);
		
		return new ResponseEntity<List<AttachImageVO>>(attachMapper.getAttachList(hotelNo), HttpStatus.OK);
	}
	
	
	
	
	
	
	
	
//	@GetMapping(value="/getList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
//	@ResponseBody
//	public ResponseEntity<List<HotelImageVO>> getList(HotelImageVO imagefile){
//		
//		System.out.println("hotelImage >>>>"+imagefile);
//		
//		return new ResponseEntity<>(service.getList(imagefile), HttpStatus.OK );
//		
//	}
	
	
	
	
}
