package org.ict.security;

import org.ict.domain.CustomUser;
import org.ict.domain.MemberVO;
import org.ict.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService{
	
	// MemberMapper의 데이터를 스프링 시큐리티에서 처리할 수 있도록 커스터마이징
	@Autowired
	private MemberMapper mapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.warn("user 이름 확인: " + username);
		
		MemberVO vo = mapper.read(username);
		
		log.info("확인된 유저이름으로 얻어온 정보: " + vo);
		
		/* UserDetails로 반환해야하는 자료를 CustomUser로 반환할 수 있는 이유는
		 * UserDetails를 상속 -> User, User를 상속 -> CustomUser 이기 때문
		 */
		return vo == null ? null : new CustomUser(vo);
	}
	
	
}
