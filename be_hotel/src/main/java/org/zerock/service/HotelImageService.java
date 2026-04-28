package org.zerock.service;

import java.util.List;


import org.zerock.domain.HotelVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.MainVO;
import org.zerock.domain.ReplyListVO;



public interface HotelImageService {

	public List<MainVO> List(Criteria cri);

	public int getTotal();

	public List<ReplyListVO> replyList();
	

}
