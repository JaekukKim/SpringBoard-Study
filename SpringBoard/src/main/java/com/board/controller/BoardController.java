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
	@RequestMapping(value = "/board/main", method = RequestMethod.GET)
	public String connectBoard() {
		logger.info("게시판 접속");
		return "/board/boardMain";
	}

	// ---------------------------------------게시글 리스트 가져오기 및 페이징---------------------------------------------------
	@RequestMapping(value = "/board/list", method = RequestMethod.GET)
	public void getList(Model model) throws Exception {
		List<BoardVO> list = null;
		list = boardService.list();
		logger.info("게시글 리스트 불러오기 실행");

		model.addAttribute("list", list);
	}

	// 게시글 페이징 기능 구현 : 매우 어렵다곤 하는데... 어려운거 맞는듯 생각조차 안남.
	// 일단 게시글 리스트 불러오는거랑 연관이 있는건 바로 알 수 있다.
	@RequestMapping(value = "/board/pageList", method = RequestMethod.GET)
	public void pageList(@RequestParam("pageNum") int pageNum, Model model) throws Exception {
		
		// 게시글 총 갯수
		int totalContent = boardService.totalContent();
		
		// 페이지별 출력될 게시글의 갯수
		int contentNum = 10;
		
		// 전체 페이지의 갯수
		int totalPageNum = (int)Math.ceil((double)totalContent/contentNum);
		
		// 출력할 게시물 갯수
		int selectContent = (pageNum-1) * contentNum;
		
		
		
		// 전체 페이지의 수는 위에서 구했으니 한 화면당 출력될 페이지의 갯수를 정해서 접근하면 된다.
		int maxPageNum = 10;
		
		// 마지막 페이지는 pageNum을 이용하여 10의 단위로 만들어주면 된다.
		// pageNum을 10으로 나누어 "몫"을 구한다음 나온 실수를 올림처리 해버린뒤 10을 곱하면 된다
		int endPage = (int)(Math.ceil((double)pageNum/maxPageNum) * maxPageNum);
		
		// (2023-01-16) 마지막 페이지 출력부의 치명적이진 않지만 결함이 발견되어 수정을 해주어야 한다.
		// 게시글이 1024개이면 총 페이지는 103페이지이며 91~100 / 101~103으로 화면에 나와야하는데
		// 91~100 / 94 ~ 103으로 10개를 너무 철저하게 잘 지켜서 나온다. 이 부분은 클라이언트의 가독성을 위해 수정이 필요하다.
		// [1] endPage가 totalPageNum보다 크다면 덮어씌워주었는데 잘 생각해보니 동작하지 않는 노는코드였다.
		// [2] totalPageNum은 그냥 전체 페이지 갯수만으로 바라봐야한다. 새로운 변수를 하나 더 만들어야 한다.
		// 전체 게시글 총 갯수를 전체 페이지 갯수로 나누어서 접근을 해야한다. 우리가 전에 사용했던 전체 페이지의 코드는
		// "게시글갯수"에 묶어있는 전체페이지였을 뿐이다!!
		int correctLastPage = (int)(Math.ceil((double)totalContent/maxPageNum));
		
		/*
			2023-01-16 위에 적었던 주석에 이어서 - 94~103의 페이지가 출력되는 이유는 선언부가 달라서였다.
			startPage는 먼저 순수한 endPage(10단위로 끊어지는)를 받고 난 뒤 가야 1, 11, 21 ... 순으로 1의자리가 1로 끊어지게 된다.
			하지만 나는 아래 if문 아래 startPage를 선언해주어 제~일 마지막(다음버튼없는)
			페이지가 너무 정직하게 출력되는 대참사가 발생해버렸다. 
		*/
		
		// 시작페이지는 endPage에서 9를 빼주면?? 시작페이지다.
		int startPage = endPage - maxPageNum + 1;
		  
		if (endPage > correctLastPage) {
			endPage = correctLastPage;
		}
		
		// 이전버튼 : 시작페이지가 10 이상일때.
		boolean prevPage;
		if (startPage > maxPageNum) {
			prevPage = true;
		} else {
			prevPage = false;
		}
		
		// 다음버튼 : 해당 화면의 끝 페이지가 "전체 페이지 수"보다 작으면 활성화
		boolean nextPage;
		if (endPage < totalPageNum) {
			nextPage = true;
		} else {
			nextPage = false;
		}
		
		List<BoardVO> list = null;
		list = boardService.pageList(selectContent, contentNum);
		model.addAttribute("list",list);
		model.addAttribute("totalPageNum",totalPageNum);
		// 한 화면에 출력되는 시작페이지 숫자, 끝페이지 숫자
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		// 이전,다음버튼
		model.addAttribute("prevPage", prevPage);
		model.addAttribute("nextPage", nextPage);
	}
	// ---------------------------------------게시글 리스트 가져오기 및페이징끝---------------------------------------------------

	// ----------------------------------게시글 작성 및 작성하기 기능-------------------------------------------------------
	// 게시글 작성 페이지
	@RequestMapping(value = "/board/write", method = RequestMethod.GET)
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
	// ----------------------------------게시글 리스트 관련 메소드끝----------------------------------

	// 게시글 조회하기 및 조회수 증가.
	@RequestMapping(value = "/board/view", method = RequestMethod.GET)
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

	// 게시글 수정하기 : 기존 게시글 조회(의 개념으로 수정페이지 들어가기)
	// ---------------------------------------------------------------------
	// String 게시글 = "내용123";
	@RequestMapping(value = "/board/modify", method = RequestMethod.GET)
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
	@RequestMapping(value = "/board/modify", method = RequestMethod.POST)
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
	// ------------------------게시글 수정 컨트롤러 2개 끝----------------------------------

	// 게시글 삭제기능 pk인 bno를 받아 삭제할 예정.
	@RequestMapping(value = "/board/remove", method = RequestMethod.GET)
	public String removeContent(@RequestParam("bno") int bno) throws Exception {
		logger.info("게시글 삭제 실행");

		boardService.removeContent(bno);

		return "redirect:/board/pageList?pageNum=1";
		// redirect는 서버를 2번 호출한다.
		// View → Interceptor → Controller(내부에 redirect 실행) → View → Interceptor →
		// Controller(redirect 링크 호출)
	}

}
