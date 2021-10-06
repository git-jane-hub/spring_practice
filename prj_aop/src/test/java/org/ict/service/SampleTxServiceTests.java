package org.ict.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import ict.org.service.SampleTxService;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class SampleTxServiceTests {
	@Autowired
	private SampleTxService service;
	
	@Test
	/* tbl1에는 add됨 - VARCHAR2(50)
	 * tbl2에는 add안됨 - VARCHAR2(5)
	 * -> table 삭제하고 @Transactional 작성하고 다시 테스트 실행
	 * 두 테이블 모두 add안됨
	 */
	public void testInsert() {
		String str = "abcdefghijklmnopqrstuvwxyz";
		service.addData(str);
	}
}
