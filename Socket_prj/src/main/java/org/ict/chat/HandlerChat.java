package org.ict.chat;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

// 채팅에서 유저 분류를 담당
@Component
public class HandlerChat extends TextWebSocketHandler {

	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	// 채팅방 입장(신규 사용자가 접속할 때마다 작동하는 메서드)
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		// 채팅방에 접속한 사용자 세션을 리스트에 저장
		sessionList.add(session);
		System.out.println("사용자 세션리스트: " + sessionList);
		
		// 모든 세션에 채팅 전달
		for(int i = 0; i < sessionList.size(); i++) {
			// 사용자가 접속시마다 sesssionList에서 한명씩 s에 저장
			WebSocketSession s = sessionList.get(i);
			
			// 연결된 접속자에 'xxx님이 입장하셨습니다.'라는 안내메세지 전달
			s.sendMessage(new TextMessage(session.getId() + "님이 입장했습니다."));
		}
	}

	// 채팅 발신(한 사용자가 메세지를 전달하면 같은 채팅방 전체 접속자에게 안내해주는 메서드)
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		// 모든 세션에 채팅 전달
		for(int i = 0; i < sessionList.size(); i++) {
			// 사용자 개개인
			WebSocketSession s = sessionList.get(i);
			s.sendMessage(new TextMessage(session.getId() + ": " + message.getPayload()));
			System.out.println(message);
		}
	}

	// 채팅방 퇴장(사용자가 접속 종료시 안내하는 메서드)
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
				
		// 채팅방에서 퇴장한 사용자 세션을 리스트에서 제거
		sessionList.remove(session);
		System.out.println("퇴장한 사용자 확인: " + status);
	
		// 모든 세션에 채팅 전달
		for(int i = 0; i < sessionList.size(); i++) {
			WebSocketSession s = sessionList.get(i);
			s.sendMessage(new TextMessage(session.getId() + "님이 퇴장했습니다."));
		}
	}
	
}
