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

}
td{
  height : 50px;
  width : 300px;
  text-align: center;
}
th{
  width : 300px;
  background-color:  skyblue;
}

</style>
</head>
<body>
<h1>JSP : Java Server Page</h1>
클라이언트 요청시 실행하는 서버내의 프로그램- back -end  <br>

<%

 String userId = request.getParameter("id");
 String userName = request.getParameter("name");
 String userTel = request.getParameter("tel");
 
 //db저장 
 //결과값을 얻는다
		 
%>

<table border="1">
  <tr>
    <th>아이디</th>
    <td><%=  userId %></td>
  </tr>
  
   <tr>
    <th>이름</th>
    <td><%= userName %></td>
  </tr>

   <tr>
    <th>전화번호</th>
    <td><%= userTel %></td>
  </tr>
</table>
</body>
</html>












