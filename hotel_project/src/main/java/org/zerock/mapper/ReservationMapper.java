package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.PayRservationVO;
import org.zerock.domain.ReservationVO;

public interface ReservationMapper {
	
	public ReservationVO reservationList(int roomno);
	
	//예약하기 하고 저정하기
	public int insert(PayRservationVO payVO);
	
	
}
