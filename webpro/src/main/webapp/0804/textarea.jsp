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
<h1>JSP : Java Server page</h1>

<%
String userId = request.getParameter("id");
String userName = request.getParameter("name");
String info = request.getParameter("area");

//info는 엔터기호가 포함 (\r\n)
//그러나 츨력시에 줄바꿈이 실행 되지 않는다 
//\n기호를 <br>테그로 변경 
info = info.replaceAll("\n", "<br>");

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
    <th>자기소개</th>
    <td><%= info %></td>
  </tr>
</table>
</body>
</html>