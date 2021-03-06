package org.ict.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.log4j.Log4j;

// 로그인 및 권한을 사용자가 커스터마이징할 수 있도록 스프링 시큐리티 내부에 미리 구현되어있는 일종의 템플릿
@Log4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler{

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		log.error("커스텀된 접근 거부 핸들러 실행");
		log.error("/accessError 페이지로 redirect");
		// 로그인이 실패할 경우 해당 페이지로 리다이렉트
		response.sendRedirect("/accessError");
	}

}
