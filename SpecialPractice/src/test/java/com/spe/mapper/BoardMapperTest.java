package com.spe.mapper;

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
public class BoardMapperTest {
	
	@Autowired
	private BoardMapper mapper;
	
	//@Test
	public void testInsert() {
		BoardVO vo = new BoardVO();

		vo.setTitle("testInsert");
		vo.setContent("testInsert");
		vo.setWriter("testInsert");
		
		mapper.insert(vo);
	}
	
	@Test
	public void testInsertSelectKey() {
		BoardVO vo = new BoardVO();
		vo.setTitle("testSelectKey");
		vo.setContent("testSelectKey");
		vo.setWriter("testSelectKey");
		mapper.insertSelectKey(vo);
	}
	
	//@Test
	public void testSelectList() {
		mapper.selectList();
	}
	
	//@Test
	public void testSelectDetail() {
		mapper.selectDetail(1L);
	}
	
	//@Test
	public void testUpdate() {
		BoardVO vo = new BoardVO();
		vo.setBno(2L);
		vo.setTitle("testUpdate");
		vo.setContent("testUpdate");
		vo.setWriter("testUpdate");
		mapper.update(vo);
	}
	
	//@Test
	public void testDelete() {
		mapper.delete(26L);
	}
}
