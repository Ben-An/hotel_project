package org.zerock.domain;

import lombok.Data;

@Data
public class FileBlobVO {

	/* 파일 식별자 (경로 문자열) — 예: 2026-05-25/uuid_사진.jpg */
	private String fileName;

	/* 컨텐츠 타입 — 예: image/jpeg */
	private String contentType;

	/* 이미지 바이트 (Oracle BLOB) */
	private byte[] imageData;

}
