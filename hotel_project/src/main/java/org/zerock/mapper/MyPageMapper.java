package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.RelyVO;
import org.zerock.domain.ReservationVO;
import org.zerock.domain.WishListVO;

public interface MyPageMapper {
	public List<ReservationVO> myReservationList(int memberno);
	
	public List<RelyVO> myReviewList(int memberno);
	
	public List<WishListVO> myWishList(int memberno);
}
