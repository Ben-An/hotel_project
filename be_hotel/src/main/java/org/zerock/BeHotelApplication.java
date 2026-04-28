package org.zerock;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("org.zerock.mapper")
public class BeHotelApplication {

	public static void main(String[] args) {
		SpringApplication.run(BeHotelApplication.class, args);
	}
}
