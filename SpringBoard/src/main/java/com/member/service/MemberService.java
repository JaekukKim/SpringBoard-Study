package com.member.service;

import com.member.domain.MemberDTO;

public interface MemberService {
	
	// 회원가입
	public void memberSignUp(MemberDTO memberDTO) throws Exception;
}
