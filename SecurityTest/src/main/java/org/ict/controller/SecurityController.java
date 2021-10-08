package org.ict.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
// views 폴더까지는 고정, 이후부터 작성
@RequestMapping("/secu/*")
@Controller
public class SecurityController {
	
	@GetMapping("/all")
	public void doAll() {
		log.info("모든사람이 접속할 수 있는 로직 - all");
	}
	
	@GetMapping("/member")
	public void doMember() {
		log.info("회원들만 접속할 수 있는 로직 - member");
	}
	
	@GetMapping("/admin")
	public void doAdmin() {
		log.info("운영자만 접속할 수 있는 로직 - admin");
	}
	
}
