package org.zerock.mapper;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import org.junit.jupiter.api.Test;

class MemberMapperEmailChkSqlTest {

	private String mapperXml() throws Exception {
		try (InputStream in = getClass().getClassLoader()
				.getResourceAsStream("org/zerock/mapper/MemberMapper.xml")) {
			assertThat(in).as("MemberMapper.xml이 클래스패스에 있어야 한다").isNotNull();
			return new String(in.readAllBytes(), StandardCharsets.UTF_8);
		}
	}

	@Test
	void emailCheckSelectExistsAndUsesMemberEmailColumn() throws Exception {
		String xml = mapperXml();

		assertThat(xml)
				.as("emailCheck select 가 정의되어 있어야 하고 resultType=int 여야 한다")
				.containsPattern("(?is)<select\\s+id=\"emailCheck\"[^>]*resultType=\"int\"");

		assertThat(xml)
				.as("emailCheck SQL은 memberEmail 컬럼을 #{memberEmail} 파라미터로 비교해야 한다")
				.containsPattern("(?is)<select\\s+id=\"emailCheck\".*?count\\(\\*\\).*?memberEmail\\s*=\\s*#\\{memberEmail\\}.*?</select>");
	}
}
