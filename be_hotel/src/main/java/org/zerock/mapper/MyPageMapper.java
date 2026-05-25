package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.RelyVO;
import org.zerock.domain.ReservationVO;
import org.zerock.domain.WishListVO;

public interface MyPageMapper {
	public List<ReservationVO> myReservationList(int memberno);

	public List<RelyVO> myReviewList(int memberno);

	public List<WishListVO> myWishList(int memberno);

	public int existsWish(@Param("memberNo") int memberNo, @Param("hotelNo") int hotelNo);

	public int insertWish(@Param("memberNo") int memberNo, @Param("hotelNo") int hotelNo);

	public int deleteWish(@Param("memberNo") int memberNo, @Param("hotelNo") int hotelNo);

	public int deleteReservation(@Param("reservationNo") int reservationNo, @Param("memberNo") int memberNo);
}
