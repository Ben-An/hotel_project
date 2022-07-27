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
import org.zerock.domain.HotelImageVO;
import org.zerock.domain.RelyVO;
import org.zerock.domain.ReservationVO;
import org.zerock.domain.WishListVO;
import org.zerock.service.MyPageService;
import lombok.AllArgsConstructor;


@Controller
@RequestMapping("/member/*")
@AllArgsConstructor

public class MyPage {
	
	@Autowired
	private MyPageService service;


	@GetMapping(value = {"/myPage", "/myPage_memberUpdate", "/myPage_memberDelete","/myPage_reservationList", "myPage_reviewList", "myPage_wishList"})
	public void list(int memberno, Model model){
		
		System.out.println("model>>>>>>"+model);
	}
	
	@ResponseBody
	@GetMapping(value="/myReservationList.do",produces = {MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<ReservationVO>> getReservation(int memberno){
		
		return new ResponseEntity<>(service.getReservation(memberno),HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value="/myReviewList.do",produces = {MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<RelyVO>> getReview(int memberno){
		
		return new ResponseEntity<>(service.getReview(memberno),HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value="/myWishList.do",produces = {MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<WishListVO>> getWishList(int memberno){
		
		return new ResponseEntity<>(service.getWishList(memberno),HttpStatus.OK);
	}
	
	
	
}
