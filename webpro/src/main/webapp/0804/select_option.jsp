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

div{
  border : 1px dotted orange;
  margin : 5px;
  padding : 3px;
}

.car1, .car2{
  border : 2px solid green;
}
.d1{
   border  : 3px dashed red;
}
.d2{
   border : 3px solid blue;
}
</style>


</head>
<body>
<h1> JSP : Java Server Page</h1>
<%
  String car1 = request.getParameter("car1");

  String car2[] = request.getParameterValues("car2");
  
  String str = "";
  
  for(String car : car2){
	  str += car + "<br>";
  }

%>


<table border="1">
  <tr>
    <th>자동차1</th>
    <td><%=  car1 %></td>
  </tr>
  
   <tr>
    <th>자동차2</th>
    <td><%= str %></td>
  </tr>
</table>

<br>
<hr>
<br>

<div class="car">
  <div class="car1">
    <div class="d1">자동차1</div>
    <div class="d2"><%=  car1 %></div>
  </div>
  
   <div class="car2">
    <div class="d1">자동차2</div>
    <div class="d2"><%= str %></div>
  </div>
</div>


</body>
</html>