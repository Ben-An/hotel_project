package org.zerock.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.Arrays;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.zerock.domain.HotelAmenityVO;
import org.zerock.mapper.DetailMapper;

class DetailServiceImplAmenityTest {

	private DetailServiceImpl service;
	private DetailMapper mapper;

	@BeforeEach
	void setUp() {
		mapper = Mockito.mock(DetailMapper.class);
		service = new DetailServiceImpl(mapper);
	}

	@Test
	void getAmenityList_delegatesToMapper_withTypeFilter() {
		HotelAmenityVO popular = new HotelAmenityVO();
		popular.setAmenityName("무료 WiFi");
		popular.setAmenityType("POPULAR");
		when(mapper.amenityList(1, "POPULAR")).thenReturn(Arrays.asList(popular));

		List<HotelAmenityVO> result = service.getAmenityList(1, "POPULAR");

		assertThat(result).hasSize(1);
		assertThat(result.get(0).getAmenityName()).isEqualTo("무료 WiFi");
		verify(mapper).amenityList(1, "POPULAR");
	}

	@Test
	void getAmenityList_passesNullType_whenTypeNotProvided() {
		when(mapper.amenityList(1, null)).thenReturn(java.util.Collections.emptyList());

		List<HotelAmenityVO> result = service.getAmenityList(1, null);

		assertThat(result).isEmpty();
		verify(mapper).amenityList(1, null);
	}
}
