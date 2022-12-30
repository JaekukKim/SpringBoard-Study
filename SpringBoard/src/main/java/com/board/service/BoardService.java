package com.board.service;

import java.util.HashMap;
import java.util.List;

import com.board.domain.BoardVO;

public interface BoardService {
	public List<BoardVO> list() throws Exception;
	// 도움받은부분 나중에 혼자 해볼것 반드시
	public List<HashMap> list2() throws Exception;
	public void deleteList(HashMap map) throws Exception;
}
