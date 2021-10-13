package org.ict.controller;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.ict.domain.AttachFileDTO;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	
	// 이미지 파일 여부를 체크
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		}catch(IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	private String getFolder() {
		// 날짜에 맞춰서 폴더형식을 만들어주는 함수로 파일 업로드 시 업로드 날짜별로 폴더를 만들어 관리
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// java.util.Date
		Date date = new Date();
		String str = sdf.format(date);
		// File.separator로 2021폴더 아래 10폴더 아래 13폴더 아래 파일 업로드
		return str.replace("-", File.separator);
	}
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload form");
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		// web.xml에서 지정한 경로와 같은 경로를 작성해 파일이 업로드되면 해당 폴더에 저장될 수 있게함
		String uploadFolder = "C:\\upload_data\\temp";
		
		// uploadFile로 파일이 여러개 업로드되는 것을 for문으로 로그 추적
		for(MultipartFile multipartFile : uploadFile) {
			log.info("=================");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());
			
			// 저장된 파일의 정보(저장되는 위치, 업로드되는 파일의 이름)
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			
			try {
				// 파일을 저장
				multipartFile.transferTo(saveFile);
				log.info("파일 저장완료");
			}catch(Exception e) {
				log.error(e.getMessage());
			}
		}
	}
	
	// ajax로 파일 업로드
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax");
	}
	
	// 일반 컨트롤러에서 rest요청을 처리하는 경우에 작성
	@ResponseBody
	@PostMapping("/uploadAjaxAction")
	public void uploadAjaxPost(MultipartFile[] uploadFile) {
		log.info("ajax post update!");
		
		String uploadFolder = "C:\\upload_data\\temp";
		
		// 폴더 생성, getFolder() 메서드를 호출
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload path: " + uploadPath);
		// 해당 날짜 폴더가 존재하는지 확인(exists()메서드)해 존재하지 않는다면 mkdirs() 메서드를 작성해 자동으로 생성하는 로직 추가
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartFile : uploadFile) {
			log.info("=================");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			log.info("파일명 \\ 자르기 전: " + uploadFileName);
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			
			log.info("last file name: " + uploadFileName);
			
			/* UUID: 중복된 파일명이 업로드 될 경우, 이후에 추가된 파일만 남게되므로 랜덤으로 지정되는 UUID를 발급받아서 파일명에 포함시킴
			 * 파일을 저장하기 전에 uuid를 발급받아 파일명을 수정
			 */
			UUID uuid = UUID.randomUUID();
			// uuid를 문자로 변경하고 _로 구분하고 기존의 파일명에 붙여줌
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			// 파일 객체로 저장
			//File saveFile = new File(uploadFolder, uploadFileName);
			// 고정된 폴더에 저장하던 경로를 날짜정보를 포함한 경로의 폴더로 변경해서 저장
			//File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				// 썸네일 생성 - "s_파일명", 사이즈는 100px*100px으로 저장
				if(checkImageType(saveFile)) {
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
			}catch(Exception e) {
				log.error(e.getMessage());
			}
		}
	}
	
	@PostMapping(value="/uploadFormAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadFormPost(MultipartFile[] uploadFile){
		
	}
	
}




















