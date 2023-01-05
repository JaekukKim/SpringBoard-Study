package com.board.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.dao.BoardDAO;
import com.board.domain.BoardVO;

@Service
public class BoardServiceImpl implements BoardService{
	
	private static final Logger logger = LoggerFactory.getLogger(BoardServiceImpl.class);
	
	// autowired 빼먹으면 안됨 ㅡㅡ
	// DAO에 저장되어 있는 데이터를 가져와야하니 DAO 인터페이스를 구현체로 만들어주고 의존성주입(자료형을 참조하여 bean에서 주입)을 해준다.
	@Autowired
	private BoardDAO boardDao;
	
	// 게시글 불러오기 (select)
	@Override
	public List<BoardVO> list() throws Exception {
		logger.info("게시글 불러오기 -> DB접근");
		return boardDao.list();
	}
	
	// 게시글 작성하기 (insert)
	@Override
	public void write(BoardVO boardVO) throws Exception {
		logger.info("게시글 작성 -> DB접근");
		// BoardController(게시글쓰기)에서 입력받은 데이터를 저장하여 boardDao로 데이터를 보냄.
		boardDao.write(boardVO);
	}
	
	// 게시글 조회하기(pk인 bno로 게시글 정보 불러오기, select)
	@Override
	public BoardVO view(int bno) throws Exception {
		logger.info("게시글 조회 -> DB접근");
		
		return boardDao.view(bno);
	}
	
	// 게시글 조회수 증가시키기(pk가 일치하면 viewCnt+1)
	@Override
	public void increaseViewCount(int bno) throws Exception {
		logger.info("게시글 조회수 증가");
		
		boardDao.view(bno);
		
	}
	
	// 게시글 수정하기 (기존 게시글을 수정하기 누른 후 (조회나마찬가지) 수정하여 db로 보냄(update)
	@Override
	public void modify(BoardVO boardVO) throws Exception {
		logger.info("게시글 수정 -> DB접근");
		
		boardDao.modify(boardVO);
	}
	
	// 리턴타입을 어떻게 해야할지 햇갈린다. 일단 지금은 select = 리턴타입이 정해져있음,
	// insert나 update같이 리턴타입이 추상적인 경우 = void 인거 같은데. 생각하는 힘을 기르자.
	
	// 게시글 삭제하기 (pk인 bno를 받아서 삭제한다. 삭제는 리턴값이 컴퓨터 입장에서 모호하다. 그러므로 void로 리턴해준다.
	@Override
	public void removeContent(int bno) throws Exception {
		logger.info("게시글 삭제 실행");
		
		boardDao.removeContent(bno);
	}
}
