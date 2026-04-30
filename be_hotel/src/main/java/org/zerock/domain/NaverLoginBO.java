package org.zerock.domain;

import java.io.IOException;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.zerock.mapper.NaverLoginApi;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

@Component
public class NaverLoginBO {

 	/* 인증 요청문을 구성하는 파라미터 */
	//client_id: 애플리케이션 등록 후 발급받은 클라이언트 아이디
	//response_type: 인증 과정에 대한 구분값. code로 값이 고정돼 있습니다.
	//redirect_uri: 네이버 로그인 인증의 결과를 전달받을 콜백 URL(URL 인코딩). 애플리케이션을 등록할 때 Callback URL에 설정한 정보입니다.
	//state: 애플리케이션이 생성한 상태 토큰
	@Value("${naver.oauth.client-id}")
	private String CLIENT_ID;

	@Value("${naver.oauth.client-secret}")
	private String CLIENT_SECRET;

	@Value("${naver.oauth.redirect-uri}")
	private String REDIRECT_URI;

	/* 프로필 조회 API URL */
	private final static String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";

	// fe_hotel ↔ be_hotel 사이 RestTemplate 호출은 세션 쿠키를 보관하지 않아 HttpSession에 state를 보관할 수 없다. 프로세스 메모리에 짧은 TTL로 보관한다.
	static final long STATE_TTL_MILLIS = 5 * 60 * 1000L;
	private final Map<String, Long> issuedStates = new ConcurrentHashMap<>();

	/* 네이버 아이디로 인증  URL 생성  Method */
	public String getAuthorizationUrl() {
		String state = generateRandomString();
		purgeExpired(System.currentTimeMillis());
		issuedStates.put(state, System.currentTimeMillis());
		OAuth20Service oauthService = new ServiceBuilder()
				.apiKey(CLIENT_ID)
				.apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI)
				.state(state)
				.build(NaverLoginApi.instance());
		return oauthService.getAuthorizationUrl();
	}

	/* 네이버아이디로 Callback 처리 및  AccessToken 획득 Method */
	public OAuth2AccessToken getAccessToken(String code, String state) throws IOException {
		if (!consumeState(state, System.currentTimeMillis())) {
			return null;
		}
		OAuth20Service oauthService = new ServiceBuilder()
				.apiKey(CLIENT_ID)
				.apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI)
				.state(state)
				.build(NaverLoginApi.instance());
		return oauthService.getAccessToken(code);
	}

	boolean consumeState(String state, long now) {
		if (state == null) {
			return false;
		}
		Long issuedAt = issuedStates.remove(state);
		if (issuedAt == null) {
			return false;
		}
		return now - issuedAt <= STATE_TTL_MILLIS;
	}

	void purgeExpired(long now) {
		issuedStates.entrySet().removeIf(e -> now - e.getValue() > STATE_TTL_MILLIS);
	}

	int issuedStateCount() {
		return issuedStates.size();
	}

	private String generateRandomString() {
		return UUID.randomUUID().toString();
	}

	/* Access Token을 이용하여 네이버 사용자 프로필 API를 호출 */
	public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException {
		OAuth20Service oauthService = new ServiceBuilder()
				.apiKey(CLIENT_ID)
				.apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI).build(NaverLoginApi.instance());
		OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
		oauthService.signRequest(oauthToken, request);
		Response response = request.send();
		return response.getBody();
	}
}
