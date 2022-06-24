package com.hotel.hotels.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hotel.common.mapper.HotelsMapper;
import com.hotel.hotels.vo.HotelImageVO;

import lombok.Setter;




@Service
public class HotelImageServiceImpl implements HotelImageService {

	
	@Setter(onMethod_ =@Autowired)
	private HotelsMapper mapper;
	
	@Transactional
	@Override
	public List<HotelImageVO> getList(HotelImageVO imagefile) {
		
		return mapper.getList(imagefile);
		
	}

}
