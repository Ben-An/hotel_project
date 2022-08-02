package org.zerock.service;

import java.util.List;

import org.zerock.domain.AttachImageVO;
import org.zerock.domain.HotelVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.MyPageVO;
import org.zerock.domain.RelyVO;
import org.zerock.domain.SearchVO;

public interface AdminService {

	/* 숙소 등록 */
	public void hotelEnroll(HotelVO hotel);
	
	/* 숙소 리스트 */
	public List<HotelVO> adminHotelList();
	
	/* 숙소 총 개수 */
	public int hotelGetTotal();	
	
	/* 예약 숙소 리스트 */
	public List<MyPageVO> adminReservationList();
	
	/* 신고 리뷰 리스트 */
	public List<RelyVO> adminReviewList();
	
	/* 신고 리뷰 삭제 */
	public void reviewDelete(RelyVO rely) throws Exception;
	
}
