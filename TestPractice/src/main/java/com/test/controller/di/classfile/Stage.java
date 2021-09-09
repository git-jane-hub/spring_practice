package com.test.controller.di.classfile;

public class Stage {
	private Singer singer;
	
	public Stage(Singer singer) {
		this.singer = singer;
	}
	
	public void stage() {
		System.out.print("무대에서 ");		
		singer.sing();
	}
}
