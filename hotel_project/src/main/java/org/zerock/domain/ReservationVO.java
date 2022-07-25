package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReservationVO {
	
	private String realhotelname;
	private String roomname;
	private Date checkIndate;
	private Date checkOutDate;
	private String roomPrice;
	private int roomguest;

}
