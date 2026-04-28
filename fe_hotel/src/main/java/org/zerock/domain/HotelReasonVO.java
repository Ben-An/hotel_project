package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class HotelReasonVO {

	private int reasonNo;
	private int hotelNo;
	private String reasonTitle;
	private String reasonContent;
	private String reasonImage;
	private Date regDate;
}
