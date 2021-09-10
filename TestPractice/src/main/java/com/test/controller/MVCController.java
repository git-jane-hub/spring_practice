package com.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	// 여기 다시 
	@RequestMapping(value="/goPageD", method=RequestMethod.POST)
	public String goD(int d, Model model) {
		model.addAttribute("d", d);
		return "D";
	}
	
	@RequestMapping(value="/goPageD", method=RequestMethod.GET)
	public String goDForm() {
		return "DForm";
	}
}
