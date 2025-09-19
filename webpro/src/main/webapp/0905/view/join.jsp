<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // controller에서 request.setAttribute("result", cnt) 로 저장한 값 꺼내기
    int a = (Integer)request.getAttribute("result");

    if(a > 0) {
%>
    {"flag":"가입성공"}
<%
    } else {
%>
    {"flag":"가입실패"}
<%
    }
%>