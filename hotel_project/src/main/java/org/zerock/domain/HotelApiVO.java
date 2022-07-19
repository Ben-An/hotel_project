package org.zerock.domain;

import lombok.Data;

@Data
public class HotelApiVO {
	/* 시군명 */
	private String state;
	
	/* 사업자명 */
	private String realhotelname;
	
	/* 양실수 */
	private String wstroom;
	
	/* 한실수 */
	private String korroom;
	
	/* 소재지도로명주소 */
	private String roadaddr;
	
	/* 소재지지번주소 */
	private String lotnoaddr;
	
	/* wgs84위도 */
	private String lat;
	
	/* wgs84경도 */
	private String logt;
	
	
	/*영업상태*/
	private String hotelcondition;
	

	
	

	
	
	
	
	
}
