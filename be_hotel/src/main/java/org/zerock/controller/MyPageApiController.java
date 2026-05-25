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

	@GetMapping(value = "/wish/check", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Boolean> checkWish(@RequestParam int memberno, @RequestParam int hotelno) {
		return new ResponseEntity<>(service.isWished(memberno, hotelno), HttpStatus.OK);
	}

	@PostMapping(value = "/wish", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> addWish(@RequestParam int memberno, @RequestParam int hotelno) {
		return service.addWish(memberno, hotelno) ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@DeleteMapping(value = "/wish", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> removeWish(@RequestParam int memberno, @RequestParam int hotelno) {
		return service.removeWish(memberno, hotelno) ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@DeleteMapping(value = "/reservation/{reservationNo}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> cancelReservation(@PathVariable int reservationNo, @RequestParam int memberno) {
		return service.cancelReservation(reservationNo, memberno) ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
