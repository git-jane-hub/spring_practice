package org.ict.mapper;

import org.ict.domain.AuthVO;
import org.ict.domain.MemberVO;

public interface MemberMapper {
	// 로그인 로직 확인
	public MemberVO read(String userid);
	
	// 회원가입 로직 삽입
	public void addMember(MemberVO vo);
	public void addAuth(AuthVO vo); 
}
