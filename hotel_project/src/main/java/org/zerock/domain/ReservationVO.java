package org.zerock.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
public class ReservationVO {
	
	private String realhotelname;
	private String roomname;
	private Date checkIndate;
	private Date checkOutDate;
	private String roomPrice;
	private int roomguest;
	private int roomno;
	private String realUser;
	private String userAmount;
}
