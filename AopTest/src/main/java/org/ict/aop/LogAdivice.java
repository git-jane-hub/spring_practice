package org.ict.aop;

import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j		// 로그를 Service 구현체에 기록하지 않고 여기서 보조기능으로 사용
@Component
public class LogAdivice {
	
	// 주요 메서드 실행 전에 먼저 실행하는 AOP
	/*"execution()" 내부
	 * * - 접근제한자 상관없음
	 * org.ict.service.SampleService* - 어떤 패키지의 어떤 클래스까지(*은 SampleService로 시작하는 클래스명은 모두)
	 * .* - 메서드명
	 * (..) - 파라미터
	 */
	@Before("execution(* org.ict.service.SampleService*.*(..))")
	public void logBefore() {
		log.info("==============");
	}
	
	// 파라미터 로그 추적
	@Before("execution(* org.ict.service.SampleService*.doAdd(String, String)) && args(str1, str2)")
	public void logBeforWithParam(String str1, String str2) {
		log.info("str1: " + str1);
		log.info("str2: " + str2);
	}
	
	// 예외 발생시에만 작동하는 @AfterThrowing
	@AfterThrowing(pointcut = "execution(* org.ict.service.SampleService*.doAdd(..))", throwing="exception")
	public void logException(Exception exception) {
		log.info("Exception....!!!!!");
		log.info("exception: " + exception);
	}
}
