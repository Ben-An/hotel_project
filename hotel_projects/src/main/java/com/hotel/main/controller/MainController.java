package com.hotel.main.controller;



import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hotel.hotels.service.HotelImageService;
import com.hotel.hotels.vo.HotelImageVO;

import lombok.AllArgsConstructor;



@Controller
@RequestMapping("/main/*")
@AllArgsConstructor


public class MainController {
	
	private HotelImageService service;
	
	@GetMapping("/index")
	public void list( ){
		
		
		
//		
//		System.out.println("hotel>>>>>>>"+hotelImage);
//	
//		 model.addAttribute("list", service.getList());
}
	
	
	@GetMapping(value="/getList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	@ResponseBody
	public ResponseEntity<List<HotelImageVO>> getList(HotelImageVO imagefile){
		
		System.out.println("hotelImage >>>>"+imagefile);
		
		return new ResponseEntity<>(service.getList(imagefile), HttpStatus.OK );
		
	}
	
	
	
	
}
