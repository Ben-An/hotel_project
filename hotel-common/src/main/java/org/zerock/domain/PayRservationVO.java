package org.zerock.domain;

import java.util.Date;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.zerock.util.DateObjectFormatter;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import lombok.Data;

@Data
public class PayRservationVO {
	@Min(value = 1, message = "회원 정보가 필요합니다")
	private int memberNo;

	@Min(value = 1, message = "객실 정보가 필요합니다")
	private int roomNo;

	@NotBlank(message = "예약자명을 입력해주세요")
	@Size(min = 2, max = 30, message = "예약자명은 2~30자여야 합니다")
	private String realUser;

	@NotNull(message = "체크인 날짜를 선택해주세요")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date checkInDate;

	@NotNull(message = "체크아웃 날짜를 선택해주세요")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date checkOutDate;

	@Min(value = 1, message = "인원은 1명 이상이어야 합니다")
	@Max(value = 10, message = "인원은 10명 이하여야 합니다")
	private int userAmount;

	@NotBlank(message = "결제 방법을 선택해주세요")
	private String payment;       
}
