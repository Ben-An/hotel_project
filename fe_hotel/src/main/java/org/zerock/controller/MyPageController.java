package org.zerock.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.zerock.config.BackendConfig;
import org.zerock.domain.MemberVO;
import org.zerock.domain.RelyVO;
import org.zerock.domain.ReservationVO;
import org.zerock.domain.WishListVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@Log4j
public class MyPageController {

	@Autowired
	private RestTemplate restTemplate;

	private static final String API = BackendConfig.BACKEND_URL + "/member";

	@GetMapping(value = {"/myPage", "/myPage_memberUpdate", "/myPage_memberDelete",
			"/myPage_reservationList", "myPage_reviewList", "myPage_wishList"})
	public String list(@RequestParam(required = false) Integer memberno, Model model, HttpSession session) {
		if (memberno == null) {
			MemberVO member = (MemberVO) session.getAttribute("member");
			if (member == null) {
				return "redirect:/member/login";
			}
			memberno = member.getMemberNo();
		}
		model.addAttribute("memberno", memberno);
		return null; // 기본 view name 사용
	}

	@ResponseBody
	@GetMapping(value = "/myReservationList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ReservationVO>> getReservation(@RequestParam int memberno) {
		List<ReservationVO> list = restTemplate.exchange(
				API + "/myReservationList?memberno=" + memberno,
				HttpMethod.GET, null,
				new ParameterizedTypeReference<List<ReservationVO>>() {}).getBody();
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	@ResponseBody
	@GetMapping(value = "/myReviewList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<RelyVO>> getReview(@RequestParam int memberno) {
		List<RelyVO> list = restTemplate.exchange(
				API + "/myReviewList?memberno=" + memberno,
				HttpMethod.GET, null,
				new ParameterizedTypeReference<List<RelyVO>>() {}).getBody();
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	@ResponseBody
	@GetMapping(value = "/myWishList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<WishListVO>> getWishList(@RequestParam int memberno) {
		List<WishListVO> list = restTemplate.exchange(
				API + "/myWishList?memberno=" + memberno,
				HttpMethod.GET, null,
				new ParameterizedTypeReference<List<WishListVO>>() {}).getBody();
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
}
