package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.HotelImageVO;
import org.zerock.domain.HotelVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.MainVO;
import org.zerock.domain.ReplyListVO;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;




@Service
@AllArgsConstructor
public class HotelImageServiceImpl implements HotelImageService {

	
	@Setter(onMethod_ =@Autowired)
	private BoardMapper mapper;
	
	
	@Override
	public List<MainVO> List(Criteria cri) {
		return mapper.imageList(cri);
	}

	@Override
	public int getTotal() {
		return mapper.imageListCount();
	}


	@Override
	public java.util.List<ReplyListVO> replyList() {

		return mapper.replyList();
	}

}
