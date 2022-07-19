package org.zerock.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.SearchVO;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class HotelSearchServiceImpl implements HotelSearchService {

	
	@Setter(onMethod_ =@Autowired)
	private BoardMapper mapper;
	
	
	@Override
	public List<SearchVO> listHotels(Map<String, Object> map)  {
		
		return mapper.hotelListWithPaging(map);
		
	}
	
	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}
	

}
