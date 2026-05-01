package org.zerock.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Field;
import java.util.Map;

import javax.mail.Session;
import javax.mail.internet.MimeMessage;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.zerock.domain.MemberVO;
import org.zerock.service.MemberService;

class MemberApiControllerFindIdPwTest {

	private MemberApiController controller;
	private MemberService memberService;
	private JavaMailSender mailSender;

	@BeforeEach
	void setUp() throws Exception {
		controller = new MemberApiController();
		memberService = mock(MemberService.class);
		mailSender = mock(JavaMailSender.class);
		inject(controller, "memberservice", memberService);
		inject(controller, "mailSender", mailSender);
		inject(controller, "mailFromAddress", "noreply@example.com");

		MimeMessage message = new MimeMessage((Session) null);
		when(mailSender.createMimeMessage()).thenReturn(message);
	}

	@Test
	void findId_returnsMemberId_whenMatched() throws Exception {
		MemberVO req = new MemberVO();
		req.setMemberName("홍길동");
		req.setMemberEmail("user@example.com");
		when(memberService.findMemberId(any(MemberVO.class))).thenReturn("hong123");

		ResponseEntity<Map<String, String>> response = controller.findId(req);

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody())
				.containsEntry("status", "success")
				.containsEntry("memberId", "hong123");
	}

	@Test
	void findId_returnsFail_whenNoMatch() throws Exception {
		MemberVO req = new MemberVO();
		when(memberService.findMemberId(any(MemberVO.class))).thenReturn(null);

		ResponseEntity<Map<String, String>> response = controller.findId(req);

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).containsEntry("status", "fail");
		assertThat(response.getBody()).doesNotContainKey("memberId");
	}

	@Test
	void findPw_returnsFail_andSkipsMail_whenMemberNotFound() throws Exception {
		MemberVO req = new MemberVO();
		req.setMemberId("ghost");
		req.setMemberEmail("ghost@example.com");
		when(memberService.resetPassword(any(MemberVO.class))).thenReturn(null);

		ResponseEntity<Map<String, String>> response = controller.findPw(req);

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).containsEntry("status", "fail");
		// 회원이 없으면 메일 발송 자체를 시도하지 않아야 한다
		verify(mailSender, org.mockito.Mockito.never()).send(any(MimeMessage.class));
	}

	@Test
	void findPw_returnsSuccess_andSendsMail_whenMatched() throws Exception {
		MemberVO req = new MemberVO();
		req.setMemberId("hong123");
		req.setMemberEmail("user@example.com");
		when(memberService.resetPassword(any(MemberVO.class))).thenReturn("Tmp1234567");

		ResponseEntity<Map<String, String>> response = controller.findPw(req);

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).containsEntry("status", "success");
		// 응답 body 에 임시 비밀번호 평문이 노출되지 않아야 한다 (메일로만 전달)
		assertThat(response.getBody()).doesNotContainKey("memberPassword");
		verify(mailSender).send(any(MimeMessage.class));
	}

	private static void inject(Object target, String field, Object value) throws Exception {
		Field f = target.getClass().getDeclaredField(field);
		f.setAccessible(true);
		f.set(target, value);
	}
}
