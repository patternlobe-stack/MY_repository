<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    
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
    <h1>JSP : Java Server Page</h1>
    <p>html코드에 java언어 코드를 기술할 수 있다</p>
    <p>자바코드를 기술할때는  &lt;% &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; %> 기호 사이에 기술한다 </p>
    <P>자바코드를 처리한 후 결과값을 출력 할때는 &lt;%=  자바변수 %> 로 출력한다 </P>
    
    <%
    
       //클라이언트 브라우저 에서 id와 pass을 입력 한 값을 받아온다 
       //hidden으로 name을 전송 받음
       String userId = request.getParameter("id");
       String userPass = request.getParameter("pass");
       String userName = request.getParameter("name");
       
       //db연결 select한다 
       
       //db수행후 결과값을 출력한다 
    %>
    
    <table border="1">
      <tr>
        <th>아이디</th>
        <th>비밀번호</th>
        <th>이름</th>
      </tr>
      
      <tr>
      	<td><%=  userId %></td>
      	<td><%= userPass %></td>
      	<td><%= userName %></td>
      </tr>
    </table>
</body>
</html>










