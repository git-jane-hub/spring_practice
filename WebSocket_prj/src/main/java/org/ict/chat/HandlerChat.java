package org.ict.chat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

// 채팅에서 유저 분류를 담당
@Component
public class HandlerChat extends TextWebSocketHandler {

	// {"rood_id" : 방ID, "session" : 세션}을 연달아 저장
	private List<Map<String, Object>> sessionList = new ArrayList<Map<String, Object>>();

	// 메세지를 맞는 방에만 전달하는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		super.handleTextMessage(session, message);
		
		// JSON을 Map으로 변환
		ObjectMapper objectMapper = new ObjectMapper();
		Map<String, String> mapReceive = objectMapper.readValue(message.getPayload(), Map.class);
		
		// 커맨트 패턴(요청정보)
		switch(mapReceive.get("cmd")) {
		// 사용자 입장
		case "CMD_ENTER":
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("room_id", mapReceive.get("room_id"));
			map.put("session", session);
			sessionList.add(map);
			
			for(int i = 0; i < sessionList.size(); i++) {
				// 채팅 서버에 접속한 모든 사용자 목록 가져오기
				// sessionList를 조회하면 Map자료형이 나오기때문
				Map<String, Object> mapSessionList = sessionList.get(i);
				
				// room_id 와 session 먼저 꺼내오기
				String room_id = (String)mapSessionList.get("room_id");
				WebSocketSession sess = (WebSocketSession)mapSessionList.get("session");
				
				// 메세지를 보내야하는 방이 맞는지 확인
				if(room_id.equals(mapReceive.get("room_id"))) {
					// xxx 사용자가 접속했다는 것을 서버레 송신해 공지하도록 빈 map을 생성
					Map<String, String> mapToSend = new HashMap<String, String>();
					
					// room_id(몇 번 방에), cmd(입장 시 처리를), msg(메세지를 담아)
					mapToSend.put("room_id", room_id);
					mapToSend.put("cmd", "CMD_ENTER");
					mapToSend.put("msg", session.getId() + "님이 입장했습니다.");		
					
					// json으로 변환해서
					String jsonStr = objectMapper.writeValueAsString(mapToSend);
					// 서버로 전송
					sess.sendMessage(new TextMessage(jsonStr));
				}
			}
			break;
		// 사용자 메세지 발송	
		case "CMD_MSG_SEND":
			// 같은 채팅방에 메세지 전송
			for(int i = 0; i < sessionList.size(); i++) {
				Map<String, Object> mapSessionList = sessionList.get(i);
				String room_id = (String) mapSessionList.get("room_id");
				WebSocketSession sess = (WebSocketSession)mapSessionList.get("session");
				
				if(room_id.equals(mapReceive.get("room_id"))) {
					Map<String, String> mapToSend = new HashMap<String, String>();
					mapToSend.put("room_id", room_id);
					mapToSend.put("cmd", "CMD_MSG_SEND");
					mapToSend.put("msg", session.getId() + ": " + mapReceive.get("msg"));
					
					String jsonStr = objectMapper.writeValueAsString(mapToSend);
					sess.sendMessage(new TextMessage(jsonStr));
				}
			}
			break;
		}
	}

	// 클라이언트가 연결을 끊음
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		super.afterConnectionClosed(session, status);
		
		ObjectMapper objectMapper = new ObjectMapper();
		String current_room_id = "";
		
		// 사용자 세션을 리스트에서 제거
		for(int i = 0; i < sessionList.size(); i++) {
			Map<String, Object> map = sessionList.get(i);
			String room_id = (String)map.get("room_id");
			WebSocketSession sess = (WebSocketSession)map.get("session");
			
			if(session.equals(sess)) {
				current_room_id = room_id;
				sessionList.remove(map);
				break;
			}
		}
		
		// 같은 채팅방에 퇴장 메세지 전송
		for(int i = 0; i < sessionList.size(); i++) {
			Map<String, Object> mapSessionList = sessionList.get(i);
			String room_id = (String)mapSessionList.get("room_id");
			WebSocketSession sess = (WebSocketSession)mapSessionList.get("session");
			
			if(room_id.equals(current_room_id)) {
				Map<String, String> mapToSend = new HashMap<String, String>();
				mapToSend.put("room_id", room_id);
				mapToSend.put("cmd", "CMD_EXIT");
				mapToSend.put("msg", session.getId() + "님이 퇴장했습니다.");
				
				String jsonStr = objectMapper.writeValueAsString(mapToSend);
				sess.sendMessage(new TextMessage(jsonStr));
			}
		}
	}
}
