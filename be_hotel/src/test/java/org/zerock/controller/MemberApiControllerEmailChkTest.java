package org.zerock.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Field;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.zerock.service.MemberService;

class MemberApiControllerEmailChkTest {

	private MemberApiController controller;
	private MemberService memberService;

	@BeforeEach
	void setUp() throws Exception {
		controller = new MemberApiController();
		memberService = Mockito.mock(MemberService.class);
		inject(controller, "memberservice", memberService);
	}

	@Test
	void memberEmailChk_returnsSuccess_whenEmailNotInUse() throws Exception {
		when(memberService.emailCheck("free@example.com")).thenReturn(0);

		ResponseEntity<String> response = controller.memberEmailChk("free@example.com");

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).isEqualTo("success");
		verify(memberService).emailCheck("free@example.com");
	}

	@Test
	void memberEmailChk_returnsFail_whenEmailAlreadyExists() throws Exception {
		when(memberService.emailCheck("dup@example.com")).thenReturn(1);

		ResponseEntity<String> response = controller.memberEmailChk("dup@example.com");

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).isEqualTo("fail");
	}

	private static void inject(Object target, String field, Object value) throws Exception {
		Field f = target.getClass().getDeclaredField(field);
		f.setAccessible(true);
		f.set(target, value);
	}
}
