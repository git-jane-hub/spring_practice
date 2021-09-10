package org.ict.dao;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class MySQLConnectionTest {
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		try(Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/mysql?useSSL=false&serverTimezone=UTC", "root", "choi94w08o26")){
			log.info(con);
			log.info("MySQL 연결 완료");
		}catch(Exception e) {
			fail(e.getMessage());
		}
		
	}
	
	public void testConnection2() {
		log.info("@Test가 없이 실행은 불가");
	}
}
