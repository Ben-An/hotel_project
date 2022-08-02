package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MyPageVO {
	private int memberNo;
	private int hotelNo;
	private int reviewNo;
	private int realhotelNo;
	private int reservationNo;
	private int wishListNo;
	private String memberId;
	private String memberName;
	private String memberNickname;
	private String realhotelName;
	private String hotelName;
	private String realUser;
	private Date checkInDate;
	private Date checkOutDate;
	private int userAmount;
	private String reviewContent;
	private Date reviewDate;
	private int hotelImageId;
	private String hotelFileName;
	private String state;
	private String mainAddress;
	private String hotelPhoneNo;
	private String roomName;
	private String roomPrice;
	
}
