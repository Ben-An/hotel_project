package org.zerock.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class PayRservationVO {
	private int memberNo;     
    private int roomNo;      
	private String realUser;     
	//Thu Jun 30 00:00:00 KST 2022
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date checkInDate;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date checkOutDate;  
	private int userAmount;   
    private String payment;       
}
