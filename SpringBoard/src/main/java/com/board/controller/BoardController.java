package com.board.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.board.domain.BoardVO;
import com.board.service.BoardService;

@Controller
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	// 만약 넘어온 데이터가 null값이면 안돼니깐 골라서받자
	// null인 경우는 거의 없다. 일시적인 원인모를 예외였음.
	@Autowired
	private BoardService boardService;
	
	// 게시판 메인 화면 페이지
	@RequestMapping(value = "/board/main", method=RequestMethod.GET)
	public String connectBoard() {
		logger.info("게시판 접속");
		return "/board/boardMain";
	}
	
	// 게시글 리스트 확인
	@RequestMapping(value = "/board/list", method=RequestMethod.GET)
	public void getList(Model model) throws Exception {
		List<BoardVO> list = null;
		list = boardService.list();
		logger.info("게시글 리스트 불러오기 실행");
		
		model.addAttribute("list", list);
	}
	
	// ----------------------------------게시글 작성 페이지 및 기능-------------------------------------------------------
	// 게시글 작성 페이지
	@RequestMapping(value="/board/write", method = RequestMethod.GET)
	public String writePage() {
		logger.info("게시글 작성페이지 실행");
		return "/board/write";
	}
	
	// 게시글 작성 기능 구현
	@RequestMapping(value = "/board/write", method = RequestMethod.POST)
	public String writeContent(BoardVO boardVO) {
		// BoardDAO에서 넘어온 데이터를 이제 Controller를 통해서 출력해주어야 한다.
		try {
			boardService.write(boardVO);
			logger.info("게시글 작성 완료");
		} catch (Exception e) {
			logger.info("게시글 작성 실패");
			e.printStackTrace();
		}
		
		return "redirect:/board/list";
		// redirect는 다시 돌려보낸다는 의미이다. 서블릿의 sendRedirect와 같음, 스프링에선 return에 저런식으로 입력가능.
	}
	// ----------------------------------게시글 리스트 관련 메소드 끝----------------------------------
	
	// 게시글 조회하기 및 조회수 증가.
	@RequestMapping(value="/board/view", method = RequestMethod.GET)
	public void viewContent(@RequestParam("bno") int bno, BoardVO boardVO, Model model) {
		// 게시글을 조회하기 위해 bno를 따와서 조회하는 방법을 사용하였다.
		// 게시글을 조회할라면 bno는 기본적으로 값으로 받아야하고 (@RequestParam("bno") : /board?bno=?
		// boardVO 객체의 데이터를 받아와야한다음 다시 view에 출력해주어야 한다.
		try {
			boardVO = boardService.view(bno);
			// 위의 view 메소드에는 조회수가 증가하는 로직도 포함되어있다. 즉, 하나의 DAO로직이 2가지 일을 하는 셈이다.
			model.addAttribute("view", boardVO);
			logger.info("게시글 조회하기 성공, 조회수 ++");
			
		} catch (Exception e) {
			logger.error("게시글 조회 실패");
		}
	}
	
	
	// 게시글 수정하기 : 기존 게시글 조회(의 개념으로 수정페이지 들어가기) ---------------------------------------------------------------------
	// String 게시글 = "내용123";
	@RequestMapping(value ="/board/modify", method = RequestMethod.GET)
	public void getContent(@RequestParam("bno") int bno, BoardVO boardVO, Model model) {
		// 수정하는건 게시글 작성 + 조회이며 거기에 쿼리문만 기존걸 대체하는 update로 바꿔주면 된다.
		// 그러면?? 수정하기 버튼을 눌렀을때 조회하는거같이 보여주는 컨트롤러랑 쿼리문을 방출하는 컨트롤러 가지가 필요하다.
		// 게시글 수정하기를 누르면 기존 데이터를 전부 가져와서 보여주어야 한다. 조회하기랑 똑같다..?
		try {
			boardVO = boardService.view(bno);
			model.addAttribute("view", boardVO);
		} catch (Exception e) {
			System.out.println("게시글 수정 실패");
			e.printStackTrace();
		}
	}
	
	// 게시글 수정하기 : 기존 게시글 수정
	// 게시글 = "내용 456";
	@RequestMapping(value="/board/modify", method = RequestMethod.POST)
	public String setContent(BoardVO boardVO) {
		try {
			boardService.modify(boardVO);
		} catch (Exception e) {
			System.out.println("게시글 수정 실패");
			e.printStackTrace();
		}
		
		return "redirect:/board/view?bno=" + boardVO.getBno();
		// 수정에 성공하면 수정된 게시글로 넘긴다.
	}
	//------------------------게시글 수정 컨트롤러 2개 끝----------------------------------
	
	// 게시글 삭제기능 pk인 bno를 받아 삭제할 예정.
	@RequestMapping(value="/board/remove", method = RequestMethod.GET)
	public String removeContent(@RequestParam("bno") int bno) throws Exception{
		logger.info("게시글 삭제 실행");
		
		boardService.removeContent(bno);
		
		return "redirect:/board/list";
		// redirect는 서버를 2번 호출한다.
		// View → Interceptor → Controller(내부에 redirect 실행) → View → Interceptor → Controller(redirect 링크 호출)
	}
}
