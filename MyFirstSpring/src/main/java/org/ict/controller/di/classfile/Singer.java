package org.ict.controller.di.classfile;

import org.springframework.stereotype.Component;

// component scan 방식 
// annotation @Component, @Controller, @Repository, @Service 중 하나를 클래스명 위에 작성하면 root-context(bean container 가 감지함 
@Component
public class Singer {
	public void sing() {
		System.out.println("가수가 노래를 합니다.");
	}
}
