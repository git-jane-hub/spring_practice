package org.ict.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class UploadController {
	
	private boolean checkImageType(File file) {
		try {
			/* Files.probeContentType(): 파일의 mime 타입을 확인하는 메서드
			 * 확장자를 이용해 mime 타입을 확인하는데, 확장자가 없으면 null을 반환
			 * toPath(): 파일의 경로를 가져옴
			 */
			String contentType = Files.probeContentType(file.toPath());
			log.info("contentType: " + contentType);
			// startsWith(): 대상 문자열이 파라미터 값의 문자열로 시작하는지 확인하는 메서드 - 시작하면 true 반환
			return contentType.startsWith("image");
		}catch(IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
	private String getFolder() {
		// 날짜를 원하는 포맷으로 출력하는 SimpleDateFormat
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		// 위에서 선언한 Date 객체를 String으로 format 지정
		String str = sdf.format(date);
		// 파일 구분자는 운영체제마다 다른데, File.separator는 JVM이 실행되는 환경의 OS의 구분자를 제공해주는 API
		return str.replace("-", File.separator);
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax 접속");
	}
	
	@ResponseBody
	@PostMapping("/uploadAjaxAction")
	public void uploadAjaxPost(MultipartFile[] uploadFile) {
		log.info("ajax post update!");
		String uploadFolder = "C:\\upload_data\\test";
		
		// 
		File uploadPath = new File(uploadFolder, getFolder());
		// 'C:/upload_data\test'
		log.info("uploadFolder: " + uploadFolder);
		// 2021\10\15
		log.info("getFolder(): " + getFolder());
		// C:/upload_data\test\2021\10\15
		log.info("uploadPath: " + uploadPath);
		
		// 위에서 폴더 지정하는 형식을 받아와 해당 폴더가 존재하지 않는다면 생성
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartFile : uploadFile) {
			String uploadFileName = multipartFile.getOriginalFilename();
			log.info("multipartFile.getOriginalFilename(): " + multipartFile.getOriginalFilename());
			
			/* substring(): 0부터 파라미터에 들어가는 int 값을 포함한 문자열을 자르고 리턴
			 * lastIndexOf(): String의 마지막 문자부터 처음문자로 되돌아오면서 해당 문자열의 index를 찾음
			 * uploadFileName의 "\\"가 있는 자리를 찾아 1을 더하고 해당 인덱스 이후부터 자르고 리턴
			 */
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("uploadFileName: " + uploadFileName);
			
			// UUID를 발급해 유일한 식별자 생성
			UUID uuid = UUID.randomUUID();
			
			try {
				// File 객체를 생성해 저장될 경로와 파일이름을 넣어줌
				//File saveFile = new File(uploadFolder, uploadFileName);
				// uploadFolder에서 'C:\\upload_data\\test' 경로만 지정했는데 날짜 정보를 포함한 폴더로 변경
				File saveFile = new File(uploadPath, uploadFileName);
				// transferTo(): 파라미터에 File 객체를 넣어 파일 저장하는 메서드
				multipartFile.transferTo(saveFile);
			}catch(Exception e) {
				log.error(e.getMessage());
			}
		}
	}
}
