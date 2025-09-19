<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#box{
  border : 2px solid blue;
  margin : 20px;
  padding : 10px;
  font-size : 1.5rem;
}
.row{
}

.title{
   display : inline-block;
   width : 30%;
   height : 50px;
   background : skyblue;
}
.data{
  display : inline-block;
  width : 30%;
  height : 50px;
}
</style>
</head>
<body>
<%
   String id = request.getParameter("inputId");
  String name = request.getParameter("inputName");
  String tel = request.getParameter("tel");
%>


<div id="box">
   <div class="row">
     <div class="title">아이디</div>
     <div class="title">이름</div>
     <div class="title">전화번호</div>
   </div>
   
   <div class="row">
     <div class="data"><%= id  %></div>
     <div class="data"><%= name %></div>
     <div class="data"><%= tel %></div>
   </div>
</div>

</body>
</html>