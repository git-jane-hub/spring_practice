package org.ict.controller.di.classfile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Stage {
	// Singer 위에 @Autowired 를 작성하면 컨테이너 내부에 일치하는 자료형이 존재할 경우 자동으로 의존관계를 만듦 
	@Autowired
	private Singer singer;
	
	// 객체 생성 시 반드시 Singer 타입을 파라미터로 전달해야함 
	public Stage(Singer singer) {
		this.singer = singer;
	}
	
	public void perform() {
		System.out.print("무대에서 ");
		// 실제 공연을 하려면 가수가 있도록 설정 
		singer.sing();
	}
	
}
