package org.zerock.service;

import java.util.List;

import org.zerock.domain.AttachImageVO;
import org.zerock.domain.HotelVO;
import org.zerock.domain.SearchVO;

public interface AdminService {

	/* 숙소 등록 */
	public void hotelEnroll(HotelVO hotel);
	
	/* 숙소 리스트 */
	public List<HotelVO> adminHotelList();
	
	/* 숙소 총 개수 */
	public int hotelGetTotal();	
	
}
