package org.zerock.service;


import java.io.IOException;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;
import org.zerock.domain.HotelApiVO;
import org.zerock.domain.MapVO;



public interface MapService {
	public List<MapVO> mapSelect(String state);
	
	
	void insertInfo(HotelApiVO hotelDTO) throws IOException, ParserConfigurationException, SAXException;
	
	
	public List<HotelApiVO> hotelList();
	
	
	
	
}
