<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Bootstrap 기반 웹페이지</title>

<!-- Font Awesome CDN (head 영역에 삽입) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  
  <style>
    html, body {
      height: 100%;
      margin: 0;
    }
  
    .main-layout {
      height: calc(100vh - 100px); 
      overflow: hidden;
    }
    aside {
      background-color: #f8f9fa;
      height: 100%;
      overflow-y: auto;
    }
    section {
      width : 100%;
      height: 100%;
      overflow-y: auto;
      padding: 20px;
    }
    footer {
      height: 50px;
      line-height: 50px;
    }
    
  
     .dropdown {
    position: relative;
    display: inline-block;
  }
 .custom-aside{
    width : 250px;
 }
/* 드롭다운 버튼 내부 정렬 및 높이 통일 */
.dropdown .btn {
  height: 35px;
  padding: 4px 10px;
  display: flex;
  align-items: center;
  margin-right: 8px; /* 선택 사항 */
}

/* 회원가입 버튼도 동일한 높이 적용 */
header .btn-outline-light.btn-sm {
  height: 35px;
  padding: 4px 10px;
}
  .dropdown-content {
    display: none;
    position: absolute;
    background-color: white;
    min-width: 140px;
    box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
    z-index: 1;
  }

  .dropdown-content a {
    color: black;
    padding: 8px 12px;
    text-decoration: none;
    display: block;
  }

  .dropdown-content a:hover {
    background-color: #f1f1f1;
  }

  .dropdown:hover .dropdown-content {
    display: block;
  }
    .profile-img {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    object-fit: cover;
    margin-right: 8px;
  }
  </style>
</head>
<body class="d-flex flex-column">
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
 
 
<%@ page session="true" %>

<!-- Header -->
<!-- py-4 :세로길이.   원래는 py-2 이었는데  py-4로 바꿈-->
 <header class="bg-dark text-white px-4 py-4 d-flex justify-content-end align-items-center">

   <c:choose> 
    <c:when test="${empty sessionScope.loginok}">
      <button class="btn btn-outline-light btn-sm me-2" onclick="location.href='logpro.jsp'">🔐 로그인</button>
      <button class="btn btn-outline-light btn-sm" onclick="location.href='../member/join.html'">>📝 회원가입</button>
    </c:when>
    <c:otherwise>
	 <div class="dropdown">
        <button class="btn btn-outline-light btn-sm dropdown-toggle d-flex align-items-center" type="button" data-bs-toggle="dropdown" aria-expanded="false">
          <!-- 사용자 프로필 이미지가 있다면 해당 이미지, 없으면 기본 아이콘 -->
          <img src="<%= session.getAttribute("profileImg") != null ? session.getAttribute("profileImg") : "../upload/profile/crismasth.jpeg" %>" class="profile-img" alt="profile">
          <span><strong>${sessionScope.loginok.mem_id}님</strong></span>
        </button>

        <ul class="dropdown-menu dropdown-menu-end">
          <li><a class="dropdown-item" href="mypage.jsp">👤 마이페이지</a></li>
          <li><a class="dropdown-item" href="mail.jsp">📧 메일</a></li>
          <li><a class="dropdown-item" href="message.jsp">💬 쪽지</a></li>
          <li><hr class="dropdown-divider"></li>
          <li><a class="dropdown-item text-danger" onclick="logout()">🚪 로그아웃</a></li>
        </ul>
      </div>
	</c:otherwise>
  </c:choose>  
  
</header>


  <!-- Main Layout -->
  <div class="container-fluid flex-grow-1">
    <div class="row main-layout">
      <!-- Aside -->
     <aside class="col-3 col-md-2 p-3 border-end">
     <!--  <aside class="custom-aside  p-3 border-end"> -->
        <ul class="nav flex-column">
          <li class="nav-item mb-2"><a class="nav-link" href="#" onclick="loadContent('홈')">🏠 홈</a></li>
          <li class="nav-item mb-2"><a class="nav-link" href="#" onclick="loadContent('게시판')">📋 게시판</a></li>
          <li class="nav-item mb-2"><a class="nav-link" href="#" onclick="loadContent('QNA')" >💬❓ QNA</a></li>
          <li class="nav-item"><a class="nav-link" href="#" onclick="loadContent('북스토어')">⚙️ 북스토어</a></li>
        </ul>
        
      </aside>

      <!-- Section -->
      <section class="col-9 col-md-10" id="content">
        <h2>홈</h2>
        <p>환영합니다! 왼쪽 메뉴를 클릭하여 내용을 확인하세요.</p>
      </section>
    </div>
  </div>

  <!-- Footer -->
  <footer class="bg-dark text-white text-center">
    ⓒ 2025 My Bootstrap Page. All rights reserved.
  </footer>


<script src="../js/jquery-3.7.1.js"></script>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


  <!-- Custom JS -->
  <script>
  mypath = '<%= request.getContextPath()%>';
  /* 프로젝트 이름  mypath*/
  
  function loadContent(menu) {
      
		const menuContent = document.getElementById('content');
		
	      let html = '';

	      switch (menu) {
	        case '홈':
	          html = `<h2>홈</h2><p>홈 페이지에 오신 것을 환영합니다!</p>`;
	          break;
	        case '게시판':
	          $(menuContent).load(`\${mypath}/board/board.jsp`);
	       
	          break;
	        case 'QNA':
		          $(menuContent).load(`\${mypath}/qnaboard/qnaboard.jsp`);
		          break;
		          
	          
	        case '북스토어':
	          html = `<h2>북스토어</h2><p>여기서 환경 설정을 변경할 수 있습니다.</p>`;
	          break;
	        default:
	          html = `<h2>404</h2><p>해당 메뉴는 존재하지 않습니다.</p>`;
	      }

	      menuContent.innerHTML = html;
  }
	   
		
 const  logout = async function(){
	    	
	   	 try {
	   	        const response = await fetch(`\${mypath}/Logout.do`);

	   	        if (!response.ok) {
	   	            throw new Error(`HTTP error! Status: \${response.status}`);
	   	        }
				const {flag} = await  response.json();
		
				if(flag == "fail"){
					location.href=`\${mypath}/start/index.jsp`;
			   	 }
				     
	   	    } catch (error) {
	   	        console.error('로그인 요청 실패:', error);
	   	    }
	   };

  </script>
</body>
</html>
