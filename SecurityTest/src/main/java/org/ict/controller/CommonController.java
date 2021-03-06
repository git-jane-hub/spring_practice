package org.ict.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CommonController {
	// 접근 제한
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("접근 거부:" + auth);
		model.addAttribute("errorMessage", "접근 거부");
	}
	
	// 로그인폼
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("error 여부:" + error);
		log.info("logout 여부: " + logout);
		
		if(error != null) {
			model.addAttribute("error", "로그인 관련 에러로, 다시한번 계정을 확인해주세요.");
		}
		if(logout != null) {
			model.addAttribute("logout", "로그아웃 되었습니다.");
		}
	}
	
	// 로그아웃폼
	@GetMapping("/customLogout")
	public void logoutGet() {
		log.info("로그아웃 폼으로 이동");
	}
	// 로그아웃 처리
	 @PostMapping("/customLogout")
	 public void logoutPost() {
		 log.info("로그아웃 요청 처리(post)");
	 }
}
