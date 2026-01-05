package kr.or.ddit.member.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.member.vo.MemberVO;

public interface IMemberDao {
	
	
	public MemberVO  loginMember(Map<String, Object> map);
	
	public List<MemberVO>selectAllMember();
	
	public String selectById(String id);
	
	public int memberJoin(MemberVO vo);

}
