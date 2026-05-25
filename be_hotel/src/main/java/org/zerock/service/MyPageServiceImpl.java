package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.MyPageVO;
import org.zerock.domain.RelyVO;
import org.zerock.domain.ReservationVO;
import org.zerock.domain.WishListVO;
import org.zerock.mapper.MyPageMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class MyPageServiceImpl implements MyPageService {

	
	@Setter(onMethod_ =@Autowired)
	private MyPageMapper mapper;	
	
	@Override
	public List<ReservationVO> getReservation(int memberno)  {
		
		return mapper.myReservationList(memberno);
		
	}
	
	@Override
	public List<RelyVO> getReview(int memberno)  {
		
		return mapper.myReviewList(memberno);
		
	}
	
	@Override
	public List<WishListVO> getWishList(int memberno)  {

		return mapper.myWishList(memberno);

	}

	@Override
	public boolean isWished(int memberNo, int hotelNo) {
		return mapper.existsWish(memberNo, hotelNo) > 0;
	}

	@Transactional
	@Override
	public boolean addWish(int memberNo, int hotelNo) {
		// 중복 찜 방지 (이미 있으면 성공으로 간주)
		if (mapper.existsWish(memberNo, hotelNo) > 0) {
			return true;
		}
		return mapper.insertWish(memberNo, hotelNo) == 1;
	}

	@Transactional
	@Override
	public boolean removeWish(int memberNo, int hotelNo) {
		// 멱등: 이미 없어도 성공으로 간주
		mapper.deleteWish(memberNo, hotelNo);
		return true;
	}

	@Transactional
	@Override
	public boolean cancelReservation(int reservationNo, int memberNo) {
		// 본인 예약만 삭제됨(매퍼에서 memberNo 조건). 1건 삭제 성공 시 true.
		return mapper.deleteReservation(reservationNo, memberNo) == 1;
	}

}
