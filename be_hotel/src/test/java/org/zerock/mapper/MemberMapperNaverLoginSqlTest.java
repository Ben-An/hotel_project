package org.zerock.mapper;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.InputStream;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.junit.jupiter.api.Test;

/**
 * member 테이블의 naverLogin 컬럼 추가에 따른 매퍼 SQL 정합성 회귀 테스트.
 * Why: ORA-00904 "NAVERLOGIN": 부적합한 식별자 사고가 다시 일어나지 않도록
 * 매퍼와 DDL이 어긋나는 변경을 빌드 단계에서 잡아낸다.
 */
class MemberMapperNaverLoginSqlTest {

	private static final Pattern INSERT_COLUMNS =
			Pattern.compile("(?is)<insert\\s+id=\"userNaverRegisterPro\".*?insert\\s+into\\s+member\\s*\\(([^)]+)\\)\\s*values\\s*\\((.*?)\\)\\s*</insert>");

	private String mapperXml() throws Exception {
		try (InputStream in = getClass().getClassLoader()
				.getResourceAsStream("org/zerock/mapper/MemberMapper.xml")) {
			assertThat(in).as("MemberMapper.xml이 클래스패스에 있어야 한다").isNotNull();
			return new String(in.readAllBytes(), java.nio.charset.StandardCharsets.UTF_8);
		}
	}

	@Test
	void naverLookupSqlsReferenceNaverLoginColumn() throws Exception {
		String xml = mapperXml();

		assertThat(xml)
				.as("naverConnectionCheck SQL은 naverLogin 컬럼을 SELECT 해야 한다")
				.containsPattern("(?is)<select\\s+id=\"naverConnectionCheck\".*?naverLogin.*?</select>");

		assertThat(xml)
				.as("userNaverLoginPro SQL은 naverLogin = #{id} 조건을 사용해야 한다")
				.containsPattern("(?is)<select\\s+id=\"userNaverLoginPro\".*?NAVERLOGIN\\s*=\\s*#\\{id\\}.*?</select>");

		assertThat(xml)
				.as("setNaverConnection SQL은 naverLogin 을 UPDATE 해야 한다")
				.containsPattern("(?is)<update\\s+id=\"setNaverConnection\".*?SET\\s+NAVERLOGIN\\s*=\\s*#\\{id\\s*\\}.*?</update>");
	}

	@Test
	void userNaverRegisterProInsertColumnsAndValuesAreAligned() throws Exception {
		String xml = mapperXml();

		Matcher m = INSERT_COLUMNS.matcher(xml);
		assertThat(m.find())
				.as("userNaverRegisterPro INSERT는 컬럼 목록을 명시해야 한다 (위치 의존 금지)")
				.isTrue();

		String columnList = m.group(1);
		String valueList = m.group(2);

		int columnCount = columnList.split(",").length;
		// VALUES 안에는 NVL(...) 같은 함수 호출이 들어가 단순 콤마 분할로는 셀 수 없다.
		// 최상위 콤마만 세기 위해 괄호 깊이를 추적한다.
		int valueCount = countTopLevelCommaSeparated(valueList);

		assertThat(columnCount)
				.as("INSERT 컬럼 개수와 VALUES 항목 개수가 일치해야 한다 (columns=%s, values=%s)",
						columnList.trim(), valueList.trim())
				.isEqualTo(valueCount);

		assertThat(columnList)
				.as("INSERT 컬럼 목록에 naverLogin 이 포함되어야 한다")
				.containsIgnoringCase("naverLogin");

		assertThat(columnList)
				.as("memberRole 컬럼이 명시되어야 한다 — naver 가입 시 역할이 'USER' 로 저장되어야 함")
				.containsIgnoringCase("memberRole");

		assertThat(valueList)
				.as("memberRole 값으로 'USER' 리터럴이 들어가야 한다 (#{id} 가 role 자리에 들어가던 과거 버그 회귀 방지)")
				.contains("'USER'");
	}

	private static int countTopLevelCommaSeparated(String values) {
		int depth = 0;
		int items = 1;
		for (int i = 0; i < values.length(); i++) {
			char c = values.charAt(i);
			if (c == '(') depth++;
			else if (c == ')') depth--;
			else if (c == ',' && depth == 0) items++;
		}
		return items;
	}
}
