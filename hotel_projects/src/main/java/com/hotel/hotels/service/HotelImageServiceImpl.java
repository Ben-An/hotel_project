package com.hotel.hotels.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.common.mapper.HotelsMapper;
import com.hotel.hotels.vo.HotelImageVO;

import lombok.AllArgsConstructor;
import lombok.Setter;




@Service
@AllArgsConstructor
public class HotelImageServiceImpl implements HotelImageService {

	
	@Setter(onMethod_ =@Autowired)
	private HotelsMapper mapper;
	
	
	@Override
	public List<HotelImageVO> List()  {
		
		return mapper.getList();
		
	}

}
