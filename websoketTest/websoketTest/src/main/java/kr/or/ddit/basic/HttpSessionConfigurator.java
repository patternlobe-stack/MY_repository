package kr.or.ddit.basic;

import org.apache.tomcat.websocket.server.DefaultServerEndpointConfigurator;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.HandshakeResponse;
import jakarta.websocket.server.HandshakeRequest;
import jakarta.websocket.server.ServerEndpointConfig;

public class HttpSessionConfigurator extends DefaultServerEndpointConfigurator{
	
	
		
	@Override
	public void modifyHandshake(ServerEndpointConfig config, HandshakeRequest request, HandshakeResponse response) {

		System.out.println("[HttpSessionConfigurator] modifyHandshake()호출됨");
	//http세션객체 가져오기
	HttpSession httpSession = (HttpSession)request.getHttpSession();
	
	//Userpro.. http세션 객체를 저장한다..
	
	config.getUserProperties().put("HttpSession", httpSession);
	
	}


	}

