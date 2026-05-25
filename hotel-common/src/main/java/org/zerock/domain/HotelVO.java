package org.zerock.domain;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

@Data
public class HotelVO {
	private Long hotelNo;

	@NotBlank(message = "호텔명을 입력해주세요")
	@Size(max = 100, message = "호텔명은 100자 이하여야 합니다")
	private String hotelName;

	@NotBlank(message = "지역을 선택해주세요")
	private String mainAddress;

	@NotBlank(message = "주소를 입력해주세요")
	private String address;

	@NotBlank(message = "전화번호를 입력해주세요")
	@Pattern(regexp = "^\\d{2,3}-\\d{3,4}-\\d{4}$", message = "올바른 전화번호 형식이 아닙니다 (예: 02-1234-5678)")
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
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
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

	/* 등록자 */
	private Integer memberNo;
	private String memberNickname;
}
