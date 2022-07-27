package org.zerock.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
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
import org.zerock.domain.NaverLoginBO;
import org.zerock.service.MemberService;
import org.zerock.service.MemberServiceImpl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping(value = "/member")
public class MemberController {

	/* NaverLoginBO */	
	private NaverLoginBO naverLoginBO;	
	private String apiResult = null;		
	@Autowired	
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {		
		this.naverLoginBO = naverLoginBO;	
		}
	
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
	public String loginGET(Model model,HttpSession session) {
		log.info("네이버 로그인 페이지 진입");
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */		
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);		
		//https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&		
		//redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125		
		System.out.println("네이버:" + naverAuthUrl);				
		//네이버 		
		model.addAttribute("url", naverAuthUrl); 		
		return "member/login";

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
	
	//네이버 로그인 콜백
	@RequestMapping(value="/callback",  method = {RequestMethod.GET,RequestMethod.POST})
	public String callback(Model model,@RequestParam Map<String,Object> paramMap, @RequestParam String code, @RequestParam String state,HttpSession session) throws SQLException, Exception {
		System.out.println("paramMap:" + paramMap);
		Map <String, Object> resultMap = new HashMap<String, Object>();

		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		//로그인 사용자 정보를 읽어온다.
		String apiResult = naverLoginBO.getUserProfile(oauthToken);
		System.out.println("apiResult =>"+apiResult);
		ObjectMapper objectMapper =new ObjectMapper();
		Map<String, Object> apiJson = (Map<String, Object>) objectMapper.readValue(apiResult, Map.class).get("response");
		System.out.println("apiJson =>"+apiJson);
		Map<String, Object> naverConnectionCheck = memberservice.naverConnectionCheck(apiJson);
		System.out.println("naverConnectionCheck =>"+naverConnectionCheck);
		//System.out.println("naverConnectionCheck.isEmpty =>"+naverConnectionCheck.isEmpty());
		//System.out.println("naverConnectionCheck.MEMBEREMAIL =>"+naverConnectionCheck.get("MEMBEREMAIL"));
		//System.out.println("naverConnectionCheck.email =>"+naverConnectionCheck.get("email"));
		if(naverConnectionCheck == null) { //일치하는 이메일 없으면 가입	

			//memberservice.userNaverRegisterPro(paramMap); 
			memberservice.userNaverRegisterPro(apiJson); 

		}else if(naverConnectionCheck.get("NAVERLOGIN") == null && naverConnectionCheck.get("MEMBEREMAIL") != null) { //이메일 가입 되어있고 네이버 연동 안되어 있을시
			memberservice.setNaverConnection(apiJson);
			Map<String, Object> loginCheck = memberservice.userNaverLoginPro(apiJson);
			session.setAttribute("member", loginCheck);
		}else { //모두 연동 되어있을시
			Map<String, Object> loginCheck = memberservice.userNaverLoginPro(apiJson);
			session.setAttribute("member", loginCheck);
		}

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
