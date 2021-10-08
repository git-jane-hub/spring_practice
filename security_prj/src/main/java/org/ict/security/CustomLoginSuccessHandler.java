package org.ict.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import jdk.internal.org.jline.utils.Log;
import lombok.extern.log4j.Log4j;

// login 성공
@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		/* 로그인 성공 시 어떤 권한인지 체크하기 위해 부여받은 권한(들)을 불러오기
		 * ROLE_ADMIN의 경우에는, ROLE_MEMBER가 함께 부여되기 때문에 경우에 따라 권한이 여럿일 수 있음
		 */
		log.warn("로그인 성공");
		// 권한이 여러개일 수 있기 때문에 List를 생성
		List<String> roleList = new ArrayList<>();
		
		// 부여받은 권한 전체를 얻어와서 확인
		for(GrantedAuthority role : authentication.getAuthorities()) {
			roleList.add(role.getAuthority());
		}
		
		// roleList에 포함된 권한을 통해 로그인 계정의 권한에 따라 처리
		log.warn("부여받은 권한(들): " + roleList);
		
		// 부여받은 권한 중 ROLE_ADMIN 권한이 포함되어있는지 확인
		if(roleList.contains("ROLE_ADMIN")) {
			response.sendRedirect("/secu/admin");
			// return을 작성해서 리다이렉트가 중복호출되지 않도록함
			return;
		}
		
		// 부여받은 권한 중 ROLE_MEMBER 권한이 포함되어있는지 확인
		if(roleList.contains("ROLE_MEMBER")) {
			response.sendRedirect("/secu/member");
			return;
		}
		response.sendRedirect("/");
	}

}
