package org.zerock.mapper;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import org.junit.jupiter.api.Test;

class DetailMapperAmenitySqlTest {

	private String mapperXml() throws Exception {
		try (InputStream in = getClass().getClassLoader()
				.getResourceAsStream("org/zerock/mapper/DetailMapper.xml")) {
			assertThat(in).as("DetailMapper.xml이 클래스패스에 있어야 한다").isNotNull();
			return new String(in.readAllBytes(), StandardCharsets.UTF_8);
		}
	}

	@Test
	void amenityListSelectExistsAndReturnsHotelAmenityVO() throws Exception {
		String xml = mapperXml();

		assertThat(xml)
				.as("amenityList select 가 정의되어 있어야 하고 resultType=HotelAmenityVO 여야 한다")
				.containsPattern("(?is)<select\\s+id=\"amenityList\"[^>]*resultType=\"org\\.zerock\\.domain\\.HotelAmenityVO\"");
	}

	@Test
	void amenityListSqlFiltersByHotelNoAndOptionalType() throws Exception {
		String xml = mapperXml();

		assertThat(xml)
				.as("amenityList SQL 은 hotelNo = #{hotelNo} 조건을 포함해야 한다")
				.containsPattern("(?is)<select\\s+id=\"amenityList\".*?hotelNo\\s*=\\s*#\\{hotelNo\\}.*?</select>");

		assertThat(xml)
				.as("amenityType 이 주어지면 추가 필터를 적용해야 한다 (조건부 if)")
				.containsPattern("(?is)<select\\s+id=\"amenityList\".*?<if\\s+test=\"amenityType\\s*!=\\s*null[^\"]*\".*?amenityType\\s*=\\s*#\\{amenityType\\}.*?</if>.*?</select>");
	}

	@Test
	void amenityListSqlOrdersByAmenityOrder() throws Exception {
		String xml = mapperXml();

		assertThat(xml)
				.as("amenityList 결과는 amenityOrder 오름차순으로 정렬되어야 한다")
				.containsPattern("(?is)<select\\s+id=\"amenityList\".*?order\\s+by\\s+amenityOrder\\s+asc.*?</select>");
	}
}
