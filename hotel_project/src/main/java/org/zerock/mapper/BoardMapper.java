package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.MainVO;
import org.zerock.domain.MyPageVO;




public interface BoardMapper {

//	public List<BoardVO> getList();
	
	public List<MainVO> imageList();

	public List<MyPageVO> myPageList();
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
