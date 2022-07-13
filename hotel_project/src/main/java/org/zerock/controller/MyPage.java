package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.service.MyPageService;
import lombok.AllArgsConstructor;


@Controller
@RequestMapping("/member/*")
@AllArgsConstructor

public class MyPage {
	
	@Autowired
	private MyPageService service;


	@GetMapping(value = {"/myPage", "/myPage_memberUpdate", "/myPage_memberDelete","/myPage_reservationList", "myPage_reviewList", "myPage_wishList"})
	public void list(Model model){
		
		model.addAttribute("myPageList",service.List());
		
		
		System.out.println("model>>>>>>"+model);
	}
	
	
	
	
}
