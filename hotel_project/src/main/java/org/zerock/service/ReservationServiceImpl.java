package org.zerock.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.PayRservationVO;
import org.zerock.domain.ReservationVO;
import org.zerock.mapper.ReservationMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class ReservationServiceImpl implements ReservationService {
	
	
	@Setter(onMethod_=@Autowired)
	private ReservationMapper mapper;

	@Override
	public ReservationVO ReseravationList(int roomno) {
		
		log.info("roomno>>>>>>>>>>"+roomno);
		
		return mapper.reservationList(roomno);
	}

	@Override
	public int payRegister(PayRservationVO payVO) {
		
		

		
		
		return mapper.insert(payVO);
	}
	
	
	
}
