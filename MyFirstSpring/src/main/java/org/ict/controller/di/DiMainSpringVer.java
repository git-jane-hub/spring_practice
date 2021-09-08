package org.ict.controller.di;

import org.ict.controller.di.classfile.Broadcast;
import org.ict.controller.di.classfile.Satellite;
import org.springframework.context.support.GenericXmlApplicationContext;
// 계층이 많아질수록 개발 속도가 빨라짐 
public class DiMainSpringVer {

	public static void main(String[] args) {
		/* bean container에 호출해 완성된 객체를 받아와 실행하는 코드 작성
		 * 호출시 사용하는 객체는 GenericXmlApplicationContext
		 */
		GenericXmlApplicationContext context = new GenericXmlApplicationContext("file:src/main/webapp/WEB-INF/spring/root-context.xml");	// root-*.xml 로 작성 가능 
		
		/* 위 root-context.xml 이라는 bean-container을 지정했으니,
		 * 해당 객체를 마음대로 사용 가능
		 * 얻어오는 방법은 위에 생성한 context 객체를 이용해 context.getBean("bean이름(id)", 자료형.class);
		 */
//		Broadcast broadcast = context.getBean("broadcast", Broadcast.class);
//		broadcast.broadcast();
		Satellite satellite = context.getBean("satellite", Satellite.class);
		satellite.satellite();
		
		// 호출하고 context 닫기
		context.close();
	}

}

