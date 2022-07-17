package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.DetailImage;
import org.zerock.domain.DetailVO;
import org.zerock.domain.ImageList;
import org.zerock.domain.RelyVO;
import org.zerock.mapper.DetailMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class DetailServiceImpl implements DetailService {

	
	@Setter(onMethod_=@Autowired)
	private DetailMapper mapper;

	@Override
	public DetailVO detailList(int hotelno) {
	
		return mapper.detailList(hotelno);
	}

	@Override
	public List<DetailImage> getImage(int hotelno) {
		
		return mapper.listImage(hotelno);
	}

	@Override
	public List<ImageList> getRoom(int hotelno) {
		
		return mapper.roomList(hotelno);
	}

	@Override
	public List<RelyVO> getRely(int hotelno) {
		
		return mapper.read(hotelno);
	}
	
	
	
}
