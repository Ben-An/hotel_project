package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyListVO {
	
	
	private int reviewno;
	private int hotelno;
	private String realhotelname;
	private Date reviewdate;
	private String reviewcontent;
	
}
