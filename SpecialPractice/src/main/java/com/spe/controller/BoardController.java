package com.spe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spe.domain.BoardVO;
import com.spe.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	@Autowired
	private BoardService service;
	
	@GetMapping("/register")
	public void registerForm() {
	}
	
	@PostMapping("/register")
	public String register(BoardVO vo, RedirectAttributes rttr) {
		service.register(vo);
		rttr.addFlashAttribute("bno", vo.getBno());
		return "redirect:/board/list";
	}
	
	@GetMapping("/list")
	public void list(Model model) {
		List<BoardVO> board = service.list();
		model.addAttribute("board", board);
	}
	
	@GetMapping("/detail")
	public String detail(Long bno, Model model) {
		BoardVO vo = service.detail(bno);
		model.addAttribute("vo", vo);
		return "/board/detail";
	}
	
	@PostMapping("/modifyform")
	public String modifyForm(Long bno, Model model) {
		BoardVO vo = service.detail(bno);
		model.addAttribute("vo", vo);		
		return "/board/modify";
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO vo, RedirectAttributes rttr) {
		log.info("modifyform에서 받아온 vo" + vo);
		service.modify(vo);
		rttr.addFlashAttribute("bno", vo.getBno());
		return "redirect:/board/detail?bno=" + vo.getBno();
	}
}
