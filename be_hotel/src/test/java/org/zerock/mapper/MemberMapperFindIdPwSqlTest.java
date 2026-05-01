package org.zerock.mapper;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import org.junit.jupiter.api.Test;

class MemberMapperFindIdPwSqlTest {

	private String mapperXml() throws Exception {
		try (InputStream in = getClass().getClassLoader()
				.getResourceAsStream("org/zerock/mapper/MemberMapper.xml")) {
			assertThat(in).as("MemberMapper.xml이 클래스패스에 있어야 한다").isNotNull();
			return new String(in.readAllBytes(), StandardCharsets.UTF_8);
		}
	}

	@Test
	void findMemberIdSqlMatchesByNameAndEmail() throws Exception {
		String xml = mapperXml();

		assertThat(xml)
				.as("findMemberId 는 String 결과를 돌려주어야 한다")
				.containsPattern("(?is)<select\\s+id=\"findMemberId\"[^>]*resultType=\"string\"");

		assertThat(xml)
				.as("findMemberId SQL은 memberName 과 memberEmail 모두를 조건으로 사용해야 한다 (한쪽만으로는 타인 정보 노출 위험)")
				.containsPattern("(?is)<select\\s+id=\"findMemberId\".*?memberName\\s*=\\s*#\\{memberName\\}.*?memberEmail\\s*=\\s*#\\{memberEmail\\}.*?</select>");
	}

	@Test
	void findMemberForPwSqlMatchesByIdAndEmail() throws Exception {
		String xml = mapperXml();

		assertThat(xml)
				.as("findMemberForPw 는 MemberVO 로 매핑되어야 한다")
				.containsPattern("(?is)<select\\s+id=\"findMemberForPw\"[^>]*resultType=\"org\\.zerock\\.domain\\.MemberVO\"");

		assertThat(xml)
				.as("findMemberForPw SQL은 memberId 와 memberEmail 모두를 조건으로 사용해야 한다")
				.containsPattern("(?is)<select\\s+id=\"findMemberForPw\".*?memberId\\s*=\\s*#\\{memberId\\}.*?memberEmail\\s*=\\s*#\\{memberEmail\\}.*?</select>");
	}

	@Test
	void updatePasswordByIdOnlyUpdatesPasswordColumn() throws Exception {
		String xml = mapperXml();

		assertThat(xml)
				.as("updatePasswordById update 가 정의되어 있어야 한다")
				.containsPattern("(?is)<update\\s+id=\"updatePasswordById\"");

		assertThat(xml)
				.as("updatePasswordById 는 memberPassword 만 갱신하고 memberId 로 식별해야 한다 (다른 컬럼 덮어쓰기 방지)")
				.containsPattern("(?is)<update\\s+id=\"updatePasswordById\".*?set\\s+memberPassword\\s*=\\s*#\\{memberPassword\\}\\s*where\\s+memberId\\s*=\\s*#\\{memberId\\}.*?</update>");
	}
}
