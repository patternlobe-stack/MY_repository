<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String userId = request.getParameter("id");
String userName = request.getParameter("name");
String userMail = request.getParameter("mail");

//db처리 - 결과값 얻기 
//json형식의 문자열데이타로 직렬화 
%>


{
 "name"  : "<%= userName %>",
 "id"    : "<%= userId %>",
 "mail"  : "<%= userMail %>"
}