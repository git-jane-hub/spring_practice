package org.ict.mapper;

import static org.junit.Assert.fail;

import org.ict.domain.BoardVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	/* 이 테스트코드 내에서는 Mapper 테스트를 담당하기 때문에
	 * BoardMapper 내부의 메서드를 실행하고 BoardMapper 타입의 변수가 필요
	 */
	@Autowired
	private BoardMapper mapper;
	
	//@Test
	public void testGetList() {
		log.info(mapper.getList());
	}
	
	//@Test
	public void testInsertList() {
		// 글입력을 위해 BoardVO 타입을 매개로 사용 - BoardVO를 만들고 setter로 글제목, 글본문, 글쓴이 저장
		BoardVO vo = new BoardVO();
		
		vo.setTitle("test1");
		vo.setContent("test1");
		vo.setWriter("test1");
		
		//log.info(vo);
		mapper.insert(vo);
	}

	@Test
	public void testGetContent() {
		mapper.getContent(1L);
	}
}
