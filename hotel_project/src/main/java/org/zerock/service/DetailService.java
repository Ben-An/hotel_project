package org.zerock.service;

import java.util.List;

import org.zerock.domain.DetailImage;
import org.zerock.domain.DetailVO;

public interface DetailService {
	
	public List<DetailVO> detailList(int hotelno);
	
	public List<DetailImage> getImage(int hotelno);
	

	
	
}
