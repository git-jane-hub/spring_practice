package org.ict.dao;

import static org.junit.Assert.fail;

import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

// 의존성 주입으로 생성한 Connection Pool 관련 변수를 가져오기 위해 root-context.xml 위치를 지정 
@RunWith(SpringJUnit4ClassRunner.class)
// Beans Graph 내부에 설정되어있는 dataSource 를 쓰기 위해 위치 설정  
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class OracleConnectionPoolTest {
	
	// 자동 주입
	@Autowired
	private DataSource dataSource;
	
	// 메서드 내부에서 DB 접속에 필요한 최소한의 변수만 생성하고 연결 여부만 확인하기 때문에 서버를 켜고 끌 필요가 없음 
	@Test
	public void testConnection() {
		try(Connection con = dataSource.getConnection()){
			log.info(con);
			log.info("HikariCP connected");
		}catch(Exception e) {
			fail(e.getMessage());
		}
		
	}
}
