package org.zerock.service;

import java.util.List;
import java.util.Map;

import org.zerock.domain.Criteria;
import org.zerock.domain.SearchVO;

public interface HotelSearchService {
	public List<SearchVO> listHotels(Map<String, Object> map);
	
	public int getTotal(Criteria cri);
}
