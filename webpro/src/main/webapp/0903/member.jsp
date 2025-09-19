<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="kr.or.ddit.util.MyBatisUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
////클라이언트 전송시 데이타 를 받아서 
  
   //db연결 crud처리 
   SqlSession   sql =  MyBatisUtil.getSqlSession();
    
   List<MemberVO>  list = sql.selectList("member.selectAllMember");
   
   //처리 결과를 얻는다 
    //처리결과로 응답데이타를 생성 -json형식의 문자열데이타 를 직렬화  
    // 
    
    Gson gson = new Gson();
    String result = gson.toJson(list);
    
    out.print(result);
    out.flush();
    
   
    
%>

<%-- 
[
<%
  for(int i=0; i<list.size(); i++){
	  MemberVO   vo = list.get(i);
	  if(i > 0) out.print(",");
%>	  
	  {
		  "mem_name"  : "<%=  vo.getMem_name()%>",
		   "mem_id"   : "<%=  vo.getMem_id()%>",
		   "mem_hp"   : "<%=  vo.getMem_hp()%>",
		   "mem_mail" : "<%=  vo.getMem_mail()%>",
		   "mem_add1" : "<%=  vo.getMem_add1()%>"
	  }
 
<%  
  }
%>

] --%>














