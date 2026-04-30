package org.zerock.config;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.InputStream;
import java.util.Properties;

import org.junit.jupiter.api.Test;

class MybatisNullJdbcTypeConfigTest {

	@Test
	void applicationProperties_setsJdbcTypeForNullToNULL() throws Exception {
		Properties props = new Properties();
		try (InputStream in = getClass().getClassLoader()
				.getResourceAsStream("application.properties")) {
			assertThat(in).as("application.properties가 클래스패스에 있어야 한다").isNotNull();
			props.load(in);
		}

		// Oracle JDBC는 setNull(idx, OTHER)을 "부적합한 열 유형: 1111" 예외로 거부한다.
		// 이 키가 사라지면 네이버 OAuth 콜백 등에서 NULL 파라미터를 가진 쿼리가 다시 깨진다.
		assertThat(props.getProperty("mybatis.configuration.jdbc-type-for-null"))
				.isEqualTo("NULL");
	}
}
