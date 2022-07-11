package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class SearchVO {
	private String[] facilityList;
	private int hotelNo; 
	private String realhotelName;
	private String hotelName;     
	private String state;   
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
	private double grade;
	private int hotelImageId;        
 	private String hotelFileName; 	
}
