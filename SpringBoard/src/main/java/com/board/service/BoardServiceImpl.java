package com.board.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.dao.BoardDAO;
import com.board.domain.BoardVO;

@Service
public class BoardServiceImpl implements BoardService{
	
	// autowired 빼먹으면 안됨 ㅡㅡ
	// DAO에 저장되어 있는 데이터를 가져와야하니 DAO 인터페이스를 구현체로 만들어주고 의존성주입(자료형을 참조하여 bean에서 주입)을 해준다.
	@Autowired
	private BoardDAO boardDao;
	
	// 게시글 불러오기 (select)
	@Override
	public List<BoardVO> list() throws Exception {
		
		return boardDao.list();
	}
	
	// 게시글 작성하기 (insert)
	@Override
	public void write(BoardVO boardVO) throws Exception {
		
		// BoardController(게시글쓰기)에서 입력받은 데이터를 저장하여 boardDao로 데이터를 보냄.
		boardDao.write(boardVO);
	}
	
	// 도움받은부분 나중에 혼자 해볼것 반드시
//	@Override
//	public List<HashMap> list2() throws Exception {
//		
//		return boardDao.list2();
//	}
	
//	@Override
//	public void deleteList(HashMap map) throws Exception {
//		boardDao.deleteList(map);
//	}
}
