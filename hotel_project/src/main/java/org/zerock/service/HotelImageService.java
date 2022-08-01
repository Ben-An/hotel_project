package org.zerock.service;

import java.util.List;


import org.zerock.domain.HotelVO;
import org.zerock.domain.MainVO;
import org.zerock.domain.ReplyListVO;



public interface HotelImageService {
	
	public List<MainVO> List();
	
	public List<ReplyListVO> replyList();
	

}
