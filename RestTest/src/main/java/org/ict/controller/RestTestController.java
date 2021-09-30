package org.ict.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.ict.domain.TestVO;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

// 기존의 컨트롤러가 뷰를 만들어내기 위함이였다면 rest 컨트롤러는 데이터를 처리하기 위함 
@RestController
@RequestMapping("/hello")
public class RestTestController {
	@RequestMapping("/sayHello")
	public String sayHello() {
		TestVO vo = new TestVO();
		vo.setName("jane");
		return "Hello, I'm " + vo.getName();
	}
	
	// 객체를 반환하려면 JSON이 있어야함: 객체는 JSON으로 반환됨(Jackson 라이브러리가 필요)
	@RequestMapping("/sendVO")
	public TestVO sendVO() {
		TestVO vo = new TestVO();
		vo.setName("jane");
		vo.setAge(28);
		vo.setMarriage(false);
		return vo;
	}
	
	@RequestMapping("/sendVOList")
	public List<TestVO> sendVOList(){
		List<TestVO> list = new ArrayList<TestVO>();
		for(int a = 0; a < 10; a++) {
			TestVO vo = new TestVO();
			vo.setName("jane");
			vo.setAge(a);
			if(a % 2 == 0) {
				vo.setMarriage(false);
			}else {
				vo.setMarriage(true);				
			}
			list.add(vo);
		}
		return list;
	}
	
	@RequestMapping("/sendMap")
	public Map<Integer, TestVO> sendMap(){
		Map<Integer, TestVO> map = new HashMap<Integer, TestVO>();
		for(int a = 0; a < 10; a++) {
			TestVO vo = new TestVO();
			vo.setName("jane");
			vo.setAge(28 + a);
			map.put(a, vo);
		}
		TestVO vo = new TestVO();
		vo.setName("choi");
		vo.setAge(100);
		vo.setMarriage(true);
		map.put(2, vo);
		return map;
	}
	
	// <Void>: 접속하면 에러코드만 전달
	@RequestMapping("/sendErrorAuth")
	public ResponseEntity<Void> sendErrorAuth(){
		return new ResponseEntity<Void>(HttpStatus.BAD_GATEWAY);
	}
	
	// <List<TestVO>: 접속하면 리스트와 에러코드 함께 전달
	@RequestMapping("/sendErrorNot")
	public ResponseEntity<List<TestVO>> sendErrorNot(){
		List<TestVO> list = new ArrayList<>();
		for(int a = 0; a < 10; a++) {
			TestVO vo = new TestVO();
			vo.setName(a + ": 무슨무슨 이유로 다음과 같은 에러가 발생했으니 수정해서 다시 접속하세요.");
			list.add(vo);
		}
		// 파라미터 내부에는 (전달할 데이터, 발생시킨 에러코드)
		return new ResponseEntity<List<TestVO>>(list, HttpStatus.NOT_FOUND);
	}
	
}
