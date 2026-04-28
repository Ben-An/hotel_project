package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.HotelApiVO;
import org.zerock.domain.MapVO;

public interface MapMapper {


	public  List<MapVO> mapSelect(String state);

	public List<MapVO> nearbySelect(@Param("lat") double lat, @Param("lng") double lng, @Param("radius") double radius);

	void insertInfo(HotelApiVO hotelDTO);


	public List<HotelApiVO> hotelList();
	
	
}
