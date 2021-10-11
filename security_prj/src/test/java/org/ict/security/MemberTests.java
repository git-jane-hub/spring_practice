package org.ict.security;


import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@Log4j
public class MemberTests {
	// 복호화
	@Autowired
	private PasswordEncoder pwen;
	// DB에 접근
	@Autowired
	private DataSource ds;

	//@Test
	public void testCryptDefaultDB() {
		// 현재 DB에 있는 데이터의 암호3개가 전부 동일하니 배열로 한번에 처리
		String[] idList = {"user00", "member00", "admin00"};
		String sql = "UPDATE users SET password = ? WHERE username = ?";
		try {
			Connection con = ds.getConnection();
			
			for(String id : idList) {
				PreparedStatement pstmt = con.prepareStatement(sql);
				// pwen.encode("문자열")로 자동 복호화 - 같은 암호라도 다른 문자열로 교체되어 저장됨
				pstmt.setString(1, pwen.encode("pw00"));
				pstmt.setString(2, id);
				pstmt.executeUpdate();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//@Test
	public void testCrypCustomDB() {
		try {
			Connection con = ds.getConnection();
			String sql = "INSERT INTO member_tbl (userid, userpw, username) VALUES (?, ?, ?)";
			
			for(int i = 0; i < 30; i++) {
				PreparedStatement pstmt = con.prepareStatement(sql);
				
				// userpw에 복호화한 비밀번호 입력
				pstmt.setString(2, pwen.encode("pw" + i));
				/* 0부터 9까지는 준회원
				 * 10부터 19까지는 정회원
				 * 20부터 29까지는 운영자 
				 * 비밀번호는 pw+각 숫자
				 */
				if(i < 10) {
					pstmt.setString(1, "user" + i);
					pstmt.setString(3, "준회원" + i);
				}else if(i < 20) {
					pstmt.setString(1, "user" + i);
					pstmt.setString(3, "정회원" + i);
				}else if(i < 30) {
					pstmt.setString(1, "user" + i);
					pstmt.setString(3, "운영자" + i);
				}
				pstmt.execute();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	@Test
	public void testInsertAuth() {
		try {
			Connection con = ds.getConnection();
			String sql = "INSERT INTO member_auth (userid, auth) VALUES (?, ?)";
			
			for(int i = 0; i < 30; i++) {
				PreparedStatement pstmt = con.prepareStatement(sql);
				
				if(i < 10) {
					pstmt.setString(1, "user" + i);
					pstmt.setString(2, "ROLE_USER");	// 준회원
				}else if(i < 20) {
					pstmt.setString(1, "user" + i);
					pstmt.setString(2, "ROLE_MEMBER");	// 정회원
				}else if(i < 30) {
					pstmt.setString(1, "user" + i);
					pstmt.setString(2, "ROLE_ADMIN");	// 운영자
				}
				pstmt.execute();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
}
