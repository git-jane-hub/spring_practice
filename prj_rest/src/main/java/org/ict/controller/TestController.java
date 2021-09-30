package org.ict.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.ict.domain.TestVO;
import org.springframework.http.HttpStatus;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

// Rest 방식(MVC 방식이 아닌)으로 작동한다는 Controller 어노테이션
@RestController
@RequestMapping("/test")
public class TestController {
	
	@RequestMapping("/hello")
	public String sayHello() {
		// jsp 파일로 연결시키지 않고 해당 주소로 들어갔을 때, 리턴구문의 문자열을 화면에 출력해줌
		return "Hello Hello";
	}
	
	@RequestMapping("/sendVO")
	public TestVO sendTestVO() {
		TestVO testVO = new TestVO();
		
		testVO.setMno(1);
		testVO.setName("jane");
		testVO.setAge(28);
		return testVO;
	}
	
	@RequestMapping("/sendVOList")
	public List<TestVO> sendVOList(){
		List<TestVO> list = new ArrayList<>();
		for(int i = 0; i < 10; i++) {
			TestVO vo = new TestVO();
			vo.setMno(i);
			vo.setName(i + "jane");
			vo.setAge(10 + i);
			list.add(vo);
		}
		return list;	// 대괄호 내부에 중괄호의 json 집합의 객체 [{--:--}, {--:--}]
	}
	
	@RequestMapping("/sendMap")
	public Map<Integer, TestVO> sendMap(){
		Map<Integer, TestVO> map = new HashMap<>();
		for(int i = 0; i < 10; i++) {
			TestVO vo = new TestVO();
			vo.setMno(i);
			vo.setName("jane");
			vo.setAge(50 + i);
			map.put(i, vo);
		}
		/* map의 key값은 중복된 값이 들어올 수 없으며, 중복된 값이 들어오게된다면 값이 변경됨
		 * {"key":{"value":value값, ...}, ""key":{"value":value값}, ...}
		 */
		// 기존에 있던 key값을 중복해서 삽입
		TestVO vo = new TestVO();
		vo.setMno(50);
		vo.setName("abc");
		vo.setAge(50000);
		map.put(0, vo);
		System.out.println("map출력: "+map);
		return map;
	}
	
	// 접속하면 강제로 400에러를 발생시키는 로직
	@RequestMapping("/sendErrorAuth")
	// Void: 접속에 성공하면 보낼 데이터 없음 
	public ResponseEntity<Void> sendListAuth(){
		/*
		ResponseEntity<Void> code = new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
		return code;
		*/
		/* HttpStatus 객체를 ResponseEntity 객체의 생성자로 삽입
		 * ResponseEntity는 생성자에 HttpStatus.코드번호를 작성해
		 * 해당 주소 접속시 어떤 접속 코드를 사용자에게 전달할지 결정할 수 있음(if / try ~ catch ~)
		 */
		
		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}
	
	// 데이터를 전달하면서 동시에 에러를 발생시키는 코드를 함께 전달하는 로직 - 전송하는 데이터는 어떤 상황으로 발생된 에러인지 알려주는 역할
	@RequestMapping("/sendErrorNot")
	public ResponseEntity<List<TestVO>> sendListNot(){
		List<TestVO> list = new ArrayList<>();
		for(int i = 0; i < 10; i++) {
			TestVO vo = new TestVO();
			vo.setMno(i);
			vo.setName(i + "jane");
			vo.setAge(20 + i);
			list.add(vo);
		}
		/* ResponseEntity 생성자에 파라미터 2개를 넘기면 
		 * 전송할 데이터와 전송시 결과로 나올 에러코드(임의로 발생시킨 코드)를 함께 전달할 수 있음
		 */
		return new ResponseEntity<List<TestVO>>(list, HttpStatus.NOT_FOUND);
	}
}
