package com.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.member.domain.MemberDTO;
import com.member.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	// 회원 가입 접속페이지.
	@RequestMapping(value = "/member/signUp", method = RequestMethod.GET)
	public String connectSignUpPage() throws Exception {
		log.info("회원가입 페이지 접속 (controller - connectSignUpPage)");
		
		return "/member/signUp";
	}
	
	// form태그에 action속성에 보내주는 경로가 없다면 "현재 페이지! (현재 기준 : /member/signUp)으로 전달이 된다.
	// 이말은 뭐다? 하나의 url로 (/member/signUp) get방식으로는 페이지 접속
	// form의 submit로직이 실행될때는 post방식으로 데이터를 보내줄 수 있다는것이다!
	// 단 @RequestMapping 내부의 value가 같고 method가 틀려야한다.
	
	// 회원가입 구현 - 개인정보를 담아 보내는 것이니 POST
	@RequestMapping(value = "/member/signUp", method = RequestMethod.POST)
	public String memberSignUp(MemberDTO memberDTO) throws Exception {
		log.info("회원가입 실행 (controller - memberSignUp)");
		
		memberService.memberSignUp(memberDTO);
		
		return "redirect:/member/login";
	}
	
	// 로그인 페이지 접속
	@RequestMapping(value = "/member/login", method = RequestMethod.GET)
	public void connectLoginPage() throws Exception {
		log.info("로그인 페이지 접속 (controller - connectLoginPage)");
	}
	
	// 로그인 기능 구현. 위의 회원가입과 같은 방식으로 가능하다.
	@RequestMapping(value = "/member/login", method = RequestMethod.POST)
	public String memberLogin(MemberDTO memberDTO) throws Exception {
		log.info("유저 로그인 (controller - memberLogin)");
		
		return "redirect:/board/pageListAndSearch?pageNum=1";
	}
}
