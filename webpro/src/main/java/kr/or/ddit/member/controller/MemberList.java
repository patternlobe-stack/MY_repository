package kr.or.ddit.member.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class MemberList
 */
@WebServlet("/MemberList.do")
public class MemberList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		//클라이언트 전송데이타 받기 
		
		//service 객체 얻기
		IMemberService service = MemberServiceImpl.getService();
				
		//service 메소드 호출  - 결과값 얻기 
		List<MemberVO> list = service.selectAllMember();
		
		//결과 값을 ,request에 저장 
		request.setAttribute("listData", list);
	
		
		//결과값을 view페이지(jsp)로 이동 - 출력-json형식 문자열 데이타 생셩 ~
		//forword방식을 이용
		request.getRequestDispatcher("/0905/view/member.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
