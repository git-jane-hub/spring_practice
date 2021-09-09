package com.test.controller.di;

import com.test.controller.di.classfile.Broadcast;
import org.springframework.context.support.GenericXmlApplicationContext;

public class MainSpring {
	public static void main(String[] args) {
		GenericXmlApplicationContext context = new GenericXmlApplicationContext("file:src/main/webapp/WEB-INF/spring/root-context.xml");
		Broadcast broadcast = context.getBean("broadcast", Broadcast.class);
		broadcast.broadcast();
		context.close();
	}
}
