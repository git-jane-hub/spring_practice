package org.ict.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import ict.org.service.SampleService;
import lombok.extern.log4j.Log4j;
// SampleServie 인터페이스의 메서드를 LogAdvice에서 작성해도 테스트가 돌아감
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class SampleServiceTests {
	@Autowired
	private SampleService service;
	
	//@Test
	public void testClass() {
		log.info(service);
		log.info(service.getClass().getName());
	}
	
	@Test
	public void testAdd() throws Exception{
		log.info(service.doAdd("123", "456"));
		service.introduce();
		// 에러가 발생하는 상황 test
		// log.info(service.doAdd("123", "ABC"));
	}
	
}
