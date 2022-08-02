package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.HotelVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.MyPageVO;
import org.zerock.domain.RelyVO;
import org.zerock.domain.SearchVO;
import org.zerock.mapper.AdminMapper;
import org.zerock.mapper.AttachMapper;
import org.zerock.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class AdminServiceImpl implements AdminService{

	@Autowired
	private AdminMapper adminMapper;	
	@Autowired
	private AttachMapper attachMapper;
	
	/* 숙소 등록 */
	@Override
	public void hotelEnroll(HotelVO hotel) {
		
		log.info("(service)hotelEnroll........");
		
		adminMapper.HotelEnroll(hotel);
		
		//사용자가 이미지 첨부하지 않은경우 조기 종료
		if(hotel.getImageList() == null || hotel.getImageList().size() <= 0) {
			return;
		}
		
		hotel.getImageList().forEach(attach ->{
			attach.setHotelNo(hotel.getHotelNo());
			adminMapper.imageEnroll(attach);
		});
		
	}

	/* 숙소 리스트 */
	@Override
	public List<HotelVO> adminHotelList() {
		log.info("adminHotelList()..........");
		
		List<HotelVO> list = adminMapper.adminHotelList();
		
		return adminMapper.adminHotelList();
	}
	/* 숙소 총 갯수 */
	public int hotelGetTotal() {
		log.info("hotelGetTotal().........");
		return adminMapper.hotelGetTotal();
	}	
	
	/* 예약 숙소 리스트 */
	@Override
	public List<MyPageVO> adminReservationList() {
		log.info("adminReservationList()..........");
		
		List<MyPageVO> list = adminMapper.adminReservationList();
		log.info(list);
		
		return adminMapper.adminReservationList();
	}
	
	/* 신고 리뷰 리스트 */
	@Override
	public List<RelyVO> adminReviewList() {
		log.info("adminReviewList()..........");
		
		List<RelyVO> list = adminMapper.adminReviewList();
		log.info(list);

		return adminMapper.adminReviewList();
	}
	
	/* 신고 리뷰 삭제 */
	@Override
	public void reviewDelete(RelyVO rely) throws Exception {
		adminMapper.reviewDelete(rely);	
	}
	
}
