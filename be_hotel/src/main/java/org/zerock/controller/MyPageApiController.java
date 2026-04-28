package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.zerock.domain.RelyVO;
import org.zerock.domain.ReservationVO;
import org.zerock.domain.WishListVO;
import org.zerock.service.MyPageService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/member")
public class MyPageApiController {

	@Autowired
	private MyPageService service;

	@GetMapping(value = "/myReservationList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ReservationVO>> getReservation(@RequestParam int memberno) {
		return new ResponseEntity<>(service.getReservation(memberno), HttpStatus.OK);
	}

	@GetMapping(value = "/myReviewList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<RelyVO>> getReview(@RequestParam int memberno) {
		return new ResponseEntity<>(service.getReview(memberno), HttpStatus.OK);
	}

	@GetMapping(value = "/myWishList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<WishListVO>> getWishList(@RequestParam int memberno) {
		return new ResponseEntity<>(service.getWishList(memberno), HttpStatus.OK);
	}
}
