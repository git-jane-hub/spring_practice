package com.test.controller.di;

import com.test.controller.di.classfile.Broadcast;
import com.test.controller.di.classfile.Singer;
import com.test.controller.di.classfile.Stage;

public class MainJava {
	public static void main(String[] args) {
		Singer singer = new Singer();
		Stage stage = new Stage(singer);
		Broadcast broadcast = new Broadcast(stage);
		broadcast.broadcast();
	}
}
