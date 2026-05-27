package org.zerock.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
	public String list(@RequestParam(required = false) Integer memberno, Model model,
			HttpSession session, HttpServletRequest request) {
		if (memberno == null) {
			MemberVO member = (MemberVO) session.getAttribute("member");
			if (member == null) {
				return "redirect:/member/login";
			}
			memberno = member.getMemberNo();
		}
		model.addAttribute("memberno", memberno);

		// 경로별로 be 데이터를 모델에 주입(서버사이드 렌더링). JSP는 <c:forEach>로 소비한다.
		String path = request.getServletPath();
		if (path.endsWith("/myPage")) {
			model.addAttribute("myReservationList", fetchReservations(memberno));
			model.addAttribute("myReviewList", fetchReviews(memberno));
			model.addAttribute("myWishList", fetchWishList(memberno));
		} else if (path.endsWith("/myPage_reservationList")) {
			model.addAttribute("myPageList", fetchReservations(memberno));
		} else if (path.endsWith("/myPage_reviewList")) {
			model.addAttribute("myPageList", fetchReviews(memberno));
		} else if (path.endsWith("/myPage_wishList")) {
			model.addAttribute("myPageList", fetchWishList(memberno));
		}
		return null; // 기본 view name 사용
	}

	/* ===== be 조회 헬퍼 — 실패 시 빈 목록으로 graceful 처리(화면은 정상 렌더) ===== */

	private List<ReservationVO> fetchReservations(int memberno) {
		try {
			return restTemplate.exchange(API + "/myReservationList?memberno=" + memberno,
					HttpMethod.GET, null,
					new ParameterizedTypeReference<List<ReservationVO>>() {}).getBody();
		} catch (Exception e) {
			log.warn("예약 목록 조회 실패 memberno=" + memberno + " : " + e.getMessage());
			return java.util.Collections.emptyList();
		}
	}

	private List<RelyVO> fetchReviews(int memberno) {
		try {
			return restTemplate.exchange(API + "/myReviewList?memberno=" + memberno,
					HttpMethod.GET, null,
					new ParameterizedTypeReference<List<RelyVO>>() {}).getBody();
		} catch (Exception e) {
			log.warn("리뷰 목록 조회 실패 memberno=" + memberno + " : " + e.getMessage());
			return java.util.Collections.emptyList();
		}
	}

	private List<WishListVO> fetchWishList(int memberno) {
		try {
			return restTemplate.exchange(API + "/myWishList?memberno=" + memberno,
					HttpMethod.GET, null,
					new ParameterizedTypeReference<List<WishListVO>>() {}).getBody();
		} catch (Exception e) {
			log.warn("찜 목록 조회 실패 memberno=" + memberno + " : " + e.getMessage());
			return java.util.Collections.emptyList();
		}
	}

	@ResponseBody
	@GetMapping(value = "/myReservationList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ReservationVO>> getReservation(@RequestParam int memberno) {
		return new ResponseEntity<>(fetchReservations(memberno), HttpStatus.OK);
	}

	@ResponseBody
	@GetMapping(value = "/myReviewList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<RelyVO>> getReview(@RequestParam int memberno) {
		return new ResponseEntity<>(fetchReviews(memberno), HttpStatus.OK);
	}

	@ResponseBody
	@GetMapping(value = "/myWishList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<WishListVO>> getWishList(@RequestParam int memberno) {
		return new ResponseEntity<>(fetchWishList(memberno), HttpStatus.OK);
	}

	/* ===== 찜(위시리스트) 토글 — 세션 회원 기준 ===== */

	@ResponseBody
	@GetMapping(value = "/wish/check", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Boolean> checkWish(@RequestParam int hotelNo, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		if (member == null) {
			return new ResponseEntity<>(false, HttpStatus.OK);
		}
		Boolean wished = restTemplate.getForObject(
				API + "/wish/check?memberno=" + member.getMemberNo() + "&hotelno=" + hotelNo,
				Boolean.class);
		return new ResponseEntity<>(Boolean.TRUE.equals(wished), HttpStatus.OK);
	}

	@ResponseBody
	@PostMapping(value = "/wish", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> addWish(@RequestParam int hotelNo, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		if (member == null) {
			return new ResponseEntity<>("login", HttpStatus.UNAUTHORIZED);
		}
		restTemplate.postForObject(
				API + "/wish?memberno=" + member.getMemberNo() + "&hotelno=" + hotelNo,
				null, String.class);
		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	@ResponseBody
	@DeleteMapping(value = "/wish", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> removeWish(@RequestParam int hotelNo, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		if (member == null) {
			return new ResponseEntity<>("login", HttpStatus.UNAUTHORIZED);
		}
		restTemplate.delete(API + "/wish?memberno=" + member.getMemberNo() + "&hotelno=" + hotelNo);
		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	/* ===== 예약 취소 — 세션 회원 기준(본인 예약만) ===== */

	@ResponseBody
	@DeleteMapping(value = "/reservation/{reservationNo}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> cancelReservation(@PathVariable int reservationNo, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		if (member == null) {
			return new ResponseEntity<>("login", HttpStatus.UNAUTHORIZED);
		}
		restTemplate.delete(API + "/reservation/" + reservationNo + "?memberno=" + member.getMemberNo());
		return new ResponseEntity<>("success", HttpStatus.OK);
	}
}
