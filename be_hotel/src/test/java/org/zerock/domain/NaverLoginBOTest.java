package org.zerock.domain;

import static org.assertj.core.api.Assertions.assertThat;

import java.lang.reflect.Field;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class NaverLoginBOTest {

	private NaverLoginBO bo;

	@BeforeEach
	void setUp() throws Exception {
		bo = new NaverLoginBO();
		// @Value 필드는 단위 테스트에서 비어 있어도 state 캐시 동작 검증에는 영향 없음.
		setField(bo, "CLIENT_ID", "test-client-id");
		setField(bo, "CLIENT_SECRET", "test-client-secret");
		setField(bo, "REDIRECT_URI", "http://localhost/callback");
	}

	@Test
	void issuedState_isAcceptedOnce_andRejectedOnReplay() throws Exception {
		String state = registerState(bo, "state-1", System.currentTimeMillis());

		assertThat(bo.consumeState(state, System.currentTimeMillis())).isTrue();
		assertThat(bo.consumeState(state, System.currentTimeMillis()))
				.as("같은 state로 두 번째 검증 시 거부되어야 한다")
				.isFalse();
	}

	@Test
	void unknownState_isRejected() {
		assertThat(bo.consumeState("never-issued", System.currentTimeMillis())).isFalse();
	}

	@Test
	void nullState_isRejected() {
		assertThat(bo.consumeState(null, System.currentTimeMillis())).isFalse();
	}

	@Test
	void expiredState_isRejected_andRemoved() throws Exception {
		long issuedAt = 1_000_000L;
		registerState(bo, "old-state", issuedAt);

		long afterTtl = issuedAt + NaverLoginBO.STATE_TTL_MILLIS + 1;
		assertThat(bo.consumeState("old-state", afterTtl))
				.as("TTL 경과 시 거부되어야 한다")
				.isFalse();
		assertThat(bo.issuedStateCount())
				.as("만료된 state는 검증 실패와 함께 제거된다")
				.isZero();
	}

	@Test
	void purgeExpired_dropsOldEntriesOnly() throws Exception {
		long now = 10_000_000L;
		registerState(bo, "fresh", now);
		registerState(bo, "stale", now - NaverLoginBO.STATE_TTL_MILLIS - 1);

		bo.purgeExpired(now);

		assertThat(bo.issuedStateCount()).isOne();
		assertThat(bo.consumeState("fresh", now)).isTrue();
		assertThat(bo.consumeState("stale", now)).isFalse();
	}

	@Test
	void getAccessToken_returnsNull_whenStateInvalid() throws Exception {
		// 발급되지 않은 state로 호출 시 외부 OAuth 호출 없이 즉시 null 반환되어야 한다.
		assertThat(bo.getAccessToken("any-code", "never-issued-state")).isNull();
	}

	@SuppressWarnings("unchecked")
	private static String registerState(NaverLoginBO bo, String state, long issuedAt) throws Exception {
		Field field = NaverLoginBO.class.getDeclaredField("issuedStates");
		field.setAccessible(true);
		java.util.Map<String, Long> map = (java.util.Map<String, Long>) field.get(bo);
		map.put(state, issuedAt);
		return state;
	}

	private static void setField(Object target, String name, Object value) throws Exception {
		Field f = target.getClass().getDeclaredField(name);
		f.setAccessible(true);
		f.set(target, value);
	}
}
