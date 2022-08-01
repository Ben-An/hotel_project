package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.DetailImage;
import org.zerock.domain.DetailVO;
import org.zerock.domain.ImageList;
import org.zerock.domain.PlaceVO;
import org.zerock.domain.RelyVO;
import org.zerock.mapper.DetailMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class DetailServiceImpl implements DetailService {

	
	@Setter(onMethod_=@Autowired)
	private DetailMapper mapper;

	@Override
	public DetailVO detailList(int hotelno) {
	
		return mapper.detailList(hotelno);
	}

	@Override
	public List<DetailImage> getImage(int hotelno) {
		
		return mapper.listImage(hotelno);
	}

	@Override
	public List<ImageList> getRoom(int hotelno) {
		
		return mapper.roomList(hotelno);
	}

	@Override
	public List<PlaceVO> getPlace(int hotelno){
		return mapper.placeList(hotelno);
	}
	
	@Override
	public List<RelyVO> getRely(int hotelno) {
		
		return mapper.read(hotelno);
	}

	@Override
	public boolean register(RelyVO vo) {
		// TODO Auto-generated method stub
		 return mapper.insert(vo);
	}
	
	
	@Override
	public int delete(int reviewNo) {
		
		
		log.info("reviewNo>>>>"+reviewNo);
		
		
		return mapper.delete(reviewNo);
	}

	@Override
	public int modify(RelyVO vo) {
		log.info("modify vo>>>>>>>>>>>>>"+vo);
		
		return mapper.update(vo);
	}

	@Override
	public List<RelyVO> getReplyList(Criteria cri) {
		log.info("get List with criteria"+cri);
		List<RelyVO> list = mapper.getListWithPasing(cri);
		log.info("list mapper에서 보내준 list>>>>>>>>>>>"+list);
		
		return mapper.getListWithPasing(cri);
	}
	
	
	
}
