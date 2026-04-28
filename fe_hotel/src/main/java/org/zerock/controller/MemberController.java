package org.zerock.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.config.BackendConfig;
import org.zerock.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping(value = "/member")
public class MemberController {

	@Autowired
	private RestTemplate restTemplate;

	private static final String API = BackendConfig.BACKEND_URL + "/member";

	/* 회원가입 페이지 */
	@RequestMapping(value = "join", method = RequestMethod.GET)
	public void joinGET() {
		log.info("회원가입 페이지 진입");
	}

	/* 회원가입 */
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> joinPOST(MemberVO member) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<MemberVO> entity = new HttpEntity<>(member, headers);
		restTemplate.postForObject(API + "/join", entity, String.class);
		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	/* 로그인 페이지 */
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String loginGET(Model model, HttpSession session) {
		Map result = restTemplate.getForObject(API + "/naverLoginUrl", Map.class);
		if (result != null) {
			model.addAttribute("url", result.get("url"));
		}
		return "member/login";
	}

	/* 아이디 중복 검사 */
	@RequestMapping(value = "/memberIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberIdChkPOST(@RequestParam String memberId) {
		return restTemplate.postForObject(API + "/memberIdChk?memberId=" + memberId, null, String.class);
	}

	/* 닉네임 중복 검사 */
	@RequestMapping(value = "/memberNicknameChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberNicknameChkPOST(@RequestParam String memberNickname) {
		return restTemplate.postForObject(API + "/memberNicknameChk?memberNickname=" + memberNickname, null, String.class);
	}

	/* 이메일 인증 */
	@RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheckGET(@RequestParam String email) {
		return restTemplate.getForObject(API + "/mailCheck?email=" + email, String.class);
	}

	/* 로그인 */
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String loginPOST(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<MemberVO> entity = new HttpEntity<>(member, headers);

		try {
			ResponseEntity<MemberVO> response = restTemplate.postForEntity(API + "/login", entity, MemberVO.class);
			if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
				HttpSession session = request.getSession();
				session.setAttribute("member", response.getBody());
				return "redirect:/hotel/index";
			}
		} catch (HttpClientErrorException e) {
			// 로그인 실패
		}

		rttr.addFlashAttribute("result", 0);
		return "redirect:/member/login";
	}

	/* 네이버 로그인 콜백 */
	@RequestMapping(value = "/callback", method = {RequestMethod.GET, RequestMethod.POST})
	public String callback(@RequestParam String code, @RequestParam String state, HttpSession session) {
		Map result = restTemplate.getForObject(
				API + "/callback?code=" + code + "&state=" + state, Map.class);
		return "redirect:/hotel/index";
	}

	/* 로그아웃 */
	@RequestMapping(value = "logout.do", method = RequestMethod.GET)
	public String logoutMainGET(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/hotel/index";
	}

	/* 회원 정보 수정 */
	@RequestMapping(value = "/myPage_memberUpdate", method = RequestMethod.POST)
	public String updatePost(HttpServletRequest request, MemberVO member) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<MemberVO> entity = new HttpEntity<>(member, headers);
		restTemplate.postForObject(API + "/memberUpdate", entity, String.class);

		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/member/login";
	}

	/* 회원 탈퇴 */
	@RequestMapping(value = "/myPage_memberDelete", method = RequestMethod.POST)
	public String deletePOST(HttpServletRequest request, MemberVO member) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<MemberVO> entity = new HttpEntity<>(member, headers);
		restTemplate.postForObject(API + "/memberDelete", entity, String.class);

		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/hotel/index";
	}
}
