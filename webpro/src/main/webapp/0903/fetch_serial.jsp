<%@page import="kr.or.ddit.serial.SerialVO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.util.SerialData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

//직렬화된 데이타 읽기
//{"id" : "sdfsdf", "name" : "sdfsdf", "mail" :"sdfsdf"}

  String reqData = SerialData.changeData(request);
  

//역직렬화  - 자바 객체로 변환 
Gson  gson = new Gson();
SerialVO   vo = gson.fromJson(reqData, SerialVO.class);
//vo.setId("sdfsdf") vo.setName("sdfsdf") vo.getMail("sdfsdf") 자동 실행 


//db처리 - 결과데이타 생성 - json형식의 문자열 데이타 
%>


{
 "name"  : "<%= vo.getName()%>",
 "id"    : "<%= vo.getId() %>",
 "mail"  : "<%= vo.getMail() %>"
}



