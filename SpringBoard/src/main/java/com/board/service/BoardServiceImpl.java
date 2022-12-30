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
	@Autowired
	private BoardDAO boardDao;
	
	@Override
	public List<BoardVO> list() throws Exception {
		
		return boardDao.list();
	}
	
	// 도움받은부분 나중에 혼자 해볼것 반드시
	@Override
	public List<HashMap> list2() throws Exception {
		
		return boardDao.list2();
	}
	
	@Override
	public void deleteList(HashMap map) throws Exception {
		boardDao.deleteList(map);
	}
}
