package org.ict.controller.di.classfile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Broadcast {
	private Stage stage;
	
	// @Autowired 를 생성자에 적용
	 @Autowired
	public Broadcast(Stage stage) {
		this.stage = stage;
	}
	
	public void broadcast() {
		System.out.print("방송 송출용 ");
		stage.perform();
	}
}
