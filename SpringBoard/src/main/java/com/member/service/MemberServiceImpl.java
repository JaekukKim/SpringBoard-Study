package com.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.member.dao.MemberDAO;
import com.member.domain.MemberDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDAO memberDAO;
	
	// 회원가입
	@Override
	public void memberSignUp(MemberDTO memberDTO) throws Exception {
		log.info("회원가입 실행 memberSignUp (service)");
		
		memberDAO.memberSignUp(memberDTO);
	}
	
	// 로그인 기능
	@Override
	public MemberDTO memberLogin(MemberDTO memberDTO) throws Exception {
		log.info("로그인 실행 memberLogin(Service)");
		
		return memberDAO.memberLogin(memberDTO);
	}
}
