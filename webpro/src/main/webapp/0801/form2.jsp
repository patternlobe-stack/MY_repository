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
  <%
     String  userId = request.getParameter("id");
     String  gender = request.getParameter("gender");
	 String userFile = request.getParameter("file");
	 
     String  likes[]  = request.getParameterValues("like");
     
     String str="";
     
     for(int i=0 ; i<likes.length; i++){
    	 str += likes[i] + " ";
     }
  %>
  
  <table border="1">
    <tr>
        <th>아이디</th>
        <th>성별</th>
        <th>좋아하는 음식</th>
        <th>첨부파일</th>
     </tr>
     
     <tr>
      	<td><%= userId %></td>
      	<td><%= gender %></td>
      	<td><%= str %></td>
      	<td><%= userFile %></td>
      </tr>
      
  </table>
</body>
</html>