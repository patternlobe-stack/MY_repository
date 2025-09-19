<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 40px;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    form {
        background-color: white;
        padding: 20px 30px;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        max-width: 300px;
        width: 100%;
    }

    label {
        display: block;
        margin-bottom: 6px;
        font-weight: bold;
    }

    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 8px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    button {
        width: 100%;
        padding: 10px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
    }

    button:hover {
        background-color: #0056b3;
    }

    p {
        font-size: 18px;
        margin-bottom: 20px;
        color: #333;
        text-align: center;
    }
  #flogin div{
      margin : 5px;
  }
</style>

<script src="../js/jquery-3.7.1.js"></script>


<script>
  mypath =  '<%= request.getContextPath()%>';


 const  login = async function() {
	// alert("login");
    const id = $('#id').val();
    const pass = $('#password').val();
    
    const data =JSON.stringify({mem_id : id, mem_pass : pass});
    
    try {
        const response = await fetch(`\${mypath}/LoginMember.do`, { //변경부분 =컨트롤러부분
            method: 'POST',
            headers: {
                'Content-Type': 'application/json;charset=utf-8',
            },
            body: data
        })
         console.log(response);
        if (!response.ok) {
            throw new Error(`HTTP error! Status: \${response.status}`);
        }
		
        const result = await response.json();
        
        if(result['flag']=="ok"){
        	
        	location.href=`\${mypath}/start/index.jsp`;
        }else{
        	$('#spanres').text("아이디 또는 비밀번호 확인..").css("color", "red");
        	
        }
       
    }catch(error) {
        console.error('로그인 요청 실패:', error);
    }
} 

  $(document).on('click','#login' , function(){
	
	login();
}) 
 
/*  $('#login').on('click', function(){
	
	login();
}) 
 */

</script>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="res" value="${sessionScope.loginok}"></c:set>

 <c:choose>
  <%--  loginok가 null이면 로그인 폼을 출력 --%>
    <c:when test="${res == null}">
        <form  id="flogin" >
            <label for="id">ID:</label>
            <input type="text" name="mem_id" id="id" required><br>

            <label for="password">Password:</label>
            <input type="password" name="mem_pass" id="password" required><br>
 			<div id="spanres">&nbsp;&nbsp;</div>
            <button type="button" id="login" >로그인</button>
           
        </form>
    </c:when>
   
</c:choose>

