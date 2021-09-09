package com.test.controller.di.classfile;

public class Broadcast {
	private Stage stage;
	
	public Broadcast(Stage stage) {
		this.stage = stage;
	}
	
	public void broadcast() {
		System.out.print("방송에 송출될 ");		
		stage.stage();
	}
}
