package kr.or.ddit.member.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.member.vo.MemberVO;

public interface IMemberService {
	//로그인
	public MemberVO  loginMember(Map<String, Object> map);
	
	
	//리스트 가져오기
	public List<MemberVO>selectAllMember();

	
	//id중복검사
	public String selectById(String id);//dao도 수정

	
	//가입하기
	public int memberJoin(MemberVO vo);

}
