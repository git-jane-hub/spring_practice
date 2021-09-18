package org.ict.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
// controller를 호출하려면 두 xml 파일 포함
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
					  "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
@WebAppConfiguration	// 웹사이트 모의접속용 어노테이션
public class BoardControllerTests {
	// 아래 나오는 MockMvc를 만들기 위해 생성하는 객체
	@Autowired
	private WebApplicationContext ctx;
	
	// 브라우저 없이 모의로 접속하는 기능을 가진 객체
	private MockMvc mockMvc;
	
	// @Test이전에 실행할 내용을 기술하는 어노테이션(org.JUnit.Before)
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	//@Test
	public void testList() throws Exception {
		log.info(
			/* .get(접속주소) 혹은 .post(접속주소)를 제외한 나머지는 고정된 양식을 가진 코드
			 * .get(접속주소)를 입력하면 get방식으로 해당 주소에 접속
			 * /board/list에 접속하면 글 목록을 가져오는 페이지기때문에 글 전체 목록을 가져오는지 여부 테스트
			 */
			mockMvc.perform(
					MockMvcRequestBuilders.get("/board/list")
			)
			.andReturn()
			.getModelAndView()
			.getModelMap()			
		);
	}
	
	// /board/register 주소로 파라미터 값을 post로 넘겼을떼 작성된 글이 insert되는지 test
	//@Test
	public void testRegister() throws Exception{
		// post 방식으로 파라미터 3개를 주소에 전달해주는 코드 - 결과 메세지는 문자열 resultPage에 저장하고 
		String resultPage = mockMvc.perform(
					MockMvcRequestBuilders.post("/board/register")
					// .param() 으로 전달하는 자료는 자료형을 막론하고 " "로 감싸 문자화 시켜야함 - url에는 자료형 구분이 String만 있음
					.param("title", "testcodetitle")
					.param("content", "testcodecontent")
					.param("writer", "testcodewriter"))
				.andReturn()
				.getModelAndView()
				.getViewName();
		// 변수에 저장된 값을 다시 로깅해 출력
		log.info(resultPage);
	}
	
	// .param("bno", "글번호_숫자")로 작성시 해당글을 불러오는 로직
	//@Test
	public void testGet() throws Exception{
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/get")	// PathVariable을 사용한다면 "/board/get/8" 로 작성 
				.param("bno", "3"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
	//@Test
	public void testRemove() throws Exception{
		log.info(mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
				.param("bno", "3"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
	@Test
	public void testModify() throws Exception{
		/* 실제로 실행된 쿼리문과 비교해 데이터를 전달
		 * 수정 쿼리문에서 WHERE 조건절의 bno와
		 * title, content, writer 4개의 변수가 필요하므로
		 * .param()의 데이터도 4개를 전달
		 */
		log.info(mockMvc.perform(MockMvcRequestBuilders.post("/board/modify")
				.param("bno", "7")
				.param("title", "testmodify")
				.param("content", "testmodify")
				.param("writer", "testmodify"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
	
	
	
	
	
	
}
