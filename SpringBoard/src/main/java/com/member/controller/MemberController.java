package com.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

		return "redirect:/member/loginpage";
	}

	// 로그인 페이지 접속
	@RequestMapping(value = "/member/loginpage", method = RequestMethod.GET)
	public String connectLoginPage() throws Exception {
		log.info("로그인 페이지 접속 (controller - connectLoginPage)");

		return "/member/login";
	}

	// 로그인 기능 구현. 위의 회원가입과 같은 방식으로 가능하다.
	@RequestMapping(value = "/member/login", method = RequestMethod.POST)
	public String memberLogin(MemberDTO memberDTO, HttpServletRequest req, RedirectAttributes reat) throws Exception {
		log.info("유저 로그인 (controller - memberLogin)\n로그인 정보 : {}", memberDTO);

		/*
		 * 1. 로그인을 함 : memberDTO (파라미터) 에 로그인 정보가 담김.
		 * 2. memberDTO 객체의 정보를 DB에 저장되어 있는 회원정보와 비교를함. (memberDTO를 service-DAO로 보냄) 
		 * 3. 비교 후 정보가 존재하면 session ID 발급, 아니라면 회원 정보가 존재하지 않음을 명시. (setAttribute)
		 */

		MemberDTO memberInfo = memberService.memberLogin(memberDTO);

		HttpSession session = req.getSession();

		/*
		 * 1. 현재 로그인이 실패할시 아무런 메세지나 상태가 출력되지 않는다. 이러면 로그인이 실패한지도 모를것이다. 
		 * 2. 이럴경우 메세지나 상태를 보내주어야 하는데 보내준 상태는 사실상 1회성 데이터이므로 (로그인 실패 여부만 확인하면 됨)
		 * 		RedirectAttributes의 flashAttribute 메소드를 사용하였다.
		 * 
		 * 		문제점 발견) 근데 addFlashAttribute 메소드를 사용할경우 1회성 데이터로 session에 담긴다는데 스크립틀릿으로
		 * 					session.getAttribute로 데이터가 안뽑아와진다. => 일단 jstl-el 로 해결.
		 */
		if (memberInfo == null) {
			session.setAttribute("isLogon", null);
			reat.addFlashAttribute("memberLogin", false);

			return "redirect:/member/loginpage";

		} else {
			session.setAttribute("memberInfo", memberInfo);
		}

		return "redirect:/board/boardMain";
	}

	// 로그아웃 - 로그아웃은 세션아이디만 박탈시키면 된다. service - dao 로직이 필요 없음.
	@RequestMapping(value = "/member/logout", method = RequestMethod.GET)
	public String methodName(HttpSession session) throws Exception {
		log.info("유저 로그아웃 실행\n로그아웃 계정 : {}", session.getAttribute("memberInfo"));

		session.invalidate();

		return "redirect:/board/boardMain";
	}

	// 회원 정보 수정 페이지 입장
	@RequestMapping(value = "/member/membermodify", method = RequestMethod.GET)
	public String connectMemberModify() throws Exception {
		log.info("회원 정보 수정 페이지 입장");

		return "/member/membermodify";
	}

	// 회원 정보 수정 로직 구현
	@RequestMapping(value = "/member/modify", method = RequestMethod.POST)
	public String modifyMember(MemberDTO memberDTO) throws Exception {
		/*
		 * 회원 정보 수정은 기본적으로 session ID를 갖고 있는 상태여야 접속이 가능하다.
		 * 그러므로 session ID 기준으로 member의 정보를 가져다와 양식에 채워진 상태로 보여지게 만들고
		 * 그 뒤 수정이 가능하게 하면 된다.
		 */
		log.info("회원 정보 수정 modifyMember (controller)");

		return "redirect:/board/boardMain";
	}

}
