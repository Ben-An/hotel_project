package org.zerock.service;

import java.util.List;

import org.zerock.domain.DetailImage;
import org.zerock.domain.DetailVO;
import org.zerock.domain.ImageList;
import org.zerock.domain.RelyVO;

public interface DetailService {
	
	public DetailVO detailList(int hotelno);
	
	public List<DetailImage> getImage(int hotelno);
	
	
	public List<ImageList> getRoom(int hotelno);
	
	public List<RelyVO> getRely(int hotelno);
	
	public boolean register(RelyVO vo);
	

	//댓글 삭제
	public int delete(int reviewNo);
	
	
	//댓글 수정
	public int modify(RelyVO vo);
	
	
}
