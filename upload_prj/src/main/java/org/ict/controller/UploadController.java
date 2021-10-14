package org.ict.controller;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.ict.domain.AttachFileDTO;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
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
	@PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile){
		log.info("ajax post update!");
		
		// 이미지 여러개를 받아야하기 때문에 먼저 ArrayList를 생성
		List<AttachFileDTO> list = new ArrayList();
		
		String uploadFolder = "C:\\upload_data\\temp";
		
		// 폴더 생성, getFolder() 메서드를 호출
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload path: " + uploadPath);
		/* 해당 날짜 폴더가 존재하는지 확인(exists()메서드)해 존재하지 않는다면 
		 * mkdirs() 메서드를 작성해 자동으로 생성하는 로직 추가
		 */
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartFile : uploadFile) {
			log.info("=================");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());
			
			/* 파일명, 폴더경로(날짜 정보를 포함), UUID, 그림파일 여부를 모두 해당 반복문에서 처리하므로
			 * 썸네일을 만들기 전에 상단에 AttachFileDTO 생성
			 */
			AttachFileDTO attachDTO = new AttachFileDTO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			log.info("파일명 \\ 자르기 전: " + uploadFileName);
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			
			log.info("last file name: " + uploadFileName);
			
			// uuid가 uploadFileName에 포함되기 전에 setter에 넣어줘서 uuid가 중복으로 입력되지 않도록 함
			attachDTO.setFileName(uploadFileName);
			
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
				
				// AttachFileDTO에 setter로 데이터 입력
				
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(getFolder());
				
				// 썸네일 생성 - "s_파일명", 사이즈는 100px*100px으로 저장
				if(checkImageType(saveFile)) {
					/* 클래스 생성 후 boolean 타입은 자료형을 입력하지 않으면 자동으로 false로 간주됨
					 * attachDTO.setImage()은 해당 if문으로 진입하지 않으면 false
					 */
					attachDTO.setImage(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				// 정상적으로 이미지에 대한 정보가 입력되었다면 list에 넣기
				list.add(attachDTO);
			}catch(Exception e) {
				log.error(e.getMessage());
			}
		}// end for
		return new ResponseEntity<List<AttachFileDTO>>(list, HttpStatus.OK);
	}
	
	// 파일이름을 파라미터에 넣으면 웹에서 사용할 수 있는 경로로 바꿔줌
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("fileName: " + fileName);
		
		File file = new File("C:\\upload_data\\temp\\" + fileName);
		
		log.info("file: " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}catch(IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 해당 url로 접속하면 업로드한 파일을 다운받을 수 있도록함
	@GetMapping(value="/download", produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(String fileName){
		log.info("download file: " + fileName);
		Resource resource = new FileSystemResource("C:\\upload_data\\temp\\" + fileName);
		log.info("resource: " + resource);
		
		String resourceName = resource.getFilename();
		HttpHeaders headers = new HttpHeaders();
		
		try {
			headers.add("Content-Disposition", "attachment; filename=" + 
					new String(resourceName.getBytes("UTF-8"), "ISO-8859-1"));// 한글로 인코딩
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		log.info("deleteFile: " + fileName);
		File file = null;
		try {
			file = new File("C:\\upload_data\\temp\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			// 화면에서 썸네일을 먼저 삭제하기 때문에 원본파일도 찾아서 삭제햐줘야함
			if(type.equals("image")) {
				// 썸네일 파일명에서 's_'를 소거
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				log.info("원본 파일명: " + largeFileName);
				file = new File(largeFileName);
				file.delete();
			}
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
}




















