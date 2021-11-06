package org.ict.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	/* 세션 추가를 위해서는 컨트롤러 내부의 메서드마다 작성
	 * 세션 사용이 필요한 메서드마다 HttpServletRequest 타입의 변수를 선언하고
	 * 내부에 위에서 선언한 변수.getSession() 명령어로 세션을 받아와 사용
	 */
	@GetMapping("/session1")
	public String se1(//HttpServletRequest request) {
			HttpSession session) {
		/* 위와 같이 HttpServletRequest 객체를 파라미터에 선언하고
		 * HttpSession 객체를 얻어오면 세션기능 사용가능
		 */
		session.setAttribute("stest", "123");
		return "session1";
	}
	
	@GetMapping("/session2")
	public String se2(HttpServletRequest request) {
		/* 위와 같이 HttpServletRequest 객체를 파라미터에 선언하고
		 * HttpSession 객체를 얻어오면 세션기능 사용가능
		 */
		HttpSession session = request.getSession();
		System.out.println("session 작동확인: " + session.getAttribute("stest"));
		return "session2";
	}
	
	// Contoller에서는 주소지정만 함
	@GetMapping("/test")
	public void ajaxTest() {
		
	}
	
	
	
}
