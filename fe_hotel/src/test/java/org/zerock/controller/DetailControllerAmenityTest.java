package org.zerock.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;
import org.zerock.config.BackendConfig;
import org.zerock.domain.HotelAmenityVO;

/**
 * detail.jsp 의 "인기 편의 시설/서비스" 섹션 데이터 소스 프록시 회귀 테스트.
 * fe_hotel /hotel/amenity → be_hotel /api/hotel/amenity 호출 시
 * hotelno + 선택적 type 파라미터를 올바른 URL 로 전달하는지 검증한다.
 */
class DetailControllerAmenityTest {

	private DetailController controller;
	private RestTemplate restTemplate;

	@BeforeEach
	void setUp() throws Exception {
		controller = new DetailController();
		restTemplate = mock(RestTemplate.class);
		inject(controller, "restTemplate", restTemplate);
	}

	@Test
	void amenityList_callsBackendWithoutType_whenTypeIsNull() {
		List<HotelAmenityVO> backendList = Arrays.asList(amenity("무료 WiFi", "POPULAR"), amenity("비즈니스 센터", "MAIN"));
		stubExchange(BackendConfig.BACKEND_URL + "/hotel/amenity?hotelno=7", backendList);

		ResponseEntity<List<HotelAmenityVO>> response = controller.amenityList(7, null);

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).hasSize(2);
		verify(restTemplate).exchange(
				eq(BackendConfig.BACKEND_URL + "/hotel/amenity?hotelno=7"),
				eq(HttpMethod.GET),
				any(),
				any(ParameterizedTypeReference.class));
	}

	@Test
	void amenityList_appendsTypeQueryParam_whenTypeProvided() {
		stubExchange(BackendConfig.BACKEND_URL + "/hotel/amenity?hotelno=7&type=POPULAR",
				Collections.singletonList(amenity("에어컨", "POPULAR")));

		ResponseEntity<List<HotelAmenityVO>> response = controller.amenityList(7, "POPULAR");

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).hasSize(1);
		verify(restTemplate).exchange(
				eq(BackendConfig.BACKEND_URL + "/hotel/amenity?hotelno=7&type=POPULAR"),
				eq(HttpMethod.GET),
				any(),
				any(ParameterizedTypeReference.class));
	}

	@Test
	void amenityList_omitsTypeParam_whenTypeIsEmptyString() {
		stubExchange(BackendConfig.BACKEND_URL + "/hotel/amenity?hotelno=7", Collections.emptyList());

		ResponseEntity<List<HotelAmenityVO>> response = controller.amenityList(7, "");

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).isEmpty();
		verify(restTemplate).exchange(
				eq(BackendConfig.BACKEND_URL + "/hotel/amenity?hotelno=7"),
				eq(HttpMethod.GET),
				any(),
				any(ParameterizedTypeReference.class));
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	private void stubExchange(String url, List<HotelAmenityVO> body) {
		ResponseEntity<List<HotelAmenityVO>> entity = new ResponseEntity<>(body, HttpStatus.OK);
		when(restTemplate.exchange(
				eq(url),
				eq(HttpMethod.GET),
				any(HttpEntity.class),
				any(ParameterizedTypeReference.class)))
				.thenReturn((ResponseEntity) entity);
		when(restTemplate.exchange(
				eq(url),
				eq(HttpMethod.GET),
				(HttpEntity) org.mockito.ArgumentMatchers.isNull(),
				any(ParameterizedTypeReference.class)))
				.thenReturn((ResponseEntity) entity);
	}

	private HotelAmenityVO amenity(String name, String type) {
		HotelAmenityVO vo = new HotelAmenityVO();
		vo.setHotelNo(7);
		vo.setAmenityName(name);
		vo.setAmenityIcon("bi-check-lg");
		vo.setAmenityType(type);
		vo.setAmenityOrder(1);
		return vo;
	}

	private static void inject(Object target, String field, Object value) throws Exception {
		Field f = target.getClass().getDeclaredField(field);
		f.setAccessible(true);
		f.set(target, value);
	}
}
