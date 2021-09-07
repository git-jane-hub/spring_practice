package org.ict.controller.di;

import org.ict.controller.di.classfile.Broadcast;
import org.ict.controller.di.classfile.Singer;
import org.ict.controller.di.classfile.Stage;

public class DiMainJavaVer {

	public static void main(String[] args) {
		Singer singer = new Singer();
		singer.sing();
		
		// stage 와 broadecast 는 singer에 의존적 
		Stage stage = new Stage(singer);
		stage.perform();
		
		Broadcast broadcast = new Broadcast(stage);
		broadcast.broadcast();
	}

}
