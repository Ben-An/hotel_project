package org.zerock.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Field;
import java.util.LinkedHashMap;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MemberVO;

/**
 * /member/callback (네이버 로그인 후 fe_hotel 콜백) 회귀 테스트.
 * Why: 종전에는 be_hotel 응답을 무시하여 fe_hotel 세션에 member 가 저장되지 않아
 * Naver 로그인이 성공해도 사용자가 비로그인 상태로 보였다.
 */
class MemberControllerNaverCallbackTest {

	private MemberController controller;
	private RestTemplate restTemplate;
	private HttpSession session;
	private RedirectAttributes rttr;

	@BeforeEach
	void setUp() throws Exception {
		controller = new MemberController();
		restTemplate = mock(RestTemplate.class);
		session = mock(HttpSession.class);
		rttr = mock(RedirectAttributes.class);
		inject(controller, "restTemplate", restTemplate);
	}

	@Test
	void callback_storesMemberVoOnSession_andRedirectsHome_whenSuccess() {
		// be_hotel 응답이 RestTemplate 에서 Map.class 로 받히면 member 키 값은 LinkedHashMap 으로 역직렬화된다.
		// 이를 그대로 세션에 넣으면 MyPageController 에서 (MemberVO) 캐스팅이 ClassCastException 으로 깨졌던 회귀 케이스.
		Map<String, Object> beResponse = new HashMap<>();
		beResponse.put("status", "success");
		Map<String, Object> memberJson = new LinkedHashMap<>();
		memberJson.put("memberNo", 42);
		memberJson.put("memberEmail", "a@b.com");
		memberJson.put("memberNickname", "nick");
		beResponse.put("member", memberJson);
		when(restTemplate.getForObject(eq(callbackUrl("c", "s")), eq(Map.class))).thenReturn(beResponse);

		String view = controller.callback("c", "s", session, rttr);

		assertThat(view).isEqualTo("redirect:/hotel/index");
		ArgumentCaptor<Object> captured = ArgumentCaptor.forClass(Object.class);
		verify(session, times(1)).setAttribute(eq("member"), captured.capture());
		assertThat(captured.getValue())
				.as("세션에는 MemberVO 가 저장되어야 한다 (LinkedHashMap 그대로면 MyPage 진입 시 ClassCastException)")
				.isInstanceOf(MemberVO.class);
		MemberVO stored = (MemberVO) captured.getValue();
		assertThat(stored.getMemberNo()).isEqualTo(42);
		assertThat(stored.getMemberEmail()).isEqualTo("a@b.com");
		assertThat(stored.getMemberNickname()).isEqualTo("nick");
		verify(rttr, never()).addFlashAttribute(eq("result"), eq(0));
	}

	@Test
	void callback_redirectsToLogin_whenBackendReturnsNoMember() {
		Map<String, Object> beResponse = new HashMap<>();
		beResponse.put("status", "success");
		// member 키가 누락된 비정상 응답 — 세션에 저장하지 않고 로그인 페이지로 돌려보낸다.
		when(restTemplate.getForObject(eq(callbackUrl("c", "s")), eq(Map.class))).thenReturn(beResponse);

		String view = controller.callback("c", "s", session, rttr);

		assertThat(view).isEqualTo("redirect:/member/login");
		verify(session, never()).setAttribute(eq("member"), org.mockito.ArgumentMatchers.any());
		verify(rttr).addFlashAttribute("result", 0);
	}

	@Test
	void callback_redirectsToLogin_whenBackendReturnsNull() {
		when(restTemplate.getForObject(eq(callbackUrl("c", "s")), eq(Map.class))).thenReturn(null);

		String view = controller.callback("c", "s", session, rttr);

		assertThat(view).isEqualTo("redirect:/member/login");
		verify(session, never()).setAttribute(eq("member"), org.mockito.ArgumentMatchers.any());
	}

	private static String callbackUrl(String code, String state) {
		return org.zerock.config.BackendConfig.BACKEND_URL + "/member/callback?code=" + code + "&state=" + state;
	}

	private static void inject(Object target, String field, Object value) throws Exception {
		Field f = target.getClass().getDeclaredField(field);
		f.setAccessible(true);
		f.set(target, value);
	}
}
