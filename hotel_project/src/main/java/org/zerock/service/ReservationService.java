package org.zerock.service;

import java.util.List;

import org.zerock.domain.PayRservationVO;
import org.zerock.domain.ReservationVO;

public interface ReservationService {

	public ReservationVO ReseravationList(int roomno);
	
	public int payRegister(PayRservationVO payVO);
	
}
