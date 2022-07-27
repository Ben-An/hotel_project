package org.zerock.mapper;

import java.util.List;
import java.util.Map;

import org.zerock.domain.Criteria;
import org.zerock.domain.MainVO;
import org.zerock.domain.MyPageVO;
import org.zerock.domain.SearchVO;




public interface BoardMapper {

//	public List<BoardVO> getList();
	
	public List<MainVO> imageList();
	
	public List<SearchVO> hotelList();
	
	public List<SearchVO> hotelListWithPaging(Map<String, Object> map);
	
	public int getTotalCount(Criteria cri);
	
//	public List<BoardVO> getListWithPaging(Criteria cri);
//	public void insert(BoardVO board);
//
//	public Integer insertSelectKey(BoardVO board);
//
//	public BoardVO read(Long bno);
//
//	public int delete(Long bno);
//
//	public int update(BoardVO board);
//
//	public int getTotalCount(Criteria cri);

}
