package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService{
	
	@Setter(onMethod_ =@Autowired)
	private MemberMapper mapper;
	
	/*
	 * @Override public void register_m(MemberVO member) {
	 * log.info("register: "+member);
	 * 
	 * }
	 * 
	 * @Override public boolean modify_m(MemberVO member) { // TODO Auto-generated
	 * method stub return false; }
	 * 
	 * @Override public boolean remove_m(int memberNo) { // TODO Auto-generated
	 * method stub return false; }
	 * 
	 * @Override public List<MemberVO> getList() { log.info("getList..."); return
	 * mapper.getList(); }
	 * 
	 * @Override public MemberVO get(int memberNo) { // TODO Auto-generated method
	 * stub return null; }
	 */

	//회원가입
	@Override
	public void memberJoin(MemberVO member) throws Exception {
		mapper.memberJoin(member);
		
	}
	
	//아이디 중복 검사
	@Override
	public int idCheck(String memberId) throws Exception {
		
		return mapper.idCheck(memberId);
	}

    // 로그인 
    @Override
    public MemberVO memberLogin(MemberVO member) throws Exception {
        
        return mapper.memberLogin(member);
    }

    // 회원 정보 수정
	@Override
	public void memberUpdate(MemberVO member) throws Exception {
		mapper.memberUpdate(member);
		
	}

	//회원 삭제
	@Override
	public void memberDelete(MemberVO member) throws Exception {
		mapper.memberDelete(member);	
	}
    
}
