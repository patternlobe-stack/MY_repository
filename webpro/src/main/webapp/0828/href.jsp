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
div{
   width : 500px;
   height : 300px;
   border : 2px dotted blue;
   padding : 5px;
   margin : 3px;
   background : pink;
}
</style>
</head>
<body>
<h1>JSP : Java Server Page</h1>

<%
  String userId = request.getParameter("id");
  
  //db에서 id=a001인 user를 검색 -  select 
		  

%>



<div>

<%=  userId %>
</div>


</body>
</html>









