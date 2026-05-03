package org.zerock.mapper;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import org.junit.jupiter.api.Test;

class DetailMapperAmenityCrudSqlTest {

	private String mapperXml() throws Exception {
		try (InputStream in = getClass().getClassLoader()
				.getResourceAsStream("org/zerock/mapper/DetailMapper.xml")) {
			assertThat(in).as("DetailMapper.xml이 클래스패스에 있어야 한다").isNotNull();
			return new String(in.readAllBytes(), StandardCharsets.UTF_8);
		}
	}

	@Test
	void getAmenitySelect_isDefined_andUsesAmenityNoFilter() throws Exception {
		String xml = mapperXml();

		assertThat(xml)
				.as("getAmenity select 가 정의되어 있어야 하고 resultType=HotelAmenityVO 여야 한다")
				.containsPattern("(?is)<select\\s+id=\"getAmenity\"[^>]*resultType=\"org\\.zerock\\.domain\\.HotelAmenityVO\"");

		assertThat(xml)
				.as("getAmenity SQL 은 amenityNo = #{amenityNo} 조건을 사용해야 한다")
				.containsPattern("(?is)<select\\s+id=\"getAmenity\".*?amenityNo\\s*=\\s*#\\{amenityNo\\}.*?</select>");
	}

	@Test
	void insertAmenitySql_usesSequenceAndAllColumns() throws Exception {
		String xml = mapperXml();

		assertThat(xml)
				.as("insertAmenity 가 hotel_amenity_seq.nextval 을 사용해야 한다")
				.containsPattern("(?is)<insert\\s+id=\"insertAmenity\".*?hotel_amenity_seq\\.nextval.*?</insert>");

		assertThat(xml)
				.as("insertAmenity 는 amenityName/Icon/Type/Order 를 모두 바인딩해야 한다")
				.containsPattern(
						"(?is)<insert\\s+id=\"insertAmenity\".*?#\\{hotelNo\\}.*?#\\{amenityName\\}.*?#\\{amenityIcon\\}.*?#\\{amenityType\\}.*?#\\{amenityOrder\\}.*?</insert>");
	}

	@Test
	void updateAmenitySql_setsCoreColumns_andFiltersByAmenityNo() throws Exception {
		String xml = mapperXml();

		assertThat(xml)
				.as("updateAmenity 는 amenityName/Icon/Type/Order 를 set 하고 amenityNo 로 필터해야 한다")
				.containsPattern(
						"(?is)<update\\s+id=\"updateAmenity\".*?amenityName\\s*=\\s*#\\{amenityName\\}.*?amenityIcon\\s*=\\s*#\\{amenityIcon\\}.*?amenityType\\s*=\\s*#\\{amenityType\\}.*?amenityOrder\\s*=\\s*#\\{amenityOrder\\}.*?where\\s+amenityNo\\s*=\\s*#\\{amenityNo\\}.*?</update>");
	}

	@Test
	void deleteAmenitySql_filtersByAmenityNo() throws Exception {
		String xml = mapperXml();

		assertThat(xml)
				.as("deleteAmenity 는 amenityNo = #{amenityNo} 조건으로만 삭제해야 한다")
				.containsPattern("(?is)<delete\\s+id=\"deleteAmenity\".*?delete\\s+from\\s+hotel_amenity\\s+where\\s+amenityNo\\s*=\\s*#\\{amenityNo\\}.*?</delete>");
	}
}
