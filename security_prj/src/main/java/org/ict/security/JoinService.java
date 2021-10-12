package org.ict.security;

import org.ict.domain.AuthVO;
import org.ict.domain.MemberVO;
import org.ict.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;

public class JoinService{
	
	@Autowired
	private PasswordEncoder pwen;
	
	@Autowired
	private MemberMapper mapper;
	
	public void addUser(MemberVO mvo, AuthVO avo) {
		mvo.setUserpw(pwen.encode(mvo.getUserpw()));
		mapper.addMember(mvo);
		mapper.addAuth(avo);
	}
}
