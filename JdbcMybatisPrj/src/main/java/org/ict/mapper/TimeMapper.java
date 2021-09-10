package org.ict.mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {
	
	@Select("SELECT SYSDATE FROM DUAL")
	public String getTime();
	
	/* 기본적으로 복잡한 쿼리문을 작성하려면 xml파일과 인터페이스 연동
	 * 먼저, 인터페이스에는 아래와 같이 메서드를 선언만 하고 같은 패키지 내부에 xml파일을 생성해
	 * 실제로 getTime2가 호출될 때 실행할 실행문 작성 
	 */
	public String getTime2();
	
	public String getTime3();
}