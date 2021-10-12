package org.ict.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;
/* UserDetails를 상속받은 User를 상속
 * 인증정보를 전달하기 위해서 Getter 어노테이션을 작성 
 */
@Getter	
public class CustomUser extends User{
	
	private static final long serialVersionUID = 1L;
	
	// MemberVO 자리에 다른 테이블구조에 맞춘 VO를 넣어주면 적용 가능(프로젝트 할 때)
	private MemberVO member;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> auth) {
		super(username, password, auth);
	}
	
	public CustomUser(MemberVO vo) {
		super(vo.getUserid(), vo.getUserpw(), 
			  vo.getAuthList().stream().map(author -> 
			  new SimpleGrantedAuthority(author.getAuth()))
			  .collect(Collectors.toList()));
		
		// 변수 member를 vo에 대입
		this.member = vo;
	}
}
