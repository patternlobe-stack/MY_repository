<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

 String userId = request.getParameter("id");
String userName = request.getParameter("name");
String userMail = request.getParameter("mail");

//db처리 - crud - 결과값 을 얻는다 

//응답데이탈,ㄹ 생성한다  -json형식의 문자열데이타 


%>

{
 "name"  : "<%= userName %>",
 "id"    : "<%= userId %>",
 "mail"  : "<%= userMail %>"
}