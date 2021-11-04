package org.ict.controller;


import java.util.List;

import org.ict.domain.ReplyVO;
import org.ict.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/replies")
@CrossOrigin(origins = "*")
public class ReplyController {
	
	@Autowired
	private ReplyService service;
	
	/* consumes: 해당 메서드의 파라미터를 넘겨줄 때 어떠한 형식으로 넘겨줄지 설정 - 기본적으로 rest방식에서는 json을 사용
	 * produces: 입력받은 데이터를 토대로 로직을 실행하고 사용자에게 결과로 보여줄 데이터의 형식을 나타냄
	 */
	@PostMapping(value="", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	// produces에 TEXT_PLAIN_VALUE를 주었기 때문에 결과 코드와 문자열을 넘김
	public ResponseEntity<String> register(
			// @RequestBody는 RestController에서 받는 파라미터 앞에 해당 어노테이션을 작성해야 consumes와 연결됨
			@RequestBody ReplyVO vo){
		// 빈 entity를 먼저 생성
		ResponseEntity<String> entity = null;
		try {
			// 먼저 글쓰기 로직을 실행하고 에러가 없으면 
			service.addReply(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			// 글쓰기 로직을 실행하고 에러가 있으면
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		// 위 try ~ catch 에서 얻은 entity 변수를 반환
		return entity;
	}
	
	// select 구문으로 조회할 때에도 해당 데이터를 json타입으로 전달되어야한다면 consumes를 작성해야됨
	// list타입으로 반환할 때는 xml 혹은 json 형식으로 전달하기 때문에 두가지 모두 작성
	// @PathVariable: mapping에서 {bno}안에 들어온 값을 ?bno= 과 같게 간주
	@GetMapping(value="/all/{bno}", produces = {MediaType.APPLICATION_ATOM_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ReplyVO>> list(@PathVariable("bno") Long bno){
		ResponseEntity<List<ReplyVO>> entity = null;
		try {
			entity = new ResponseEntity<List<ReplyVO>>(service.listReply(bno), HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<ReplyVO>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// @PutMapping / @PathMapping을 작성하지 않고 RequestMethod에 두가지를 같이 작성해 두가지를 함께 처리하도록 함
	@RequestMapping(value="/{rno}", method= {RequestMethod.PATCH, RequestMethod.PUT},
			consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(
			/* vo는 payload에 작성된 데이터로 받아옴
			 * (@RequestBody에 작성된 vo는 payload에 적힌 데이터를 vo로 환산한 데이터로 가져옴)
			 */
			@RequestBody ReplyVO vo, 
			// vo중 댓글 번호는 주소에 기입된 데이터를 통해 받아옴
			@PathVariable("rno")Long rno){
		ResponseEntity<String> entity = null;
		try {
			/* Yarc -payload에는 reply에 대한 정보만 작성, rno는 요청주소를 통해 전달받음
			 * 하지만 rno를 파라미터로 받아오는 값은 컨트롤러 메서드 내부에서 setter를 통해 지정해줘야 함
			 */
			vo.setRno(rno);
			service.modifyReply(vo);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		}catch(Exception e) {
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// rest 방식에서는 delete 방식으로 삭제로직을 요청
	@DeleteMapping(value="/{rno}", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno){
		ResponseEntity<String> entity = null;
		try {
			service.removeReply(rno);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
