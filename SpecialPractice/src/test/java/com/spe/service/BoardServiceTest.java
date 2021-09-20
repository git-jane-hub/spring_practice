package com.spe.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spe.domain.BoardVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTest {
	
	@Autowired
	private BoardService service;
	
	//@Test
	public void testRegister() {
		BoardVO vo = new BoardVO();
		vo.setTitle("testRegister");
		vo.setContent("testRegister");
		vo.setWriter("testRegister");
		service.register(vo);
	}
	
	//@Test
	public void testList() {
		service.list();
	}
	
	//@Test
	public void testDetail() {
		service.detail(41L);
	}
	
	//@Test
	public void testModify() {
		BoardVO vo = new BoardVO();
		vo.setBno(25L);
		vo.setTitle("testModify");
		vo.setContent("testModify");
		vo.setWriter("testModify");
		service.modify(vo);
	}
	
	@Test
	public void testRemove() {
		service.remove(25L);
	}
}