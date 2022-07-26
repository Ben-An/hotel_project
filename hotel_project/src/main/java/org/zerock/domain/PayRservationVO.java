package org.zerock.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class PayRservationVO {
	private int memberNo;     
    private int roomNo;      
	private String realUser;     
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd'T'HH:mm:ss")
	private Date checkInDate,checkOutDate;  
	private int userAmount;   
    private String payment;       
}
