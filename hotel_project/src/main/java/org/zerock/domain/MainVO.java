package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MainVO {
	private String hotelFileName; 
	private String hotelName;   
	private int grade;
	private String reviewContent;
	private Date reviewDate;
	
}
