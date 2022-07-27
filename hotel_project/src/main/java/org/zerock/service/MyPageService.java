package org.zerock.service;

import java.util.List;

import org.zerock.domain.MemberVO;
import org.zerock.domain.MyPageVO;
import org.zerock.domain.RelyVO;
import org.zerock.domain.ReservationVO;
import org.zerock.domain.WishListVO;

public interface MyPageService {
	
	public List<ReservationVO> getReservation(int memberno);
	
	public List<RelyVO> getReview(int memberno);
	
	public List<WishListVO> getWishList(int memberno);

}
