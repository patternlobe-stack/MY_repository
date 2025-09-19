<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 int cnt = new Random().nextInt(1000);

 session.setAttribute("sessionData", "홍길동"+ cnt);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"/>
<title>웹소켓 사용 예제</title>
</head>
<body>
	<label for="userName">접속자 이름: </label><input type="text" id="userName" value="">
	<button type="button" id="connBtn" onclick="connect()">(재)연결</button>
	<button type="button" id="disConnBtn" disabled="disabled" onclick="disConnect()">접속끊기</button>
	<br>
	<hr align="left" width="410px">

    <!-- 메시지 표시 영역 -->
    <textarea id="chatMsg" readonly="readonly" rows="10" cols="55"></textarea><br>

    <!-- 송신 메시지 텍스트박스 -->
    <input type="text" id="sendMsg" size="45" onkeyup="enterKey()">

    <!-- 송신 버튼 -->
    <button type="button" onclick="sendMessage()">보내기</button>


    
<!-- /*
    
    1. 웹소켓(WebSocket) 에 대하여...
    
    웹소켓(WebSocket)은 클라이언트와 서버 간의 실시간 양방향 통신을 가능하게 하는 고급 기술이다. 
    기존의 HTTP 프로토콜과 달리, 웹소켓은 한 번의 핸드셰이크를 통해 연결이 설정되면 서버와 클라이언트가 언제든지 데이터를 주고받을 수 있다.

    2. 웹소켓의 주요 특징
    
	  	- 양방향 통신: 클라이언트와 서버가 동시에 데이터를 송수신할 수 있다.

		- 지속적인 연결: 핸드셰이크 후 연결이 유지되며, 데이터를 빠르게 주고받을 수 있다.

		- 낮은 오버헤드: HTTP 요청/응답과 달리 추가적인 헤더가 필요하지 않아, 작은 데이터를 빈번하게 전송하는 애플리케이션에 유리하다.
		
	3. 인증 과정 (클라이언트 측)
		
		3-1. 클라이언트의 Key 준비: 클라이언트는 자신이 보낸 Sec-WebSocket-Key 값을 기억한다. 예: Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==

		3-2. 서버의 응답 확인: 서버가 Sec-WebSocket-Accept 값을 응답한다. 예: Sec-WebSocket-Accept: s3pPLMBiTxaQ9kYGzzhZRbK+xOo=

		3-3. 값 계산: 클라이언트는 Sec-WebSocket-Key 값에 "258EAFA5-E914-47DA-95CA-C5AB0DC85B11" 문자열을 더하고, 그 결과를 SHA-1 해시를 통해 해싱한다.

			 dGhlIHNhbXBsZSBub25jZQ==258EAFA5-E914-47DA-95CA-C5AB0DC85B11

		3-4. 해싱 및 인코딩: 결과 문자열을 SHA-1 해싱 알고리즘으로 해싱한 후, Base64로 인코딩한다.

			SHA-1("dGhlIHNhbXBsZSBub25jZQ==258EAFA5-E914-47DA-95CA-C5AB0DC85B11")
			결과: s3pPLMBiTxaQ9kYGzzhZRbK+xOo=
		
		3-5. 서버 응답과 비교: 클라이언트는 계산된 Base64 인코딩 값과 서버가 응답한 Sec-WebSocket-Accept 값을 비교한다. 
		     두 값이 동일하면 서버가 신뢰할 수 있는 것으로 인증한다.

		이 과정을 통해 클라이언트는 서버의 응답이 올바른지 확인하고, 신뢰할 수 있는 연결을 설정한다.
    
*/ -->
</body>
<script>
//웹소켓 객체변수 선언
var webSocket;   // 웹소켓 객체를 저장할 전역 변수

// ====================== 웹소켓 접속하기 ======================
function connect(){
	const userName = document.getElementById("userName").value;
	if(userName.trim().length === 0){
		alert('접속자 이름을 입력해 주세요.');
		return;
	}
	
	/*
	웹소켓의 readyState 상태값
	- CONNECTING = 0 (아직 연결이 안된 상태)
	- OPEN = 1 (연결 완료 → 통신 가능)
	- CLOSING = 2 (연결 종료 중)
	- CLOSED = 3 (연결 종료됨)
	*/
	
	// 이미 연결된 소켓이 있으면 먼저 끊고 새로 연결
	if(webSocket && webSocket.readyState !== 3){
		disConnect(); // 기존 연결 종료
	}
	
	// === 새로운 웹소켓 연결 시작 ===
	// ws://서버IP:포트번호/컨텍스트명/서비스명
	webSocket = new WebSocket("ws://192.168.143.3:8080/chat.do");
	
	
	// ---------------------- 웹소켓 연결 성공 시 ----------------------
	webSocket.onopen = (e) =>{
		displayChatMessage('웹소켓이 연결되었습니다.');
		
		// 연결끊기 버튼 활성화
		document.querySelector("#disConnBtn").disabled = false;
		
		// 접속자 이름을 서버로 전송
		const userName = document.querySelector("#userName").value;
		webSocket.send(userName);
	};
	
	
	// ---------------------- 웹소켓 에러 발생 시 ----------------------
	webSocket.onerror = (e) => {
		console.log('에러발생', e);
	};
	
	
	// ---------------------- 서버에서 메시지 수신 시 ----------------------
	webSocket.onmessage = (msg) =>{
		// 전달된 메시지를 JSON 데이터로 파싱
		const jsonData = JSON.parse(msg.data);
		
		// message 값이 존재하면 출력
		if(jsonData.message !== null){
			displayChatMessage(jsonData.message);
		}
	};
	
} // ====== connect() 끝 ======


// ======================대화창에 메시지 출력하기 ======================
function displayChatMessage(msg){
	// textarea(#chatMsg)에 메시지 추가
	const chatMsg = document.querySelector("#chatMsg");
	chatMsg.value += msg + "\n";
	
	// 스크롤을 맨 아래로 이동
	chatMsg.scrollTop = chatMsg.scrollHeight;
} // ====== displayChatMessage() 끝 ======


// ====================== 메시지 보내기 ======================
function sendMessage(){
	// (오타 주의) → querySelector("sendMsg") ❌
	// input의 id 또는 name에 맞게 수정해야 함. (예: "#sendMsg")
	const sendMsg = document.querySelector("#sendMsg");
	
	// 입력한 메시지를 서버로 전송
	webSocket.send(sendMsg.value);
	
	// 입력창 초기화
	sendMsg.value = "";
} // ====== sendMessage() 끝 ======


// ======================엔터키 이벤트 처리 ======================
function enterKey(){
	if(window.event.keyCode == 13){ // Enter 키 눌렸을 때
		sendMessage();
	}
} // ====== enterKey() 끝 ======


	//====================웹소켓 끊기
function disConnect(){
	console.log('기존소켓 닫기');
	webSocket.close();
	
	displayChatMessage('웹소켓 연결이 종료되었습니다.');
	
	document.querySelector("#disConnBtn").disabled = true;
};

</script>

</body>
</html>