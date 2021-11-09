<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 접속 주소: localhost:8181/chatting?room_id=임의의 방번호 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.js"></script>
<script type="text/javascript" >
	var webSocket = {
		init: function(param){
			this._url = param.url;
			this._initSocket();
		},
		sendChat: function(){
			this._sendMessage('${param.room_id}', 'CMD_MSG_SEND', $('#message').val());
			$('#message').val('');
		},
		sendEnter: function(){
			this._sendMessage('${param.room_id}', 'CMD_ENTER', $('#message').val());
			$('#message').val('');
		},
		receiveMessage: function(msgData){
			// 메세지 전송
			if(msgData.cmd == 'CMD_MSG_SEND'){
				$('#divChatData').append('<div>' + msgData.msg + '</div>');
			}
			// 입장
			else if(msgData.cmd == 'CMD_ENTER'){
				$('#divChatData').append('<div>' + msgData.msg + '</div>');				
			}
			// 퇴장
			else if(msgData.cmd == 'CMD_EXIT'){
				$('#divChatData').append('<div>' + msgData.msg + '</div>');				
			}
		},
		closeMessage: function(str){
			$('#divChatData').append('<div>' + '연결 끊김: ' + str + '</div>');
		},
		disconnect: function(){
			this._socket.close();
		},
		_initSocket: function(){
			this._socket = new SockJS(this._url);
			this._socket.onopen = function(evt){
				webSocket.sendEnter();
			};
			this._socket.onmessage = function(evt){
				webSocket.receiveMessage(JSON.parse(evt.data));
			};
			this._socket.onclose = function(evt){
				webSocket.closeMessage(JSON.parse(evt.data));
			}
		},
		_sendMessage: function(room_id, cmd, msg){
			var msgData = {
					room_id : room_id,
					cmd : cmd,
					msg : msg
			};
			var jsonData = JSON.stringify(msgData);
			this._socket.send(jsonData);
		}
	};
</script>
<script>
$(window).on('load', function(){
	webSocket.init({url: '<c:url value="/chat" />'});
});
</script>
</head>
<body>
	<div style="width: 800px; height: 700px; padding: 10px; border: solid 1px #e1e3e9;">
		<div id="divChatData"></div>
	</div>
	<div style="width: 100%; height: 10%; padding: 10px;">
		<input type="text" id="message" size="110" onkeypress="if(event.keyCode==13){webSocket.sendChat();}" />
		<input type="button" id="btnSend" value="send" onclick="webSocket.sendChat()" />
	</div>
</body>
</html>