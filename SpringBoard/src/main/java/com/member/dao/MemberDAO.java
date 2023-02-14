package com.member.dao;

import com.member.domain.MemberDTO;

public interface MemberDAO {
	
	// 회원가입 로직
	public void memberSignUp(MemberDTO memberDTO) throws Exception;
	
	// 로그인 기능 구현
	public MemberDTO memberLogin(MemberDTO memberDTO) throws Exception;
}
