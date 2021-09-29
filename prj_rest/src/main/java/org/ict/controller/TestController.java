package org.ict.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

// Rest 방식으로 작동한다는 Controller 어노테이션
@RestController
@RequestMapping("/test")
public class TestController {
	
	@RequestMapping("/hello")
	public String sayHello() {
		// jsp 파일로 연결시키지 않고 해당 주소로 들어갔을 때, 리턴구문의 문자열을 화면에 출력해줌
		return "Hello Hello";
	}
}
