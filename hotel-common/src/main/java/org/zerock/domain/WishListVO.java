package org.zerock.domain;

import lombok.Data;

@Data
public class WishListVO {
	public int hotelno;
	public String realhotelname;
	public String state;
	private int hotelImageId;        
 	private String uploadPath;
	private String hotelFileName;
}
