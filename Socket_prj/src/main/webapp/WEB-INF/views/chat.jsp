<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.js"></script>
<script type="text/javascript" >
	var webSocket = {
		init: function(param){
			this._url = param.url;
			this._initSocket();
		},
		sendChat: function(){
			this._sendMessage($('#message').val());
			$('#message').val('');
		},
		receiveMessage: function(str){
			$('#divChatData').append('<div>' + str + '</div>');
		},
		closeMessage: function(str){
			$('#divChatData').append('<div>' + '???? ????: ' + str + '</div>');
		},
		disconnect: function(){
			this._socket.close();
		},
		_initSocket: function(){
			this._socket = new SockJS(this._url);
			this._socket.onmessage = function(evt){
				webSocket.receiveMessage(evt.data);
			};
			this._socket.onclose = function(evt){
				webSocket.closeMessage(evt.data);
			}
		},
		_sendMessage: function(str){
			this._socket.send(str);
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