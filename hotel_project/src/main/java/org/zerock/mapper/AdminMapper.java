package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.AttachImageVO;
import org.zerock.domain.HotelVO;
import org.zerock.domain.SearchVO;

public interface AdminMapper {

	/* 숙소 등록 */
	public void HotelEnroll(HotelVO hotel);
	
	/* 숙소 리스트 */
	public List<HotelVO> adminHotelList();
	
	/* 상품 총 개수 */
	public int hotelGetTotal();
	
	/* 호텔 이미지 등록 */
	public void imageEnroll(AttachImageVO vo);
	
}
