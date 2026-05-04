package org.zerock.mapper;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import org.junit.jupiter.api.Test;

class BoardMapperSearchCheckInOutSqlTest {

	private String mapperXml() throws Exception {
		try (InputStream in = getClass().getClassLoader()
				.getResourceAsStream("org/zerock/mapper/BoardMapper.xml")) {
			assertThat(in).as("BoardMapper.xml이 클래스패스에 있어야 한다").isNotNull();
			return new String(in.readAllBytes(), StandardCharsets.UTF_8);
		}
	}

	@Test
	void hotelListWithPagingHasCheckInCheckOutGuardedBlock() throws Exception {
		String xml = mapperXml();

		assertThat(xml)
				.as("checkIn / checkOut 둘 다 비어있지 않을 때만 예약 가용성 필터가 추가되어야 한다")
				.containsPattern("(?is)<select\\s+id=\"hotelListWithPaging\".*?"
						+ "<if\\s+test=\"checkIn\\s*!=\\s*null\\s+and\\s+checkIn\\s*!=\\s*''\\s+and\\s+checkOut\\s*!=\\s*null\\s+and\\s+checkOut\\s*!=\\s*''\".*?"
						+ "</if>.*?</select>");
	}

	@Test
	void hotelListWithPagingFiltersByRoomAvailability() throws Exception {
		String xml = mapperXml();

		assertThat(xml)
				.as("hotelListWithPaging SQL 은 hotel_room 에 대해 EXISTS 로 가용 객실을 검사해야 한다")
				.containsPattern("(?is)<select\\s+id=\"hotelListWithPaging\".*?"
						+ "EXISTS\\s*\\(\\s*SELECT\\s+1\\s+FROM\\s+hotel_room\\s+hr\\s+WHERE\\s+hr\\.hotelNo\\s*=\\s*h\\.hotelNo.*?</select>");

		assertThat(xml)
				.as("가용 판정은 reservation 테이블에 대해 NOT EXISTS 로 겹치는 예약이 없는 객실을 찾아야 한다")
				.containsPattern("(?is)<select\\s+id=\"hotelListWithPaging\".*?"
						+ "NOT\\s+EXISTS\\s*\\(\\s*SELECT\\s+1\\s+FROM\\s+reservation\\s+r\\s+WHERE\\s+r\\.roomNo\\s*=\\s*hr\\.roomNo.*?</select>");
	}

	@Test
	void hotelListWithPagingUsesHalfOpenIntervalOverlap() throws Exception {
		String xml = mapperXml();

		assertThat(xml)
				.as("기간 충돌 판정은 r.checkInDate < TO_DATE(#{checkOut}) 조건을 사용해야 한다 (half-open)")
				.containsPattern("(?is)r\\.checkInDate\\s*&lt;\\s*TO_DATE\\(#\\{checkOut\\}");

		assertThat(xml)
				.as("기간 충돌 판정은 r.checkOutDate > TO_DATE(#{checkIn}) 조건을 사용해야 한다 (half-open)")
				.containsPattern("(?is)r\\.checkOutDate\\s*&gt;\\s*TO_DATE\\(#\\{checkIn\\}");
	}
}
