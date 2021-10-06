package ict.org.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import lombok.extern.log4j.Log4j;

@Aspect		// pom.xml - runtime 태그 주석처리
@Log4j
@Component
public class LogAdvice {
	// 1번 advice
	// @Before: Log4j어노테이션이 작성된 클래스 내부에서 다른 메서드보다 먼저 실행됨
	// execution: 범위 지정
	// service 패키지 내부의 SampleService로 시작하는 모든 클래스와 모든 메서드
	@Before("execution(* ict.org.service.SampleService*.*(..))")
	public void logBefore() {
		log.info("메서드 시작");
		log.info("==============");
	}
	
	// 2번 advice
	// args: arguments
	@Before("execution(* ict.org.service.SampleService*.doAdd(String, String)) && args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		log.info("str1: " + str1);
		log.info("str2: " + str2);
	}
	
	// 3번 advice
	// throwing: 어떤 종류의 예외상황을 처리할지 작성
	@AfterThrowing(pointcut = "execution(* ict.org.service.SampleService*.*(..))", throwing="exception")
	public void logException(Exception exception) {
		log.info("Exception...!!!!");
		log.info("Exception: " + exception);
	}
	
	// 4번 advice - 메서드 성능측정
	// execution 내부 오타나면 화살표가 나타나지 않음
	@Around("execution(* ict.org.service.SampleService*.*(..))")
	public Object logTime(ProceedingJoinPoint pjp) {
		// 시작시간
		long start = System.currentTimeMillis();
		
		// 어떤 메서드인지
		log.info("Target: " + pjp.getTarget());
		// 어떤 파라미터를 받았는지
		log.info("Param: " + Arrays.toString(pjp.getArgs()));
		
		Object result = null;
		try {
			// 원래 실행하려던 메서드 실행
			result = pjp.proceed();
		}catch(Throwable e) {
			e.printStackTrace();
		}
		
		// 끝시간
		long end = System.currentTimeMillis();
		
		// 소요시간 = 끝시간 - 시작시간
		log.info("TIME: " + (end - start));
		return result;
	}
	
	@After("execution(* ict.org.service.SampleService*.*(..))")
	public void logAfter() {
		log.info("==============");
		log.info("메서드 종료");
	}
}






