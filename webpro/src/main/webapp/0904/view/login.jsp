<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
  //서블릿 controller에서 저장 한 값ㅇ를 꺼낸다
    MemberVO  vo = (MemberVO)request.getAttribute("result");

   //자바 객체를 json형식의 문자열 데이타를 생성 -직렬화 
   //Gson gson = new Gson();
	Gson gson = new GsonBuilder().setPrettyPrinting().create();
   
   String res = gson.toJson(vo);
   
   out.print(res);
   out.flush();
   
    
    %>
    
    
    
    
<%-- <%

//서블릿 controller에서 저장 한 값ㅇ를 꺼낸다
 MemberVO  vo = (MemberVO)request.getAttribute("result");

//자바 객체를 json형식의 문자열 데이타를 생성 




if(vo != null) {
%>
 {
    "flag" : "<%= vo.getMem_id() %>님 환영합니다"
 }
	
<% }else{ %>

 {
   "flag" : "로그인 실패"
 }
<%	
}
%> --%>

