package com.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.test.domain.TestVO;

@Controller
public class MVCController {
	@RequestMapping(value="/goPageA")
	public String goA() {
		return "A";
	}
	
	@RequestMapping(value="/goPageB")
	public String goB(int b, Model model) {
		model.addAttribute("b", b);
		return "B";
	}
	
	@RequestMapping(value="/goPageC")
	public String goC(@RequestParam("c")int cNum, Model model) {
		model.addAttribute("cNum", cNum);
		return "C";
	}
	
	// 기본주소를 '/test' 설정했기 때문에 form 속성인 action에 '/test'까지 작성 
	@RequestMapping(value="/goPageD", method=RequestMethod.POST)
	public String goD(int d, Model model) {
		System.out.println("d페이지 접근");
		model.addAttribute("d", d);
		return "D";
	}
	
	@RequestMapping(value="/goPageD", method=RequestMethod.GET)
	public String goDForm() {
		return "DForm";
	}
	
	// @PathVariable 작성
	@RequestMapping(value="/goPageE/{page}")
	public String goE(@PathVariable int page, Model model) {
		model.addAttribute("page", page);
		return "E";
	}
	
	// 결과 페이지 이름 작성하기가 까다로움 
	@RequestMapping(value="/goPageF")
	public void goF(int f, Model model) {
		model.addAttribute("f", f);
	}
	
	@RequestMapping(value="/goPageG")
	public String goG(TestVO vo, Model model) {
		model.addAttribute("vo", vo);
		return "G";
	}

}
