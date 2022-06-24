package com.hotel.common.mapper;

import java.util.List;

import com.hotel.hotels.vo.HotelImageVO;

public interface HotelsMapper {
	
	public List<HotelImageVO> getList(HotelImageVO imagefile);
}
