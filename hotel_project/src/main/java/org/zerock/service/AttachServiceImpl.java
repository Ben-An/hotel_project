package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.AttachImageVO;
import org.zerock.mapper.AttachMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class AttachServiceImpl implements AttachService{

	@Autowired
	private AttachMapper attachMapper;
	
	/* 이미지 데이터 반환 */
	@Override
	public List<AttachImageVO> getAttachList(long hotelNo) {
		
		log.info("getAttachList.........");
		
		return attachMapper.getAttachList(hotelNo);
	}
}
