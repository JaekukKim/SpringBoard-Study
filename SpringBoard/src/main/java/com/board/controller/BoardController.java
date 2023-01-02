package com.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.board.domain.BoardVO;
import com.board.service.BoardService;

@Controller
public class BoardController {
	
	// 만약 넘어온 데이터가 null값이면 안돼니깐 골라서받자
	// null인 경우는 거의 없다. 일시적인 원인모를 예외였음.
	@Autowired
	private BoardService boardService;
	
	// 게시판 메인 화면 페이지
	@RequestMapping(value = "/board/main", method=RequestMethod.GET)
	public String connectBoard() {
		return "/board/boardMain";
	}
	
	// 게시글 리스트 확인
	@RequestMapping(value = "/board/list", method=RequestMethod.GET)
	public void getList(Model model) throws Exception {
		List<BoardVO> list = null;
		list = boardService.list();
		
//		List<HashMap> list2 = null;
//		list2 = boardService.list2();
//		System.out.println(list2+"ㅇㅇㄹㅇㄹ");
		
		model.addAttribute("list", list);
	}
	
	// ----------------------------------게시글 작성 페이지 및 기능-------------------------------------------------------
	// 게시글 작성 페이지
	@RequestMapping(value="/board/write", method = RequestMethod.GET)
	public String writePage() {
		return "/board/write";
	}
	
	// 게시글 작성 기능 구현
	@RequestMapping(value = "/board/write", method = RequestMethod.POST)
	public String writeContent(BoardVO boardVO) {
		// BoardDAO에서 넘어온 데이터를 이제 Controller를 통해서 출력해주어야 한다.
		try {
			boardService.write(boardVO);			
		} catch (Exception e) {
			System.out.println("게시글 작성 실패");
			e.printStackTrace();
		}
		
		return "redirect:/board/list";
		// redirect는 다시 돌려보낸다는 의미이다. 서블릿의 sendRedirect와 같음, 스프링에선 return에 저런식으로 입력가능.
	}
	// ----------------------------------게시글 관련 메소드 끝----------------------------------
	
	
	// 게시글 삭제 기능 구현 // 도움받은부분 나중에 혼자 해볼것 반드시
//	@RequestMapping(value = "/board/deleteList")
//	@ResponseBody
//	public String deleteList(HttpServletRequest request) throws Exception {
//		String bno = request.getParameter("bno");
//		HashMap map = new HashMap();
//		map.put("bno", bno);
//		System.out.println("456짠");
//		boardService.deleteList(map);
//		System.out.println("4356짠");
//		return "test";
//	}
	
}
