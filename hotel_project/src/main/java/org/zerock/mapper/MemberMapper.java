package org.zerock.mapper;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Select;
import org.zerock.domain.MemberVO;

public interface MemberMapper {
	//public String loginCheck(MemberVO vo, HttpSession session);
	
	//@Select("select memberId,memberPassword from member")
	//public List<MemberVO> getList();
	
	//public void insert(MemberVO member);//insert만 처리 되고 생성된 pk값을 알 필요가 없는 경우
	//public void insertSelectKey(MemberVO member);//insert문이 실행되고 생성된 pk값을 알아야 하는 경우
	
	//public MemberVO read(int memberNo);
	
	//public int delete(int memberNo);
	
	//public int update(MemberVO member);
	
	// 회원가입
	public void memberJoin(MemberVO member);
	
	// 아이디 중복 검사
	public int idCheck(String memberId);
	
	// 로그인 
    public MemberVO memberLogin(MemberVO member);
    
    //회원정보수정
    public void memberUpdate(MemberVO member);
    
    //회원 탈퇴
    public void memberDelete(MemberVO member);
}
