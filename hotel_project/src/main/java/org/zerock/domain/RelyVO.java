package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class RelyVO {
	private int reviewNo;
	private int memberNo;
	private int hotelNo;
	private int grade;
	private String memberNickname;
	private String reviewContent;
	private Date reviewDate;
}
