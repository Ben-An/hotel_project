package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.DetailImage;
import org.zerock.domain.ImageList;
import org.zerock.domain.RelyVO;
import org.zerock.service.DetailService;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/hotel/*")
@AllArgsConstructor
@Log4j
public class DetailController {
	
	@Autowired
	private DetailService service;

	
	
	@GetMapping("/detail")
	public void detailHotel(int hotelno, Model model) {
		
		
		
		log.info("get>>>>>>>>>>>>>>>"+hotelno);
		model.addAttribute("detailList",service.detailList(hotelno));
		
		log.info(model);
	
}
	
	@ResponseBody
	@GetMapping(value="/list.do",produces = {MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<DetailImage>> list(int hotelno){
		
		log.info("Get>>>>>>>>>>>>>>"+hotelno);
		
		return new ResponseEntity<>(service.getImage(hotelno),HttpStatus.OK);
	}
	
	
	@ResponseBody
	@GetMapping(value="/imageList.do", produces = {MediaType.APPLICATION_PROBLEM_JSON_UTF8_VALUE})
	public ResponseEntity<List<ImageList>> roomList(int hotelno){
		
		
		log.info("get image num>>>>>>>>>>>>>>"+hotelno);
		
		return new ResponseEntity<>(service.getRoom(hotelno),HttpStatus.OK);
	}
	
	
	
	@ResponseBody
	@GetMapping(value="/rely.do", produces = {MediaType.APPLICATION_PROBLEM_JSON_UTF8_VALUE})
	public ResponseEntity< List<RelyVO>> relyList(int hotelno){
		
		
		log.info("get rely>>>>>>>>>>>>>>>>>>>>>>"+hotelno);
		
		return new ResponseEntity<>(service.getRely(hotelno),HttpStatus.OK);
		
	}
	
	

	
	
	
	
	
	
	
	
	
}
