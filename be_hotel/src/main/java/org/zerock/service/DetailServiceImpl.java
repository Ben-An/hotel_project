package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.DetailImage;
import org.zerock.domain.DetailVO;
import org.zerock.domain.HotelReasonVO;
import org.zerock.domain.ImageList;
import org.zerock.domain.PlaceVO;
import org.zerock.domain.RelyVO;
import org.zerock.domain.ReplyCriteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.mapper.DetailMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Service
@AllArgsConstructor
@Slf4j
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
	public ReplyPageDTO getListPage(ReplyCriteria cri, int hotelno) {
		return new ReplyPageDTO(mapper.getReplyByHotelno(hotelno), mapper.getListWithPasing(cri, hotelno));
	}

	@Override
	public int insertRoom(ImageList room) {
		return mapper.insertRoom(room);
	}

	@Override
	public int updateRoom(ImageList room) {
		return mapper.updateRoom(room);
	}

	@Override
	public int deleteRoom(int roomno) {
		return mapper.deleteRoom(roomno);
	}

	@Override
	public int deleteImage(int hotelImageId) {
		return mapper.deleteImage(hotelImageId);
	}

	@Override
	public int insertImage(AttachImageVO vo) {
		return mapper.insertImage(vo);
	}

	@Override
	public List<HotelReasonVO> getReasonList(int hotelNo) {
		return mapper.reasonList(hotelNo);
	}

	@Override
	public HotelReasonVO getReason(int reasonNo) {
		return mapper.getReason(reasonNo);
	}

	@Override
	public int insertReason(HotelReasonVO vo) {
		return mapper.insertReason(vo);
	}

	@Override
	public int updateReason(HotelReasonVO vo) {
		return mapper.updateReason(vo);
	}

	@Override
	public int deleteReason(int reasonNo) {
		return mapper.deleteReason(reasonNo);
	}
}
