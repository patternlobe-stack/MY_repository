<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.util.MyBatisUtil"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
table{
border : 2px solid blue;
border-collapse:  collapse;
}

td{
  width : 100px;
  height : 50px;
  text-align: center;
}
th{
  height : 50px;
  background: skyblue;
}
</style>
</head>
<body>

<%

////클라이언트 전송시 데이타 를 받아서 

//db연결 crud처리 
SqlSession   sql =  MyBatisUtil.getSqlSession();

List<MemberVO>  list = sql.selectList("member.selectAllMember");

//처리 결과를 얻는다 
//처리결과로 응답페이지를 만든다 
%>

<table border="1">
<tr>
<th>아이디</th>
<th>이름</th>
<th>주소</th>
<th>전화번호</th>
<th>메일</th>
</tr>
<%

 for(int i=0; i<list.size(); i++){
	 MemberVO  vo = list.get(i);
%>
	
	 <tr>
	   <td><%= vo.getMem_id() %></td>
	   <td><%= vo.getMem_name() %></td>
	   <td><%= vo.getMem_add1() %></td>
	   <td><%= vo.getMem_hp() %></td>
	   <td><%= vo.getMem_mail() %></td>
	 </tr>
<%	 
 }
%>

</table>
</body>
</html>



