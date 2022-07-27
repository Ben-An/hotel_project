package org.zerock.service;

import java.util.List;
import java.util.Map;

import org.zerock.domain.MemberVO;
//느슨한 결합을 위한 인터페이스 이용
public interface MemberService {
	
	//회원 등록
	//public void register_m(MemberVO member);
	//회원 정보 수정
	//public boolean modify_m(MemberVO member);
	//회원 탈퇴
	//public boolean remove_m(int memberNo);
	//회원 정보 조회? - 그냥 리스트만 보여주기 구현(여러개)
	//public List<MemberVO> getList();
	
	//회원 정보 조회?(원하는거 하나)
	//public MemberVO get(int memberNo);
	
	
	///////////////////////////////
	//회원 가입
	public void memberJoin(MemberVO member) throws Exception;
	
	// 아이디 중복 검사
	public int idCheck(String memberId) throws Exception;
	
	// 로그인 
    public MemberVO memberLogin(MemberVO member) throws Exception;

    //회원정보 수정
	public void memberUpdate(MemberVO member) throws Exception;
	
	//회원정보 삭제
	public void memberDelete(MemberVO member) throws Exception;
	
    //네이버 연동 체크
	public Map<String, Object> naverConnectionCheck(Map<String, Object> apiJson);

	public Map<String, Object> userNaverLoginPro(Map<String, Object> apiJson);

	public void setNaverConnection(Map<String, Object> apiJson);

	//네이버 가입
	public void userNaverRegisterPro(Map<String, Object> apiJson);
    
}
