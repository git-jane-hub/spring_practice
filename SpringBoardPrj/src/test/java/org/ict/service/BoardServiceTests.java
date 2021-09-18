package org.ict.service;

import static org.junit.Assert.assertNotNull;

import org.ict.domain.BoardVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

// Service테스트는 BoardServiceImpl 내부 기능을 서버 가동없이 테스트하기위해 작성

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	
	// 다형성 원리에 의해 BoardService로만 작성해도 BoardServiceImpl이 주입됨
	@Autowired
	private BoardService service;//=null;
	
	// 서비스가 제대로 주입되었는지 확인 - 어떠한 로직을 개발하기전 테스트하기 위함(하나의 테스트 기법)
	//@Test
	public void testExist() {
		log.info(service);
		// assertNotNull은 해당 객체가 주입되지않아 null인 경우, 에러를 발생
		assertNotNull(service);
	}
	
	//@Test
	public void testRegister() {
		BoardVO vo = new BoardVO();
		vo.setTitle("serviceRegister");
		vo.setContent("serviceRegister");
		vo.setWriter("serviceRegister");
		service.register(vo);
	}
	
	//@Test
	public void testGetList() {
		/*
		작성하지 않아도됨
		BoardVO vo = new BoardVO();
		vo.getBno();
		vo.getTitle();
		vo.getContent();
		vo.getWriter();
		vo.getRegdate();
		vo.getUpdatedate();
		*/
		service.getList("qwe");
	}
	
	//@Test
	public void testGetContent() {
		service.get(2L);
	}
	
	@Test
	public void testDelete() {
		service.remove(21L);
	}
	
	//@Test
	public void testUpdate() {
		// 수정사항 정보를 BoardVO에 담아 전달하기 때문에 BoardVO를 생성하고 자료를 저장 후 실행
		BoardVO vo = new BoardVO();
		vo.setBno(7L);
		vo.setTitle("testupdate");
		vo.setContent("testupdate");
		vo.setWriter("testupdate");
		service.modify(vo);
	}
}
