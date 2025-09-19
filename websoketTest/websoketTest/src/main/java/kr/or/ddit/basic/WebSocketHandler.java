package kr.or.ddit.basic;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.EndpointConfig;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

//웹소켓 연결요청을 위한url패턴 지정(웹소켓 서비스명)
@ServerEndpoint(value="/chat.do", configurator= HttpSessionConfigurator.class)
public class WebSocketHandler {


	//접속자를 관리하기 위한 컬렉션 객체 생성
	public static List<Session> clients = Collections.synchronizedList(new ArrayList<>());
	
	
	public WebSocketHandler() {
		System.out.println("[WebSocketHandler] 생성자 호출됨");
	}
	/*
	 * 웹소켓이 연결되면 호출되는 메서드
	 * session 클라이언트와ㅓ 연결된 웹소켓 세션객체
	 * config EndpointConfig 객체 
	 * */
	
	
@OnOpen
public void afterConnectionEstablished(Session session, EndpointConfig config) {
	// 접속된 사용자를 관리하기 위한 컬렉션 객체에 현재 접속한 사용자를 추가한다.
	clients.add(session);
	System.out.println("세션id : " +session.getId() +"로 접속되었음");
	System.out.println("현재 접속자 수  : " + clients.size());
	
}

//웹소켓 연결된 상대방에게 메시지를 보내기 위한 메서드 
/*session 웹소켓 세션객체 */
@OnMessage
public void handleTextMessage(Session session, String message) throws Exception{
	
	//사용자 속성값 가져오기
	String userName = (String) session.getUserProperties().get("userName");
			
	//세션 프라퍼티에 userName이 없으면 userName 을 선언하고 해당 세션을 이용하여 메시지를 보낸다.
	//최초 메시지는 접속자 이름이 전송되기 때문에 useName 속성의 값으로 설정한다.
	if(userName==null) {//처음 접속 메시지 인 경우 ..... 
		session.getUserProperties().put("userName", message);
		
		//접속한 다른 사람들에게 새로운 접속자가 입장했다는 메시지보내기
		for(Session ss: clients) {
			String name = (String) ss.getUserProperties().get("userName");
			if(!name.equals(message)) {
				ss.getBasicRemote().sendText(makeJsonMsg("Server","#" + message +"님이 입장하셨다용~"));
			}
		}
	}else { //일반 채팅 메시지를 보낸경우 .....
		for(Session ss: clients) {
			ss.getBasicRemote().sendText(makeJsonMsg(userName, message));
		}
	
	}
	
	//////////HTTPsessionconfigutator 에서 성정한 http세션 객체 접근하기
	
	HttpSession httpSession = (HttpSession) session.getUserProperties().get("HttpSession");
	System.out.println("메시지 전송한 접속자의 http세션 정보 가져오기 test 중 ....");
	System.out.println(httpSession.getAttribute("sessionData"));
	
}
@OnClose
public void handleClose(Session session)throws IOException{
	//
	clients.remove(session);
	
	System.out.println("퇴장 세션 id : "+session.getId());
	System.out.println("현재 접속자 수  : "+ clients.size());
	
	
	//접속한 다른 사람들에게 퇴장 메시지를 보낸다.
	//String message = (String)session.getUserProperties().get("userName");
	
}

@OnError
public void handlerError(Session session, Throwable ex)throws Exception{
	ex.printStackTrace();
}

public String makeJsonMsg(String userName, String message) {
	return "{\"message\":"+ "\"" + userName + ":" + message + "\"}";
}

}


