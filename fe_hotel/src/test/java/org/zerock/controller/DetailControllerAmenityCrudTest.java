package org.zerock.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Field;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;
import org.zerock.config.BackendConfig;
import org.zerock.domain.HotelAmenityVO;

class DetailControllerAmenityCrudTest {

	private DetailController controller;
	private RestTemplate restTemplate;

	@BeforeEach
	void setUp() throws Exception {
		controller = new DetailController();
		restTemplate = mock(RestTemplate.class);
		inject(controller, "restTemplate", restTemplate);
	}

	@Test
	void insertAmenity_postsToBackend_andReturnsBody() {
		HotelAmenityVO vo = sampleAmenity();
		when(restTemplate.postForObject(
				eq(BackendConfig.BACKEND_URL + "/hotel/amenity"),
				any(HttpEntity.class),
				eq(String.class))).thenReturn("success");

		ResponseEntity<String> response = controller.insertAmenity(vo);

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).isEqualTo("success");
		verify(restTemplate).postForObject(
				eq(BackendConfig.BACKEND_URL + "/hotel/amenity"),
				any(HttpEntity.class),
				eq(String.class));
	}

	@Test
	void updateAmenity_putsToBackend_andReturnsSuccess() {
		HotelAmenityVO vo = sampleAmenity();
		vo.setAmenityNo(11);

		ResponseEntity<String> response = controller.updateAmenity(vo);

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).isEqualTo("success");
		verify(restTemplate).put(
				eq(BackendConfig.BACKEND_URL + "/hotel/amenity"),
				any(HttpEntity.class));
	}

	@Test
	void deleteAmenity_callsBackendDelete_andReturnsSuccess() {
		ResponseEntity<String> response = controller.deleteAmenity(99);

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).isEqualTo("success");
		verify(restTemplate).delete(BackendConfig.BACKEND_URL + "/hotel/amenity/99");
	}

	private HotelAmenityVO sampleAmenity() {
		HotelAmenityVO vo = new HotelAmenityVO();
		vo.setHotelNo(7);
		vo.setAmenityName("에어컨");
		vo.setAmenityIcon("bi-snow");
		vo.setAmenityType("POPULAR");
		vo.setAmenityOrder(2);
		return vo;
	}

	private static void inject(Object target, String field, Object value) throws Exception {
		Field f = target.getClass().getDeclaredField(field);
		f.setAccessible(true);
		f.set(target, value);
	}
}
