package kr.or.ddit.member.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.vo.MemberVO;

public class MemberServiceImpl implements IMemberService {

	//필요한 객체 
	private IMemberDao  dao ;
	
	//싱글톤
	private static IMemberService  service;
	
	public static IMemberService getService() {
		
		if(service == null) service = new MemberServiceImpl();
		
		return service;
 	}
	
	//생성자 
	private MemberServiceImpl() {
		
	  dao = MemberDaoImpl.getDao();	
	}
	
	@Override
	public MemberVO loginMember(Map<String, Object> map) {
		//MemberVO vo = null;
		//vo = dao.loginMember(map);
		//return vo;
		
		return dao.loginMember(map); //1줄로 표현
		
	}

	@Override
	public List<MemberVO> selectAllMember() { //추가
		// TODO Auto-generated method stub
		return dao.selectAllMember();
	}

	@Override
	public String selectById(String id) {
	    return dao.selectById(id);
	}

	@Override
	public int memberJoin(MemberVO vo) {
		// TODO Auto-generated method stub
		return dao.memberJoin(vo);
	}

}
