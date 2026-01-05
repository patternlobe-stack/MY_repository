<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//서블릿 controller에서 저장한 값 꺼내기

List<MemberVO> list = (List<MemberVO>)request.getAttribute("listData");
/* MemberList의 request.setAttribute("listData", list);과 맞췀 */

//jason형식의 문자열 데이타 만들기 - java객체를 jason형식의 문자열로 직렬화 
Gson gson =new GsonBuilder().setPrettyPrinting().create();

String result = gson.toJson(list);

out.print(result);
out.flush();


%>


