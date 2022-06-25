package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.HotelImageVO;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;




@Service
@AllArgsConstructor
public class HotelImageServiceImpl implements HotelImageService {

	
	@Setter(onMethod_ =@Autowired)
	private BoardMapper mapper;
	
	
	@Override
	public List<HotelImageVO> List()  {
		
		return mapper.imageList();
		
	}

}
