package kr.or.ddit.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.util.MyBatisUtil;

public class MemberDaoImpl implements IMemberDao {

	//필요한 객체 - MyBatisㅂ접근 -SqlSession
	
	
	
	//싱글톤 패턴 
	private static IMemberDao dao;
	
	public static IMemberDao getDao() {
		if(dao == null) dao = new MemberDaoImpl();
		
		return dao;
	}
	
	//생성자 
	private  MemberDaoImpl() { }
	
	
	@Override
	public MemberVO loginMember(Map<String, Object> map) {
		
		SqlSession  sql = MyBatisUtil.getSqlSession();
		
		MemberVO  vo = null;
		
		try {
			vo = sql.selectOne("member.loginMember", map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sql.commit();
			sql.close();
		}
		// TODO Auto-generated method stub
		return vo;
	}

	@Override
	public List<MemberVO> selectAllMember() { // IMemberService ,public List<MemberVO>selectAllMember();

		SqlSession  sql = MyBatisUtil.getSqlSession();
		
		List<MemberVO>  list = null;
		
		try {
			list = sql.selectOne("member.selectAllMember");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sql.commit();
			sql.close();
		}
		return list;
	}

	@Override
	public String selectById(String id) {

		SqlSession  sql = MyBatisUtil.getSqlSession();
		
		String userId = null;
		
		try {
			userId = sql.selectOne("member.selectById",id);//id파라미터 내용들어간거임 
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sql.commit();
			sql.close();
		}
		return userId;
	}

	@Override
	public int memberJoin(MemberVO vo) {
		SqlSession  sql = MyBatisUtil.getSqlSession();
		
		int res = 0;
	
		try {
			res=   sql.insert("member.memberJoin",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sql.commit(); //insert ,delete에서는 커밋필수 ! 
			sql.close();
		}
	
		return res;
	}	
		
	}









