package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.DetailImage;
import org.zerock.domain.DetailVO;
import org.zerock.domain.ImageList;

public interface DetailMapper {
	
	public DetailVO detailList(int hotelno);
	
	public List<DetailImage>listImage(int hotelno);
	
	public List<ImageList>roomList(int hotelno);
	
	
	
	
	
	
}
