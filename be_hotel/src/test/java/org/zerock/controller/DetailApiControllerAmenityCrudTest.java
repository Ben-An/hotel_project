package org.zerock.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Field;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.zerock.domain.HotelAmenityVO;
import org.zerock.service.DetailService;

class DetailApiControllerAmenityCrudTest {

	private DetailApiController controller;
	private DetailService service;

	@BeforeEach
	void setUp() throws Exception {
		controller = new DetailApiController();
		service = Mockito.mock(DetailService.class);
		inject(controller, "service", service);
	}

	@Test
	void insertAmenity_returnsSuccess_whenServiceReturns1() {
		HotelAmenityVO vo = sampleAmenity();
		when(service.insertAmenity(any(HotelAmenityVO.class))).thenReturn(1);

		ResponseEntity<String> response = controller.insertAmenity(vo);

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).isEqualTo("success");
		ArgumentCaptor<HotelAmenityVO> captor = ArgumentCaptor.forClass(HotelAmenityVO.class);
		verify(service).insertAmenity(captor.capture());
		assertThat(captor.getValue().getAmenityName()).isEqualTo("무료 WiFi");
	}

	@Test
	void insertAmenity_returns500_whenServiceReturns0() {
		when(service.insertAmenity(any(HotelAmenityVO.class))).thenReturn(0);

		ResponseEntity<String> response = controller.insertAmenity(sampleAmenity());

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@Test
	void updateAmenity_returnsSuccess_whenServiceReturns1() {
		HotelAmenityVO vo = sampleAmenity();
		vo.setAmenityNo(7);
		when(service.updateAmenity(any(HotelAmenityVO.class))).thenReturn(1);

		ResponseEntity<String> response = controller.updateAmenity(vo);

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).isEqualTo("success");
	}

	@Test
	void updateAmenity_returns500_whenServiceReturns0() {
		when(service.updateAmenity(any(HotelAmenityVO.class))).thenReturn(0);

		ResponseEntity<String> response = controller.updateAmenity(sampleAmenity());

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@Test
	void deleteAmenity_returnsSuccess_whenServiceReturns1() {
		when(service.deleteAmenity(42)).thenReturn(1);

		ResponseEntity<String> response = controller.deleteAmenity(42);

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).isEqualTo("success");
		verify(service).deleteAmenity(42);
	}

	@Test
	void deleteAmenity_returns500_whenServiceReturns0() {
		when(service.deleteAmenity(99)).thenReturn(0);

		ResponseEntity<String> response = controller.deleteAmenity(99);

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	private HotelAmenityVO sampleAmenity() {
		HotelAmenityVO vo = new HotelAmenityVO();
		vo.setHotelNo(1);
		vo.setAmenityName("무료 WiFi");
		vo.setAmenityIcon("bi-wifi");
		vo.setAmenityType("POPULAR");
		vo.setAmenityOrder(1);
		return vo;
	}

	private static void inject(Object target, String field, Object value) throws Exception {
		Field f = target.getClass().getDeclaredField(field);
		f.setAccessible(true);
		f.set(target, value);
	}
}
