package org.ict.domain;

import lombok.Data;

// 업로드한 파일을 서버로보내고 다시 브라우저로 전송할 수 있도록 하기위함
@Data
public class AttachFileDTO {
	private String fileName;
	private String uploadPath;	// 날짜 정보를 담고있는 경로
	private String uuid;
	private boolean image;		// true: 이미지, false: 이미지가 아님
}
