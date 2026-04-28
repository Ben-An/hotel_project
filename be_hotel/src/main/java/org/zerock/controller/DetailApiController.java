package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.DetailImage;
import org.zerock.domain.DetailVO;
import org.zerock.domain.HotelReasonVO;
import org.zerock.domain.ImageList;
import org.zerock.domain.PlaceVO;
import org.zerock.domain.RelyVO;
import org.zerock.domain.ReplyCriteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.service.DetailService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/hotel")
public class DetailApiController {

	@Autowired
	private DetailService service;

	@GetMapping("/detail")
	public ResponseEntity<DetailVO> detailHotel(@RequestParam int hotelno) {
		return new ResponseEntity<>(service.detailList(hotelno), HttpStatus.OK);
	}

	@GetMapping(value = "/list.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<DetailImage>> list(@RequestParam int hotelno) {
		return new ResponseEntity<>(service.getImage(hotelno), HttpStatus.OK);
	}

	@GetMapping(value = "/imageList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ImageList>> roomList(@RequestParam int hotelno) {
		return new ResponseEntity<>(service.getRoom(hotelno), HttpStatus.OK);
	}

	@GetMapping(value = "/place.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<PlaceVO>> placeList(@RequestParam int hotelno) {
		return new ResponseEntity<>(service.getPlace(hotelno), HttpStatus.OK);
	}

	@PostMapping(value = "/new.do", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> create(@Valid @RequestBody RelyVO vo) {
		boolean result = service.register(vo);
		return result ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@DeleteMapping(value = "/review/{reviewNo}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> delete(@PathVariable("reviewNo") int reviewNo) {
		return service.delete(reviewNo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PutMapping(value = "/review/{reviewNo}", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@Valid @RequestBody RelyVO vo, @PathVariable("reviewNo") int reviewNo) {
		vo.setReviewNo(reviewNo);
		return service.modify(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@GetMapping(value = "/pages/{hotelno}/{page}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("hotelno") int hotelno) {
		ReplyCriteria cri = new ReplyCriteria(page, 10);
		return new ResponseEntity<>(service.getListPage(cri, hotelno), HttpStatus.OK);
	}

	/* ===== Admin: Room CRUD ===== */

	@PostMapping(value = "/room", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> insertRoom(@RequestBody ImageList room) {
		return service.insertRoom(room) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PutMapping(value = "/room", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> updateRoom(@RequestBody ImageList room) {
		return service.updateRoom(room) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@DeleteMapping(value = "/room/{roomno}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> deleteRoom(@PathVariable("roomno") int roomno) {
		return service.deleteRoom(roomno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	/* ===== Admin: Hotel Image CRUD ===== */

	@DeleteMapping(value = "/image/{hotelImageId}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> deleteImage(@PathVariable("hotelImageId") int hotelImageId) {
		return service.deleteImage(hotelImageId) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PostMapping(value = "/image", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> insertImage(@RequestBody AttachImageVO vo) {
		return service.insertImage(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	/* ===== 좋아하는 이유 CRUD ===== */

	@GetMapping(value = "/reason", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<HotelReasonVO>> reasonList(@RequestParam int hotelno) {
		return new ResponseEntity<>(service.getReasonList(hotelno), HttpStatus.OK);
	}

	@PostMapping(value = "/reason", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> insertReason(@RequestBody HotelReasonVO vo) {
		return service.insertReason(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PutMapping(value = "/reason", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> updateReason(@RequestBody HotelReasonVO vo) {
		return service.updateReason(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@DeleteMapping(value = "/reason/{reasonNo}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> deleteReason(@PathVariable("reasonNo") int reasonNo) {
		return service.deleteReason(reasonNo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
