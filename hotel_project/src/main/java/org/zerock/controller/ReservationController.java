package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/hotel/")
@AllArgsConstructor
@Log4j
public class ReservationController {

	
	@GetMapping("/reservation")
	public void reservation() {
		
		
	}
	
	
	
}
