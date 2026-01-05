<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//controller에서 저장한 값 꺼내기 

String res =(String)request.getAttribute("result");

if(res == null){//입력시 id=asd1234- 사용가능
%>
	{
	"flag" : "사용가능 아이디"
	}




<%}else{//입력시 id=a001-사용불가능%>

	{
	"flag" : "사용 불 가능 아이디"
	}
	
	
	

<%
}
%>