package org.zerock.domain;

import lombok.Data;

@Data
public class AttachImageVO {

	// 호텔 이미지 아이디
	private int hotelImageId;  
	
	/* 경로 */
	private String uploadPath;
	
	/* uuid */
	private String uuid;
	
	/* 파일 이름 */
	private String hotelFileName;
	
	/* 호텔 id */
	private long hotelNo;

}
