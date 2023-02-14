package com.member.service;

import com.member.domain.MemberDTO;

public interface MemberService {
	
	// 회원가입
	public void memberSignUp(MemberDTO memberDTO) throws Exception;
	
	// 로그인 구현
	public MemberDTO memberLogin(MemberDTO memberDTO) throws Exception;
}
