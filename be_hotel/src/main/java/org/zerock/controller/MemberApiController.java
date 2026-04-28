package org.zerock.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.zerock.domain.MemberVO;
import org.zerock.domain.NaverLoginBO;
import org.zerock.domain.validation.ValidationGroups.Delete;
import org.zerock.domain.validation.ValidationGroups.Join;
import org.zerock.domain.validation.ValidationGroups.Login;
import org.zerock.domain.validation.ValidationGroups.Update;
import org.zerock.service.MemberService;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/member")
public class MemberApiController {

	@Autowired
	private NaverLoginBO naverLoginBO;

	@Autowired
	private MemberService memberservice;

	@Autowired
	private JavaMailSender mailSender;

	@Value("${app.mail.from-address}")
	private String mailFromAddress;

	/* 회원가입 */
	@PostMapping("/join")
	public ResponseEntity<String> join(@Validated(Join.class) @RequestBody MemberVO member) throws Exception {
		memberservice.memberJoin(member);
		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	/* 아이디 중복 검사 */
	@PostMapping("/memberIdChk")
	public ResponseEntity<String> memberIdChk(@RequestParam String memberId) throws Exception {
		int result = memberservice.idCheck(memberId);
		return new ResponseEntity<>(result != 0 ? "fail" : "success", HttpStatus.OK);
	}

	/* 닉네임 중복 검사 */
	@PostMapping("/memberNicknameChk")
	public ResponseEntity<String> memberNicknameChk(@RequestParam String memberNickname) throws Exception {
		int result = memberservice.nicknameCheck(memberNickname);
		return new ResponseEntity<>(result != 0 ? "fail" : "success", HttpStatus.OK);
	}

	/* 이메일 인증 */
	@GetMapping("/mailCheck")
	public ResponseEntity<String> mailCheck(@RequestParam String email) throws Exception {
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		log.info("인증번호: " + checkNum);

		String setFrom = mailFromAddress;
		String title = "심사숙소 회원가입 인증 이메일 입니다.";
		String content = "심사��소 홈페이지를 방문해주셔서 감사합니다." +
				"<br><br>" +
				"인증 번호는 " + checkNum + "입니다." +
				"<br>" +
				"해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(email);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);
		} catch (Exception e) {
			log.error("이메일 발송 실패 - 수신자: {}", email, e);
			return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(Integer.toString(checkNum), HttpStatus.OK);
	}

	/* 로그인 */
	@PostMapping("/login")
	public ResponseEntity<MemberVO> login(@Validated(Login.class) @RequestBody MemberVO member, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		MemberVO lvo = memberservice.memberLogin(member);
		if (lvo == null) {
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		}
		session.setAttribute("member", lvo);
		return new ResponseEntity<>(lvo, HttpStatus.OK);
	}

	/* 네이버 로그인 URL 반환 */
	@GetMapping("/naverLoginUrl")
	public ResponseEntity<Map<String, String>> naverLoginUrl(HttpSession session) {
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		Map<String, String> result = new HashMap<>();
		result.put("url", naverAuthUrl);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	/* 네이버 로그인 콜백 */
	@RequestMapping(value = "/callback", method = {RequestMethod.GET, RequestMethod.POST})
	public ResponseEntity<Map<String, Object>> callback(@RequestParam String code, @RequestParam String state,
			HttpSession session) throws Exception {
		OAuth2AccessToken oauthToken = naverLoginBO.getAccessToken(session, code, state);
		String apiResult = naverLoginBO.getUserProfile(oauthToken);
		ObjectMapper objectMapper = new ObjectMapper();
		Map<String, Object> apiJson = (Map<String, Object>) objectMapper.readValue(apiResult, Map.class).get("response");

		Map<String, Object> naverConnectionCheck = memberservice.naverConnectionCheck(apiJson);
		if (naverConnectionCheck == null) {
			memberservice.userNaverRegisterPro(apiJson);
		} else if (naverConnectionCheck.get("NAVERLOGIN") == null && naverConnectionCheck.get("MEMBEREMAIL") != null) {
			memberservice.setNaverConnection(apiJson);
			Map<String, Object> loginCheck = memberservice.userNaverLoginPro(apiJson);
			session.setAttribute("member", loginCheck);
		} else {
			Map<String, Object> loginCheck = memberservice.userNaverLoginPro(apiJson);
			session.setAttribute("member", loginCheck);
		}

		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	/* 로그아웃 */
	@GetMapping("/logout")
	public ResponseEntity<String> logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	/* 회원 정보 수정 */
	@PostMapping("/memberUpdate")
	public ResponseEntity<String> memberUpdate(@Validated(Update.class) @RequestBody MemberVO member, HttpServletRequest request) throws Exception {
		memberservice.memberUpdate(member);
		HttpSession session = request.getSession();
		session.invalidate();
		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	/* 회원 탈퇴 */
	@PostMapping("/memberDelete")
	public ResponseEntity<String> memberDelete(@Validated(Delete.class) @RequestBody MemberVO member, HttpServletRequest request) throws Exception {
		memberservice.memberDelete(member);
		HttpSession session = request.getSession();
		session.invalidate();
		return new ResponseEntity<>("success", HttpStatus.OK);
	}
}
