package org.zerock.mapper;

import org.zerock.domain.FileBlobVO;

public interface FileBlobMapper {

	/* 이미지 바이트 저장 */
	public void insertBlob(FileBlobVO vo);

	/* 파일명으로 이미지 조회 */
	public FileBlobVO selectBlob(String fileName);

	/* 파일명으로 이미지 삭제 */
	public int deleteBlob(String fileName);
}
