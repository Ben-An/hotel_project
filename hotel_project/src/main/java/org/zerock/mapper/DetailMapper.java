package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.DetailImage;
import org.zerock.domain.DetailVO;

public interface DetailMapper {
	
	public List<DetailVO> detailList(int hotelno);
	
	public List<DetailImage> listImage(int hotelno);
	
	
	
	
	
}
