package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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

	
	

}
