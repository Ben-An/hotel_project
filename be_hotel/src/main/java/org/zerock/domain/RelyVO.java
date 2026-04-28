package org.zerock.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class RelyVO {
	private int reviewNo;
	private int memberNo;

	@Min(value = 1, message = "호텔 정보가 필요합니다")
	private int hotelNo;

	@Min(value = 1, message = "평점은 1점 이상이어야 합니다")
	@Max(value = 5, message = "평점은 5점 이하여야 합니다")
	private int grade;

	private String memberNickname;

	@NotBlank(message = "리뷰 내용을 입력해주세요")
	@Size(min = 10, max = 500, message = "리뷰는 10~500자여야 합니다")
	private String reviewContent;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date reviewDate;
	private String report;
}
