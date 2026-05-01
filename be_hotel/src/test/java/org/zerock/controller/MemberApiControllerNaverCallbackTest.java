package org.zerock.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.zerock.domain.MemberVO;
import org.zerock.domain.NaverLoginBO;
import org.zerock.service.MemberService;

import com.github.scribejava.core.model.OAuth2AccessToken;

/**
 * /api/member/callback 회귀 테스트.
 * Why: be_hotel 의 HttpSession 은 fe_hotel 에서 RestTemplate 으로 호출되어
 * 사용자 브라우저 세션과 무관하므로, 콜백은 응답 body 에 member 를 실어서
 * fe_hotel 이 자기 세션에 저장할 수 있도록 해야 한다.
 */
class MemberApiControllerNaverCallbackTest {

	private MemberApiController controller;
	private NaverLoginBO naverLoginBO;
	private MemberService memberService;
	private final OAuth2AccessToken token = new OAuth2AccessToken("dummy-access-token");

	@BeforeEach
	void setUp() throws Exception {
		controller = new MemberApiController();
		naverLoginBO = mock(NaverLoginBO.class);
		memberService = mock(MemberService.class);

		inject(controller, "naverLoginBO", naverLoginBO);
		inject(controller, "memberservice", memberService);

		when(naverLoginBO.getAccessToken(anyString(), anyString())).thenReturn(token);
	}

	@Test
	void callback_returnsUnauthorized_whenAccessTokenNull() throws Exception {
		when(naverLoginBO.getAccessToken(anyString(), anyString())).thenReturn(null);

		ResponseEntity<Map<String, Object>> response = controller.callback("code", "bad-state");

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.UNAUTHORIZED);
		assertThat(response.getBody()).containsEntry("status", "fail");
	}

	@Test
	void callback_returnsMember_whenExistingMemberAlreadyConnected() throws Exception {
		when(naverLoginBO.getUserProfile(token))
				.thenReturn("{\"response\":{\"id\":\"naver-uid-1\",\"email\":\"a@b.com\"}}");
		Map<String, Object> existing = new HashMap<>();
		existing.put("MEMBEREMAIL", "a@b.com");
		existing.put("NAVERLOGIN", "naver-uid-1");
		when(memberService.naverConnectionCheck(any())).thenReturn(existing);
		MemberVO loginResult = memberVo(7, "a@b.com");
		when(memberService.userNaverLoginPro(any())).thenReturn(loginResult);

		ResponseEntity<Map<String, Object>> response = controller.callback("code", "state");

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody())
				.containsEntry("status", "success")
				.containsEntry("member", loginResult);
		verify(memberService, never()).userNaverRegisterPro(any());
		verify(memberService, never()).setNaverConnection(any());
		verify(memberService, times(1)).userNaverLoginPro(any());
	}

	@Test
	void callback_connectsAndReturnsMember_whenEmailMatchedButNotLinked() throws Exception {
		// 같은 이메일 로컬 가입자가 처음으로 네이버 연결하는 분기.
		when(naverLoginBO.getUserProfile(token))
				.thenReturn("{\"response\":{\"id\":\"naver-uid-1\",\"email\":\"a@b.com\"}}");
		Map<String, Object> existingButUnlinked = new HashMap<>();
		existingButUnlinked.put("MEMBEREMAIL", "a@b.com");
		existingButUnlinked.put("NAVERLOGIN", null);
		when(memberService.naverConnectionCheck(any())).thenReturn(existingButUnlinked);
		MemberVO loginResult = memberVo(8, "a@b.com");
		when(memberService.userNaverLoginPro(any())).thenReturn(loginResult);

		ResponseEntity<Map<String, Object>> response = controller.callback("code", "state");

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).containsEntry("member", loginResult);
		verify(memberService, times(1)).setNaverConnection(any());
		verify(memberService, times(1)).userNaverLoginPro(any());
	}

	@Test
	void callback_registersAndReturnsMember_whenNewUser() throws Exception {
		// 신규 가입 분기. 가입 직후 동일 프로필로 다시 조회해 member 를 응답에 실어야 한다.
		when(naverLoginBO.getUserProfile(token))
				.thenReturn("{\"response\":{\"id\":\"naver-uid-1\",\"email\":\"a@b.com\",\"name\":\"홍\",\"nickname\":\"길\"}}");
		when(memberService.naverConnectionCheck(any())).thenReturn(null);
		MemberVO registered = memberVo(9, "a@b.com");
		when(memberService.userNaverLoginPro(any())).thenReturn(registered);

		ResponseEntity<Map<String, Object>> response = controller.callback("code", "state");

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody())
				.containsEntry("status", "success")
				.containsEntry("member", registered);
		verify(memberService, times(1)).userNaverRegisterPro(any());
		verify(memberService, times(1)).userNaverLoginPro(any());
	}

	private static MemberVO memberVo(int memberNo, String email) {
		MemberVO vo = new MemberVO();
		vo.setMemberNo(memberNo);
		vo.setMemberEmail(email);
		return vo;
	}

	private static void inject(Object target, String field, Object value) throws Exception {
		Field f = target.getClass().getDeclaredField(field);
		f.setAccessible(true);
		f.set(target, value);
	}
}
