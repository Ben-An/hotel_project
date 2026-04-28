package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.zerock.config.BackendConfig;
import org.zerock.domain.PayRservationVO;
import org.zerock.domain.ReservationVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/hotel/")
@Log4j
public class ReservationController {

	@Autowired
	private RestTemplate restTemplate;

	private static final String API = BackendConfig.BACKEND_URL + "/hotel";

	@GetMapping("/reservation")
	public void reservation(@RequestParam int roomno, Model model) {
		ReservationVO result = restTemplate.getForObject(API + "/reservation?roomno=" + roomno, ReservationVO.class);
		model.addAttribute("reservationList", result);
	}

	@ResponseBody
	@PostMapping(value = "/reservePayment", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> reservePay(@RequestBody PayRservationVO payVO) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<PayRservationVO> entity = new HttpEntity<>(payVO, headers);
		String result = restTemplate.postForObject(API + "/reservePayment", entity, String.class);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	@RequestMapping("/kakaoPay.cls")
	@ResponseBody
	public String kakaoPay() {
		return restTemplate.postForObject(API + "/kakaoPay", null, String.class);
	}
}
