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
import com.board.domain.PageIngredient;
import com.board.domain.ReplyVO;
import com.board.service.BoardService;
import com.board.service.ReplyService;

@Controller
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	// 만약 넘어온 데이터가 null값이면 안돼니깐 골라서받자
	// null인 경우는 거의 없다. 일시적인 원인모를 예외였음.

	@Autowired
	private BoardService boardService;

	// 댓글 기능을 위한 DI
	@Autowired
	private ReplyService replyService;

	// 게시판 메인 화면 페이지
	@RequestMapping(value = "/board/boardMain", method = RequestMethod.GET)
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
	public void pageList(@RequestParam("pageNum") int pageNum, Model model, PageIngredient page) throws Exception {

		// 현재 페이지를 받아오기
		page.setPageNum(pageNum);

		// 게시글 총 갯수를 구하면 PageIngredient의 로직에서 전부 계산을 해준다.
		page.setTotalContent(boardService.totalContent());

		List<BoardVO> list = null;
		list = boardService.pageList(page.getSelectContent(), page.getContentNum());
		model.addAttribute("list", list);
		model.addAttribute("page", page);

		// 현재 페이지가 몇페이지인지 쉽게 구분하기위한 구분자를 넘겨주자
		model.addAttribute("selectedPageNum", pageNum);
	}

	// 페이징 + 검색기능의 페이지
	@RequestMapping(value = "/board/pageListAndSearch", method = RequestMethod.GET)
	public void pageListAndSearch(@RequestParam("pageNum") int pageNum,
			@RequestParam(value = "searchType", required = false, defaultValue = "title") String searchType,
			// searchType : html의 select에서 선택한 option tag의 값
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			// keyword : html의 검색쪽 input tag에서 기입한 text의 값
			PageIngredient page, Model model) throws Exception {

		logger.info("페이징 + 검색기능 시작 (Controller)\n검색타입 : {}\n검색어 : {}" , searchType , keyword);

		/*
		 * ** 중요함 **
		 * 
		 * @RequestMapping의 method는 get방식이다. 그럼 url에 쿼리파라미터 형식으로 @RequestParam의 매개변수가 들어올텐데
		 * @RequestParam의 required, 즉 값을 요구하는 방식은 기본적으로 true (반드시 요구함)이다.
		 * searchType과 keyword의 경우엔 "검색"을 할 경우에만 필요하다.
		 * 근데 required가 true라면?? 요구하는 매개변수가 주어지지 않아 사이트 접속 자체가 안될것이다. 요구하는 값이 없기때문에!
		 * 그러므로 우리는 @RequestParam의 required를 false(선택적요구)로, defaultValue를 따로 설정(가급적 포괄적으로)해주어야 한다.
		 */
		
		page.setPageNum(pageNum);
		
		// searchType , keyword , searchTypeAndKeyword는 맨 처음 값을 보내주는것이 아니다!
		// 검색이 시작되고 나면 사용자가 입력한 값을 가지고 검색 및 페이징을 해주는 역할로 보내지는 것이다!
		page.setSearchType(searchType);
		page.setKeyword(keyword);
		page.setSearchTypeAndKeyword(searchType, keyword);
		
		// 게시글 총 갯수를 구한다. 단 검색타입과 키워드에 맞춘 결과에 대한 총 갯수를 출력해야한다.
		page.setTotalContent(boardService.totalSearchContent(searchType, keyword));

		List<BoardVO> list = null;
		list = boardService.pageListAndSearch(page.getSelectContent(), page.getContentNum(), searchType, keyword);
		model.addAttribute("list", list);
		model.addAttribute("page", page);

		// 현재 페이지가 몇페이지인지 쉽게 구분하기위한 구분자를 넘겨주자
		model.addAttribute("selectedPageNum", pageNum);
	}
	// ---------------------------------------게시글 리스트 가져오기 및 페이징끝---------------------------------------------------

	// ----------------------------------게시글 작성 및 작성하기 기능-------------------------------------------------------
	// 게시글 작성 페이지
	@RequestMapping(value = "/board/write", method = RequestMethod.GET)
	public String writePage() {
		logger.info("게시글 작성페이지 실행");
		return "/board/write";
	}

	// 게시글 작성 기능 구현
	@RequestMapping(value = "/board/write", method = RequestMethod.POST)
	public String writeContent(BoardVO boardVO) throws Exception{
		// BoardDAO에서 넘어온 데이터를 이제 Controller를 통해서 출력해주어야 한다.
			logger.info("게시글 작성 writeContent (controller)");
			
			boardService.write(boardVO);
		
		return "redirect:/board/pageListAndSearch?pageNum=1";
		// redirect는 다시 돌려보낸다는 의미이다. 서블릿의 sendRedirect와 같음, 스프링에선 return에 저런식으로 입력가능.
	}
	// ----------------------------------게시글 리스트 관련 메소드끝----------------------------------

	// 게시글 조회하기 및 조회수 증가.
	@RequestMapping(value = "/board/view", method = RequestMethod.GET)
	public void viewContent(@RequestParam("bno") int bno, BoardVO boardVO, ReplyVO replyVO, Model model) {
		// 게시글을 조회하기 위해 bno를 따와서 조회하는 방법을 사용하였다.
		// 게시글을 조회할라면 bno는 기본적으로 값으로 받아야하고
		// (@RequestParam("bno") : /board?bno=?
		// boardVO 객체의 데이터를 받아와야한다음 다시 view에 출력해주어야 한다.
		
		try {
			
			boardVO = boardService.view(bno);
			// 위의 view 메소드에는 조회수가 증가하는 로직도 포함되어있다. 즉, 하나의
			// DAO로직이 2가지 일을 하는 셈이다.

			model.addAttribute("view", boardVO);

			logger.info("게시글 조회하기 성공, 조회수 ++");

			// ****게시글 조회와 동시에 댓글 리스트 불러오기.
			List<ReplyVO> replyList = null;
			replyList = replyService.getReplyList(bno);

			// 댓글이 없을 시 안내문구 출력하는 과정
			boolean noticeMsg = false;
			if (replyVO.getContent() == "" || replyVO.getContent() == null) {
				noticeMsg = true;
			}

			model.addAttribute("replyList", replyList);
			model.addAttribute("noticeMsg", noticeMsg);

		} catch (Exception e) {
			logger.error("게시글 조회 실패 : {}", e);
		}
	}

	// 게시글 수정하기 : 기존 게시글 조회(의 개념으로 수정페이지 들어가기)
	@RequestMapping(value = "/board/modify", method = RequestMethod.GET)
	public void getContent(@RequestParam("bno") int bno, BoardVO boardVO, Model model) {
		// 수정하는건 게시글 작성 + 조회이며 거기에 쿼리문만 기존걸 대체하는 update로
		// 바꿔주면 된다.
		// 그러면?? 수정하기 버튼을 눌렀을때 조회하는거같이 보여주는 컨트롤러랑 쿼리문을
		// 방출하는 컨트롤러 가지가 필요하다.
		// 게시글 수정하기를 누르면 기존 데이터를 전부 가져와서 보여주어야 한다. 조회하기랑
		// 똑같다..?
		try {
			boardVO = boardService.view(bno);
			model.addAttribute("view", boardVO);
		} catch (Exception e) {
			System.out.println("게시글 수정 실패");
			e.printStackTrace();
		}
	}

	// 게시글 수정하기 : 기존 게시글 수정
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
	// 2023-02-02 : 게시글 삭제시 댓글도 같이 삭제가 되어야한다. 댓글 삭제 로직 추가.
	@RequestMapping(value = "/board/remove", method = RequestMethod.GET)
	public String removeContent(@RequestParam("bno") int bno) throws Exception {
		logger.info("게시글 삭제 실행");

		boardService.removeContent(bno);

		return "redirect:/board/pageList?pageNum=1";
		// redirect는 서버를 2번 호출한다.
		// View → Interceptor → Controller(내부에 redirect 실행) → View → Interceptor → Controller(redirect 링크 호출)
	}

}
