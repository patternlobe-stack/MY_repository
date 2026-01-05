package kr.or.ddit.member.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.util.SerialData;

import java.io.IOException;

import com.google.gson.Gson;

/**
 * Servlet implementation class MemberJoin
 */
@WebServlet("/MemberJoin.do")
public class MemberJoin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberJoin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		//클라이언트 전송데이타 받기 
		//{"mem_id" : "asd113", "mem_pass" : "1212"
		 String reqData = SerialData.changeData(request);

	        // 2. JSON → MemberVO 변환 (역직렬화)
	        Gson gson = new Gson();
	        MemberVO vo = gson.fromJson(reqData, MemberVO.class);

	        // 3. Service 객체 얻기
	        IMemberService service = MemberServiceImpl.getService();

	        // 4. Service 메소드 호출 (DB insert)
	        int res = service.memberJoin(vo);

	        // 5. 결과값을 request에 저장
	        request.setAttribute("result", res);

	        // 6. View 페이지로 이동
	        request.getRequestDispatcher("/0905/view/join.jsp")
	               .forward(request, response);
	    }
	}