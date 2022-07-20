package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class HotelVO {
	private Long hotelNo;       
	private String hotelName;       
	private String mainAddress;   
	private String address;         
	private String hotelPhoneNo;    
	private String buffet;         
	private String swim;          
	private String golf;            
	private String pet;            
	private String restaurant;     
	private String fitness;         
	private String parking;         
	private String wifi;            
	private String kitchen;        
	private String smoke;           
	private Date hotelRegistDate; 

	
	/* 경로 */
	private String uploadPath;
	
	/* uuid */
	private String uuid;
	
	/* 파일 이름 */
	private String hotelFileName;
	
	//이미지 업로드 위해 추가
	private HotelImageVO imageVO;   
	
	/* 이미지 정보 */
	private List<AttachImageVO> imageList;

	
	

	
}
