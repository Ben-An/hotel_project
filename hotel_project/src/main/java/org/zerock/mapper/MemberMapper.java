package org.zerock.mapper;

import java.util.List;
import java.util.Map;

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
    
    // 네이버 이메일 가입 체크
    public Map<String, Object> naverConnectionCheck(Map<String, Object> apiJson);

    //로그인 정보 가져와 세션에 담기(이미 네이버로 가입된 계정)
	public Map<String, Object> userNaverLoginPro(Map<String, Object> apiJson);
	// 기존 회원이지만 네이버 연동은 x
	public void setNaverConnection(Map<String, Object> apiJson);
	//네이버 가입
	public void userNaverRegisterPro(Map<String, Object> apiJson);
}
