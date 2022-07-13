package org.zerock.service;

import java.util.List;

import org.zerock.domain.DetailImage;
import org.zerock.domain.DetailVO;
import org.zerock.domain.ImageList;

public interface DetailService {
	
	public DetailVO detailList(int hotelno);
	
	public List<DetailImage> getImage(int hotelno);
	
	
	public List<ImageList> getRoom(int hotelno);
	

	
	
}
