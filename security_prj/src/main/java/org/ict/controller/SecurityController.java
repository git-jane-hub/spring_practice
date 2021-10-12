package org.ict.controller;

import org.ict.domain.AuthVO;
import org.ict.domain.MemberVO;
import org.ict.security.JoinService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

// url 세팅 -> 각 주소에 맞는 jsp 파일 생성
@Log4j
@RequestMapping("/secu/*")
@Controller
public class SecurityController {
	
	@Autowired
	private JoinService service;

	// 회원가입 폼으로 이동
	@GetMapping("/join")
	@PreAuthorize("permitAll")
	public void joinGet() {
		log.info("회원가입 폼으로 이동");
	}
	
	// 회원가입 처리
	@PostMapping("/join")
	public void joinPost(MemberVO mvo, AuthVO avo) {
		service.addUser(mvo, avo);
		log.info("post 방식으로 회원가입 요청 처리");
	}
	
	// 비회원
	@GetMapping("/all")
	public void doAll() {
		log.info("모든 사람이 접속 가능한 all 로직");
	}
	
	// 회원
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@GetMapping("/member")
	public void doMember() {
		log.info("회원들이 접속 가능한 member 로직");
	}
	
	// 운영자
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/admin")
	public void doAdmin() {
		log.info("운영자만 접속 가능한 admin 로직");
	}
}
