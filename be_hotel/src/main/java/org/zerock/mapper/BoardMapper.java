package org.zerock.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.MainVO;
import org.zerock.domain.MyPageVO;
import org.zerock.domain.ReplyListVO;
import org.zerock.domain.SearchVO;




public interface BoardMapper {

//	public List<BoardVO> getList();

	public List<MainVO> imageList(Criteria cri);

	public int imageListCount();

	public List<SearchVO> hotelList();

	public List<SearchVO> hotelListWithPaging(Map<String, Object> map);

	public int getTotalCount(Criteria cri);

	//replyList 최신댓글 가져옴
	public List<ReplyListVO>  replyList();

	// 인기/추천 지역 (예약 집계 + 호텔 수 fallback)
	public List<Map<String, Object>> popularRegions(@Param("limit") int limit);

	public List<Map<String, Object>> popularRegionsByHotelCount(@Param("limit") int limit);
	
	
	
	
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
