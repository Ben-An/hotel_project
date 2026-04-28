package org.zerock.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.xml.sax.SAXException;
import org.zerock.domain.HotelApiVO;
import org.zerock.domain.MapVO;
import org.zerock.service.MapService;
import org.zerock.util.HotelInfoExplorer;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/map")
public class MapApiController {

	@Autowired
	private MapService service;

	@GetMapping("/mapside")
	public ResponseEntity<List<MapVO>> mapList(@RequestParam("state") String state) {
		return new ResponseEntity<>(service.mapSelect(state), HttpStatus.OK);
	}

	@GetMapping("/nearby")
	public ResponseEntity<List<MapVO>> nearbyList(
			@RequestParam("lat") double lat,
			@RequestParam("lng") double lng,
			@RequestParam(value = "radius", defaultValue = "10") double radius) {
		return new ResponseEntity<>(service.nearbySelect(lat, lng, radius), HttpStatus.OK);
	}

	@GetMapping("/searchList")
	public ResponseEntity<Map<String, Object>> searchInfo() throws IOException, ParserConfigurationException, SAXException {
		HotelInfoExplorer apiExplorer = new HotelInfoExplorer();
		List<HotelApiVO> list = apiExplorer.parsingData();
		for (HotelApiVO dataDTO : list) {
			service.insertInfo(dataDTO);
		}
		Map<String, Object> result = new HashMap<>();
		result.put("hotelList", service.hotelList());
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
}
