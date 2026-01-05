package kr.or.ddit.member.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;

import java.io.IOException;

/**
 * Servlet implementation class selectById
 */
@WebServlet("/selectById.do")
public class selectById extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public selectById() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		
		//클라이언트 전송 데이타 받기 id="a001" /id ="asdf1234"
		//service객체 얻기
		//service 메소드 호출하기 -결과값 받기 - string(a001/null)
		//결과값을 request에 저장  (꺼내지는이름, res)
		//view페이지 jsp로 이동 

	// 클라이언트 전송 데이터 받기 id="a001" / id="asdf1234"
	String userId = request.getParameter("id");

	// service 객체 얻기
	IMemberService service = MemberServiceImpl.getService();

	// service 메소드 호출하기 - 결과값 받기 (String : a001 / null)
	String res = service.selectById(userId);

	// 결과값을 request에 저장
	request.setAttribute("result", res);

	// view 페이지(jsp)로 이동
	request.getRequestDispatcher("/0905/view/idcheck.jsp")
	       .forward(request, response);
}
}