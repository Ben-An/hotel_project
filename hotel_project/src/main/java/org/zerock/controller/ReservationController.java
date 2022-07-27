package org.zerock.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.PayRservationVO;
import org.zerock.service.ReservationService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/hotel/")
@AllArgsConstructor
@Log4j
public class ReservationController {

	@Autowired
	private ReservationService service;
	
	
	
	@GetMapping("/reservation")
	public void reservation(int roomno, Model model) {
		log.info("roomno>>>>>>>>>>"+roomno);
		
		model.addAttribute("reservationList", service.ReseravationList(roomno));
		
		log.info("model>>>>>>>>>>>>>>"+model);
		
	}
	
	
	
	

	
	@ResponseBody
	@PostMapping(value="/reservePayment",consumes = MediaType.APPLICATION_JSON_UTF8_VALUE, produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> reservePay(@RequestBody PayRservationVO payVO)
	{
		log.info(payVO);
		
		int result = service.payRegister(payVO);
		
		return result ==1 ? new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	@RequestMapping("/kakaoPay.cls")
	@ResponseBody
	public String kakaPay() {
		
		try {
			URL url = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Authorization", "KakaoAK e9a69f79dbf4f0106b16ac148df3b7a1");
			connection.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			connection.setDoOutput(true);
			String parameters="cid=TC0ONETIME&partner_order_id=partner_order_id&partner_user_id=partner_user_id&item_name=초코파이&quantity=1&total_amount=2200&vat_amount=200&tax_free_amount=0&approval_url=/localhost:8080/hotel/kakaoPay.cls&fail_url=https://localhost:8080/fail&cancel_url=https://localhost:8080/cancel";
			OutputStream given = connection.getOutputStream();
			DataOutputStream dataGiven = new DataOutputStream(given);
			dataGiven.writeBytes(parameters);
			dataGiven.close();

			int result = connection.getResponseCode();
			
			InputStream inputstream;
			if(result == 200) {
				inputstream = connection.getInputStream();
				
			}else {
				inputstream = connection.getErrorStream();
				
			}
			InputStreamReader inputStreamReader = new InputStreamReader(inputstream);
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
			/* log.info(bufferedReader.readLine()); */
			 
		     
			
			return bufferedReader.readLine();	
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}catch (IOException e) {
			e.printStackTrace();
		}
			
		
		return "{\"result\":\"NO\"}";
	}
	
	
	
	
	
	
	
	
}
