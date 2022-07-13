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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.HotelImageVO;
import org.zerock.domain.HotelVO;
import org.zerock.service.HotelImageService;

import lombok.AllArgsConstructor;



@Controller
@RequestMapping("/hotel/*")
@AllArgsConstructor


public class MainController {
	
	@Autowired
	private HotelImageService service;


	@GetMapping("/index")
	public void list(Model model){
		
		model.addAttribute("list",service.List());
		
		System.out.println("model>>>>>>"+model);
	
		

		
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
