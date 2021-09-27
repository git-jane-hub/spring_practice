package org.ict.controller;
// test순서: 먼저 controller에 작성 - 해당 주소로 진입하면 로직 실행되는지 테스트 - jsp 파일 작성
import java.util.List;

import org.ict.domain.BoardVO;
import org.ict.domain.Criteria;
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
	/*
	// 리스트 목록을 보여주는 로직 
	// Get방식으로만 주소 연결
	@GetMapping("/list")
	public void list(Model model, String keyword) {
		if(keyword == null) {
			keyword = "";
		}
		log.info("list로 접속");
		// 전체 글 정보를 얻어옴
		List<BoardVO> boardList = service.getList(keyword);
		// view 파일에 list라는 이름으로 넘겨줌
		model.addAttribute("list", boardList);
		model.addAttribute("keyword", keyword);
	}
	*/
	
	// 페이징 처리가 가능한 list 메서드를 새로 생성
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		List<BoardVO> boardList = service.getPagingList(cri);
		model.addAttribute("list", boardList);
		// 메서드 이름과 url주소명이 같은 void 타입의 메서드는 board/list.jsp로 자동연결됨
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
		rttr.addFlashAttribute("success", "register");
		log.info("받아온 bno값: " + vo.getBno());
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
	
	/* get방식으로 작성하게되면 특정 사용자가 url을 통해 다른 사용자들의 글을 삭제 가능하게되므로
	 * 삭제는 삭제버튼을 통해서만 삭제할 수 있도록 post 방식 접근만 허용
	 * bno를 받아 삭제하고 삭제가 완료되면 success라는 문자열을 .jsp파일로 전달
	 */
	/* post 방식으로 작성하면 remove하기 위해서는 form 태그내부를 통해서만 가능(예: 삭제버튼)
	 * 위 get 방식처럼 if문으로 검증 로직을 작성할 필요가 적음
	 */
	@PostMapping("/remove")
	public String remove(Long bno, RedirectAttributes rttr) {
		log.info("삭제 진행: " + bno);
		service.remove(bno);
		rttr.addFlashAttribute("success", "remove");
		rttr.addFlashAttribute("bno", bno);
		return "redirect:/board/list";
	}
	
	// 수정 폼으로 이동하는 로직 - 이전에 작성되었던 게시글을 불러와야함(파라미터를 통해 글번호를 가지고있음)
	@PostMapping("/boardmodify")
	public String modifyForm(Long bno, Model model) {
		BoardVO vo = service.get(bno);
		log.info(vo);
		model.addAttribute("vo", vo);
		return "/board/modify";
	}
	
	// 수정 폼에서 변경을 완료하면 반영하는 로직 - modify.jsp에서 넘겨받은 정보를 사용해 파라미터에 작성
	// 변경내역을 확인할 수 있도록 상세페이지로 이동
	@PostMapping("/modify")
	public String modify(BoardVO vo, RedirectAttributes rttr) {
		log.info("modify.jsp 에서 넘겨받은 정보: " + vo);
		service.modify(vo);
		rttr.addFlashAttribute("modi", "modi");
		rttr.addFlashAttribute("bno", vo.getBno());
		// 상세페이지는 bno가 파라미터로 주어져야함
		return "redirect:/board/get?bno=" + vo.getBno();
	}
	
	
	
	
	
	
	
	
	
}
