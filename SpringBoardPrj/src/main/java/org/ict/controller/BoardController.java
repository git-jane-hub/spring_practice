package org.ict.controller;

import java.util.List;

import org.ict.domain.BoardVO;
import org.ict.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller					// 의존성 등록
@Log4j						// 로깅
@RequestMapping("/board/*")	// 이 클래스를 사용하는 모든 메서드의 연결주소 앞에 /board 가 추가됨
@AllArgsConstructor			// 의존성 주입 설정을 위해 생성자만 생성
public class BoardController {
	// controller는 service 호출 - service는 mapper를 호출
	@Autowired
	private BoardService service;
	
	// Get방식으로만 주소 연결
	@GetMapping("/list")
	public void list(Model model) {
		log.info("list로 접속");
		// 전체 글 정보를 얻어옴
		List<BoardVO> boardList = service.getList();
		// view 파일에 list라는 이름으로 넘겨줌
		model.addAttribute("list", boardList);
	}
}
