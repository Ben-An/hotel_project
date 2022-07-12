package org.zerock.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.HotelApiVO;
import org.zerock.domain.MapVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.MapMapper;


import lombok.AllArgsConstructor;
import lombok.Setter;

import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class MapServiceImpl implements MapService {
	
	@Setter(onMethod_ =@Autowired)
	private MapMapper map;

	@Override
	public List<MapVO> mapSelect(String state) {
	
		log.info("get>>>>>>>>>>>>>>>>>>>>>>"+ state);
		return map.mapSelect(state);
	}

	@Override
	public void insertInfo(HotelApiVO hotelDTO) {
		map.insertInfo(hotelDTO);
		
		//log.info("get>>>>>>>>>>>>>>>>>>>>>>"+ hotelDTO);
		
	}
 
	@Override
	public List<HotelApiVO> hotelList() {
		
		return map.hotelList();
	}



	
	
	


	
	

	
	

}
