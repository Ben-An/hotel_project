package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class HotelAmenityVO {

	private int amenityNo;
	private int hotelNo;
	private String amenityName;
	private String amenityIcon;
	private String amenityType;
	private int amenityOrder;
	private Date regDate;
}
