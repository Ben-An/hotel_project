package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.zerock.config.BackendConfig;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.DetailImage;
import org.zerock.domain.DetailVO;
import org.zerock.domain.HotelReasonVO;
import org.zerock.domain.ImageList;
import org.zerock.domain.PlaceVO;
import org.zerock.domain.RelyVO;
import org.zerock.domain.ReplyPageDTO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/hotel/*")
@Log4j
public class DetailController {

	@Autowired
	private RestTemplate restTemplate;

	private static final String API = BackendConfig.BACKEND_URL + "/hotel";

	@GetMapping("/detail")
	public void detailHotel(@RequestParam int hotelno, Model model) {
		DetailVO detail = restTemplate.getForObject(API + "/detail?hotelno=" + hotelno, DetailVO.class);
		model.addAttribute("detailList", detail);
	}

	@ResponseBody
	@GetMapping(value = "/list.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<DetailImage>> list(@RequestParam int hotelno) {
		List<DetailImage> result = restTemplate.exchange(
				API + "/list.do?hotelno=" + hotelno,
				HttpMethod.GET, null,
				new ParameterizedTypeReference<List<DetailImage>>() {}).getBody();
		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	@ResponseBody
	@GetMapping(value = "/imageList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ImageList>> roomList(@RequestParam int hotelno) {
		List<ImageList> result = restTemplate.exchange(
				API + "/imageList.do?hotelno=" + hotelno,
				HttpMethod.GET, null,
				new ParameterizedTypeReference<List<ImageList>>() {}).getBody();
		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	@ResponseBody
	@GetMapping(value = "/place.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<PlaceVO>> placeList(@RequestParam int hotelno) {
		List<PlaceVO> result = restTemplate.exchange(
				API + "/place.do?hotelno=" + hotelno,
				HttpMethod.GET, null,
				new ParameterizedTypeReference<List<PlaceVO>>() {}).getBody();
		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	@ResponseBody
	@PostMapping(value = "/new.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> create(@RequestBody RelyVO vo) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<RelyVO> entity = new HttpEntity<>(vo, headers);
		String result = restTemplate.postForObject(API + "/new.do", entity, String.class);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	@ResponseBody
	@DeleteMapping(value = "/{reviewNo}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> delete(@PathVariable("reviewNo") int reviewNo) {
		restTemplate.delete(API + "/review/" + reviewNo);
		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	@ResponseBody
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value = "/{reviewNo}",
			consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@RequestBody RelyVO vo, @PathVariable("reviewNo") int reviewNo) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		vo.setReviewNo(reviewNo);
		HttpEntity<RelyVO> entity = new HttpEntity<>(vo, headers);
		restTemplate.put(API + "/review/" + reviewNo, entity);
		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	@ResponseBody
	@GetMapping(value = "/pages/{hotelno}/{page}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("hotelno") int hotelno) {
		ReplyPageDTO result = restTemplate.getForObject(
				API + "/pages/" + hotelno + "/" + page, ReplyPageDTO.class);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	/* ===== Admin: Room CRUD ===== */

	@ResponseBody
	@PostMapping(value = "/room", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> insertRoom(@RequestBody ImageList room) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<ImageList> entity = new HttpEntity<>(room, headers);
		String result = restTemplate.postForObject(API + "/room", entity, String.class);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	@ResponseBody
	@PutMapping(value = "/room", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> updateRoom(@RequestBody ImageList room) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<ImageList> entity = new HttpEntity<>(room, headers);
		restTemplate.put(API + "/room", entity);
		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	@ResponseBody
	@DeleteMapping(value = "/room/{roomno}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> deleteRoom(@PathVariable("roomno") int roomno) {
		restTemplate.delete(API + "/room/" + roomno);
		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	/* ===== Admin: Hotel Image CRUD ===== */

	@ResponseBody
	@DeleteMapping(value = "/image/{hotelImageId}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> deleteImage(@PathVariable("hotelImageId") int hotelImageId) {
		restTemplate.delete(API + "/image/" + hotelImageId);
		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	@ResponseBody
	@PostMapping(value = "/image", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> insertImage(@RequestBody AttachImageVO vo) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<AttachImageVO> entity = new HttpEntity<>(vo, headers);
		String result = restTemplate.postForObject(API + "/image", entity, String.class);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	/* ===== 좋아하는 이유 CRUD ===== */

	@ResponseBody
	@GetMapping(value = "/reason", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<HotelReasonVO>> reasonList(@RequestParam int hotelno) {
		List<HotelReasonVO> result = restTemplate.exchange(
				API + "/reason?hotelno=" + hotelno,
				HttpMethod.GET, null,
				new ParameterizedTypeReference<List<HotelReasonVO>>() {}).getBody();
		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	@ResponseBody
	@PostMapping(value = "/reason", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> insertReason(@RequestBody HotelReasonVO vo) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<HotelReasonVO> entity = new HttpEntity<>(vo, headers);
		String result = restTemplate.postForObject(API + "/reason", entity, String.class);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	@ResponseBody
	@PutMapping(value = "/reason", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> updateReason(@RequestBody HotelReasonVO vo) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<HotelReasonVO> entity = new HttpEntity<>(vo, headers);
		restTemplate.put(API + "/reason", entity);
		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	@ResponseBody
	@DeleteMapping(value = "/reason/{reasonNo}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> deleteReason(@PathVariable("reasonNo") int reasonNo) {
		restTemplate.delete(API + "/reason/" + reasonNo);
		return new ResponseEntity<>("success", HttpStatus.OK);
	}
}
