package org.zerock.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService{

	@Setter(onMethod_ =@Autowired)
	private MemberMapper mapper;

	private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
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
		String encodedPassword = passwordEncoder.encode(member.getMemberPassword());
		member.setMemberPassword(encodedPassword);
		mapper.memberJoin(member);
	}
	
	//아이디 중복 검사
	@Override
	public int idCheck(String memberId) throws Exception {

		return mapper.idCheck(memberId);
	}

	//닉네임 중복 검사
	@Override
	public int nicknameCheck(String memberNickname) throws Exception {

		return mapper.nicknameCheck(memberNickname);
	}

    // 로그인
    @Override
    public MemberVO memberLogin(MemberVO member) throws Exception {
        MemberVO dbMember = mapper.memberFindById(member.getMemberId());
        if (dbMember != null && passwordEncoder.matches(member.getMemberPassword(), dbMember.getMemberPassword())) {
            dbMember.setMemberPassword(null);
            return dbMember;
        }
        return null;
    }

    // 회원 정보 수정
	@Override
	public void memberUpdate(MemberVO member) throws Exception {
		if (member.getMemberPassword() != null && !member.getMemberPassword().isEmpty()) {
			String encodedPassword = passwordEncoder.encode(member.getMemberPassword());
			member.setMemberPassword(encodedPassword);
		}
		mapper.memberUpdate(member);
	}

	//회원 삭제
	@Override
	public void memberDelete(MemberVO member) throws Exception {
		MemberVO dbMember = mapper.memberFindById(member.getMemberId());
		if (dbMember != null && passwordEncoder.matches(member.getMemberPassword(), dbMember.getMemberPassword())) {
			mapper.memberDeleteById(member.getMemberId());
		} else {
			throw new Exception("비밀번호가 일치하지 않습니다.");
		}
	}
	
	//네이버 이메일 가입 체크
		@Override
		public Map<String, Object> naverConnectionCheck(Map<String, Object> apiJson) {
			return mapper.naverConnectionCheck(apiJson);
		}

		@Override
		public MemberVO userNaverLoginPro(Map<String, Object> apiJson) {
			return mapper.userNaverLoginPro(apiJson);
		}

		@Override
		public void setNaverConnection(Map<String, Object> apiJson) {
			mapper.setNaverConnection(apiJson); 
			
		}
		//네이버 가입
		@Override
		public void userNaverRegisterPro(Map<String, Object> apiJson) {
			mapper.userNaverRegisterPro(apiJson);
		}
    
}
