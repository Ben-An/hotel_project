package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.HotelApiVO;
import org.zerock.domain.MapVO;

public interface MapMapper {
	
	
	public  List<MapVO> mapSelect(String state);
	
	void insertInfo(HotelApiVO hotelDTO);
	
	
	public List<HotelApiVO> hotelList();
	
	
}
