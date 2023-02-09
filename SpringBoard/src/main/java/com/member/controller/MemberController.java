package com.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.member.domain.MemberDTO;
import com.member.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired(required = false)
	private MemberService memberService;
	
	// 회원 가입 접속페이지.
	@RequestMapping(value = "/member/signUp", method = RequestMethod.GET)
	public String connectSignUp() throws Exception {
		
		return "/member/signUp";
	}
	
	// 회원가입 구현 - 개인정보를 담아 보내는 것이니 POST
	@RequestMapping(value = "/member/memberSignUp", method = RequestMethod.POST)
	public void memberSignUp(MemberDTO memberDTO) throws Exception {
		
	}
}
