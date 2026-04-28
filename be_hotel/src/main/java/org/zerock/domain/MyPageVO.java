package org.zerock.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

@Data
public class MyPageVO {
	private int memberNo;
	private int hotelNo;
	private int reviewNo;
	private int reservationNo;
	private int wishListNo;
	private String memberId;
	private String memberName;
	private String memberNickname;
	private String realhotelName;
	private String hotelName;
	private String realUser;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date checkInDate;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date checkOutDate;
	private int userAmount;
	private String reviewContent;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date reviewDate;
	private int hotelImageId;
	private String hotelFileName;
	private String state;
	private String mainAddress;
	private String hotelPhoneNo;
	private String roomName;
	private String roomPrice;
	
}
