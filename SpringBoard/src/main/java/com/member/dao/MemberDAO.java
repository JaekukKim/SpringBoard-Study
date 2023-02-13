package com.member.dao;

import com.member.domain.MemberDTO;

public interface MemberDAO {
	
	// 회원가입 로직
	public void memberSignUp(MemberDTO memberDTO) throws Exception;
}
