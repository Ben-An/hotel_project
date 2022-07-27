package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.DetailImage;
import org.zerock.domain.DetailVO;
import org.zerock.domain.ImageList;
import org.zerock.domain.PlaceVO;
import org.zerock.domain.RelyVO;

public interface DetailMapper {
	
	public DetailVO detailList(int hotelno);
	
	public List<DetailImage>listImage(int hotelno);
	
	public List<ImageList>roomList(int hotelno);
	
	public List<PlaceVO>placeList(int hotelno);
	
	public List<RelyVO>read(int hotelno);
	
	public boolean insert (RelyVO vo);
	
	
	//댓글 삭제
	public int delete(int reivewNo);
	
	
	//댓글 수정
	public int update (RelyVO vo);
	
	
	
	
	
	
	
	
}
