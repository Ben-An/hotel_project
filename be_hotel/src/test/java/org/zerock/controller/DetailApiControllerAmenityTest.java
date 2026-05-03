package org.zerock.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.zerock.domain.HotelAmenityVO;
import org.zerock.service.DetailService;

class DetailApiControllerAmenityTest {

	private DetailApiController controller;
	private DetailService service;

	@BeforeEach
	void setUp() throws Exception {
		controller = new DetailApiController();
		service = Mockito.mock(DetailService.class);
		inject(controller, "service", service);
	}

	@Test
	void amenityList_returnsAllAmenities_whenTypeIsNull() {
		HotelAmenityVO popular = amenity(1, "무료 WiFi", "bi-wifi", "POPULAR", 1);
		HotelAmenityVO main = amenity(2, "비즈니스 센터", "bi-check-lg", "MAIN", 4);
		when(service.getAmenityList(1, null)).thenReturn(Arrays.asList(popular, main));

		ResponseEntity<List<HotelAmenityVO>> response = controller.amenityList(1, null);

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).hasSize(2);
		assertThat(response.getBody()).extracting(HotelAmenityVO::getAmenityType)
				.containsExactly("POPULAR", "MAIN");
		verify(service).getAmenityList(1, null);
	}

	@Test
	void amenityList_filtersByType_whenTypeIsProvided() {
		HotelAmenityVO popular = amenity(1, "에어컨", "bi-snow", "POPULAR", 2);
		when(service.getAmenityList(1, "POPULAR")).thenReturn(Collections.singletonList(popular));

		ResponseEntity<List<HotelAmenityVO>> response = controller.amenityList(1, "POPULAR");

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).hasSize(1);
		assertThat(response.getBody().get(0).getAmenityName()).isEqualTo("에어컨");
		verify(service).getAmenityList(1, "POPULAR");
	}

	@Test
	void amenityList_returnsEmptyList_whenHotelHasNoAmenities() {
		when(service.getAmenityList(99, null)).thenReturn(Collections.emptyList());

		ResponseEntity<List<HotelAmenityVO>> response = controller.amenityList(99, null);

		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).isEmpty();
	}

	private HotelAmenityVO amenity(int no, String name, String icon, String type, int order) {
		HotelAmenityVO vo = new HotelAmenityVO();
		vo.setAmenityNo(no);
		vo.setHotelNo(1);
		vo.setAmenityName(name);
		vo.setAmenityIcon(icon);
		vo.setAmenityType(type);
		vo.setAmenityOrder(order);
		return vo;
	}

	private static void inject(Object target, String field, Object value) throws Exception {
		Field f = target.getClass().getDeclaredField(field);
		f.setAccessible(true);
		f.set(target, value);
	}
}
