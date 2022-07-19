package org.zerock.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MemberVO;
import org.zerock.service.MemberService;
import org.zerock.service.MemberServiceImpl;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping(value = "/member")
public class MemberController {

	@Autowired
	private MemberService memberservice;
	
	@Autowired
    private JavaMailSender mailSender;

	// 회원가입 페이지 이동
	@RequestMapping(value = "join", method = RequestMethod.GET)
	public void joinGET() {
		log.info("회원가입 페이지 진입");

	}

	// 회원가입
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinPOST(MemberVO member) throws Exception {

		log.info("join 진입");

		// 회원가입 서비스 실행
		memberservice.memberJoin(member);

		log.info("join Service 성공");

		return "redirect:/hotel/index";

	}

	// 로그인 페이지 이동
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public void loginGET() {
		log.info("로그인 페이지 진입");
	}

	// 아이디 중복 검사
	@RequestMapping(value = "/memberIdChk", method = RequestMethod.POST)
	@ResponseBody // join.jsp로 메서드 결과 반환
	public String memberIdChkPOST(String memberId) throws Exception {

		log.info("memberIdChk() 진입");

		int result = memberservice.idCheck(memberId);

		if (result != 0) {
			return "fail"; // 중복 아이디가 존재
		} else {
			return "success"; // 중복 아이디 x
		}

	}
	
	 
    /* 이메일 인증 */
    @RequestMapping(value="/mailCheck", method=RequestMethod.GET)
    @ResponseBody
    public String mailCheckGET(String email) throws Exception{
        
        /* 뷰(View)로부터 넘어온 데이터 확인 */
        log.info("이메일 데이터 전송 확인");
        log.info("이메일 : " + email);
        
        /* 인증번호(난수) 생성 */
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;  // 111111 ~ 999999       
        log.info("인증번호: " + checkNum);
   
        /* 이메일 보내기 */
        String setFrom = "ktrwwmnv@naver.com";
        String toMail = email; //수신받을 이메일
        String title = "심사숙소 회원가입 인증 이메일 입니다.";
        String content = 
                "심사숙소 홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
       try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
       
       String num = Integer.toString(checkNum);
       
       return num; 
    }

	/* 로그인 */
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String loginPOST(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) throws Exception {

		System.out.println("login 메서드 진입");
		System.out.println("전달된 데이터 : " + member);

		HttpSession session = request.getSession();
		MemberVO lvo = memberservice.memberLogin(member);// MemberVO 객체를 반환받아서 변수 lvo에 저장

		if (lvo == null) { // 일치하지 않는 아이디, 비밀번호 입력 경우

			int result = 0;
			rttr.addFlashAttribute("result", result);
			return "redirect:/member/login";

		}

		session.setAttribute("member", lvo); // 일치하는 아이디, 비밀번호 경우 (로그인 성공)

		return "redirect:/hotel/index";
	}
	
	 /* 메인페이지 로그아웃 */
    @RequestMapping(value="logout.do", method=RequestMethod.GET)
    public String logoutMainGET(HttpServletRequest request) throws Exception{
    	log.info("logoutMainGET메서드 진입");
        HttpSession session = request.getSession();
        session.invalidate();
        return "redirect:/hotel/index"; 
    }
    
    //회원 정보 수정
    @RequestMapping(value = "/myPage_memberUpdate", method = RequestMethod.POST)
    public String updatePost(HttpServletRequest request, MemberVO member) throws Exception {
    	memberservice.memberUpdate(member);
    	
    	
    	HttpSession session = request.getSession();
        session.invalidate();
    	return "redirect:/member/login";
    }
   
    
    // 회원 탈퇴
    @RequestMapping(value = "/myPage_memberDelete", method = RequestMethod.POST)
	public String deletePOST(HttpServletRequest request, MemberVO member) throws Exception {

    	memberservice.memberDelete(member);
    	HttpSession session = request.getSession();
        session.invalidate();
		return "redirect:/hotel/index";
	}

}
