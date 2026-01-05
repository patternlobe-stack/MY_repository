<%@page import="kr.or.ddit.serial.SerialVO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

//클라이언트 전송시 직렬화된 데이타 를 받아서 - 읽기 
//{"id"  : "a001" , pass : "1234567"}
StringBuffer   strbuf = new StringBuffer();
String line = null;

BufferedReader  br = request.getReader();

while(true){
	line = br.readLine();
	if(line == null) break;
	strbuf.append(line);
}

 String reqData = strbuf.toString();
 
//역직렬화 -직렬화된 데이타를 읽어서 java객체로 변환
 Gson  gson = new Gson();
 SerialVO  vo = gson.fromJson(reqData, SerialVO.class);
 //vo.setId("a001")   vo.setpass("1234567") 자동 실행 

//db연결 crud처리  - SerialVO를 이용한다
//처리 결과를 얻는다 
//처리결과로 응답데이타를 생성 - json객체 형식의 텍스트 기반 문자열 
// 
%>

  {
    "name"  : "홍길동",
    "addr"  : "대전",
    "tel"   : "010-1234-5678"
   }










