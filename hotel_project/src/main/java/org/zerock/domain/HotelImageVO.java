package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class HotelImageVO {
	
	private int hotelImageId;  
	private int hotelNo;       
 	private String uploadPath;
	private String hotelFileName;
 
}
