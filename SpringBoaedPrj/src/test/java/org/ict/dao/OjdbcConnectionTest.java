package org.ict.dao;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

/* @Log4j는 로깅 기능을 사용할 수 있게 도와줌
 * System.out.println(); 같은 경우는 로깅하는 것만을 목적으로 사용되는 기능이 아니기 때문에 메모리 누수가 발생 - 권장되지 않음 
 * 따라서 로그(log.info() 사용) 할때는 Log4j를 사용 
 * Spring-boot 에서는 Log4j2 사용 
 */
@Log4j
public class OjdbcConnectionTest {
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 해당 클래스파일을 실행하면, @Test가 붙은 메서드만 실행됨 
	@Test
	public void testConnection() {
		try(Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:51521/XEPDB1", "mytest", "mytest")){
			log.info(con);
			log.info("정상적으로 연결됨");
		}catch(Exception e) {
			// 접속이 정상적이지 않을 때 출력할 내용을 아래에 작성 
			// fail 함수를 이용해 우측 Failure Trace에 메세지를 출력 
			fail(e.getMessage());
		}
	}
	
	@Test
	public void testConnection2() {
		log.info("이 코드는 실행되지 않음");
	}
}
