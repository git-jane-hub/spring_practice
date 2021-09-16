package org.ict.controller;

import java.util.List;

import org.ict.domain.BoardVO;
import org.ict.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller					// 의존성 등록
@Log4j						// 로깅
@RequestMapping("/board/*")	// 이 클래스를 사용하는 모든 메서드의 연결주소 앞에 /board 가 추가됨
@AllArgsConstructor			// 의존성 주입 설정을 위해 생성자만 생성(모든 필드값을 파라미터로 받는 생성자 <-> @NoArgsConstructor)
public class BoardController {
	// controller는 service 호출 - service는 mapper를 호출
	@Autowired
	private BoardService service;
	
	// 리스트 목록을 보여주는 로직 
	// Get방식으로만 주소 연결
	@GetMapping("/list")
	public void list(Model model) {
		log.info("list로 접속");
		// 전체 글 정보를 얻어옴
		List<BoardVO> boardList = service.getList();
		// view 파일에 list라는 이름으로 넘겨줌
		model.addAttribute("list", boardList);
	}
	
	// 글을 작성하고 리스트 목록으로 보내주는 로직 
	@PostMapping("/register")
	public String register(BoardVO vo, RedirectAttributes rttr) {
		// 글을 작성하고 나서 상세페이지 혹은 글목록으로 이동해야함 
		// 1. 글작성 로직 실행 후, 
		service.register(vo);
		/*
		// 2.다시 목록을 DB에서 꺼내옴
		List<BoardVO> boardList = service.getList();
		// 3. list.jsp를 화면으로 표출
		model.addAttribute("list", boardList);
		*/
		// 2. 위 "/list" 주소로 강제 이동을 시켜 같은 로직을 중복해서 작성하지 않도록 함
		/* 이동시 새로 작성한 글이 몇번 글인지 전달해주는 로직 추가
		 * addFlashAttribute는 redirect 시 컨트롤러에서 .jsp파일로 데이터를 보내줄 때 사용
		 * model.addAttribute()를 작성하고 redirect이동시에는 데이터가 소실됨
		 * 따라서 rttr.addFlashAttribute를 사용해서 정보를 함께 전달
		 */
		rttr.addFlashAttribute("result", vo.getBno());
		// views 폴더 하위 board 폴더의 list.jsp 출력
		// redirect로 이동시에는 "redirect:파일명"
		return "redirect:/board/list";
	}
	
	// 접근 방식에 따라 다른 페이지로 이동하는 방식
	@GetMapping("/register")
	public String registerForm() {
		return "/board/register";
	}
	
	// 상세 페이지 조회는 Long bno에 적힌 글번호를 이용
	@GetMapping("/get")
	public String get(Long bno, Model model) {
		// 로직이 실행되기 전에 bno가 null로 들어오는 경우(bno값이 없는 경우),
		// DB에 없는 데이터 bno가 파라미터 값으로 들어올 경우도 추가
		if(bno == null) {
			return "redirect:/board/list";
		}
		// 현재 url뒤 ?bno= 파라미터를 통해 글 번호만 전달받음 - 번호를 이용해 글 정보를 받아와야함
		BoardVO vo = service.get(bno);
		log.info("받아온 객체: " + vo);
		// .jsp 파일로 vo를 전달 
		model.addAttribute("boardvo", vo);
		// get.jsp와 연결 
		return "/board/get";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
