package org.ict.dao;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class OjdbcConnectionTest {
	static {
		try {
			Class.forName("oracle.jdbc.OracleDriver");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		try(Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:51521/XEPDB1", "mytest", "mytest")){
			log.info(con);
			log.info("정상적으로 연결됨");
		}catch(Exception e) {
			fail(e.getMessage());			
		}
	}
}
