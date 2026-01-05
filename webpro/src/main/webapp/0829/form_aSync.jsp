<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 <style>
    h1{
       color : red;
    }
    
    table{
       border : 3px solid blue;
    }
    td{
       width : 200px;
       height : 60px;
       text-align: center;
    }
    th{
       height : 60px;
       background : skyblue;
    }
    </style>
    
    
</head>
<body>

<h1>JSP : Java Server page</h1>
<%
  
String userName = request.getParameter("name");
String userTel = request.getParameter("tel");

//db연결 - select delete insert update작업
//결과를 앋어서 응답데이타를 생성 한ㄷ- 출력 


%>
<!--응답결과   -->

<table border="1">
      <tr>
        <th>이름</th>
        <th>전화번호</th>
      </tr>
      
      <tr>
      	<td><%= userName %></td>
      	<td><%= userTel %></td>
      </tr>
 </table>




</body>
</html>