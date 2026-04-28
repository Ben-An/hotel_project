package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.DetailImage;
import org.zerock.domain.DetailVO;
import org.zerock.domain.ImageList;
import org.zerock.domain.PlaceVO;
import org.zerock.domain.RelyVO;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.HotelReasonVO;
import org.zerock.domain.ReplyCriteria;
import org.zerock.domain.ReplyListVO;

public interface DetailMapper {
	
	public DetailVO detailList(int hotelno);
	
	public List<DetailImage>listImage(int hotelno);
	
	public List<ImageList>roomList(int hotelno);
	
	public List<PlaceVO>placeList(int hotelno);
	//클릭시 모달창에서 데이터 값 가져오기 
	public List<RelyVO>read(int hotelno);
	
	public boolean insert (RelyVO vo);
	
	
	//댓글 삭제
	public int delete(int reivewNo);
	
	
	//댓글 수정
	public int update (RelyVO vo);
	
	
	//페이징 만들기
	public List<RelyVO> getListWithPasing(@Param("cri") ReplyCriteria cri, @Param("hotelno")int hotelno);
	
	
	
	//replyPage total
	public int getReplyByHotelno(int hotelno);

	// 객실 CRUD
	public int insertRoom(ImageList room);
	public int updateRoom(ImageList room);
	public int deleteRoom(int roomno);

	// 호텔 이미지 CRUD
	public int deleteImage(int hotelImageId);
	public int insertImage(AttachImageVO vo);

	// 이 숙박시설을 좋아하는 이유 CRUD
	public List<HotelReasonVO> reasonList(int hotelNo);
	public int insertReason(HotelReasonVO vo);
	public int updateReason(HotelReasonVO vo);
	public int deleteReason(int reasonNo);
	public HotelReasonVO getReason(int reasonNo);
}
