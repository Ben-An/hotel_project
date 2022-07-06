package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MyPageVO {
	private int memberNo;
	private int hotelNo;
	private int reviewNo;
	private String memberId;
	private String memberName;
	private String memberNickname;
	private int reservationNo;
	private String hotelName;
	private String realMember;
	private Date checkInDate;
	private Date checkOutDate;
	private int memberAmount;
	private String reviewContent;
	private Date reviewDate;
	private int hotelImageId;
	private String hotelFileName;
	private String mainAddress;
	
}
