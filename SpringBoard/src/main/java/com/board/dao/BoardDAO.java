package com.board.dao;

import java.util.HashMap;
import java.util.List;

import com.board.domain.BoardVO;

public interface BoardDAO {
	// BoardVO 객체를 담는 List 생성.
	public List<BoardVO> list() throws Exception;
	
	// 나중에 혼자 해볼것 반드시
	public List<HashMap> list2() throws Exception;
	public void deleteList(HashMap map) throws Exception;
}
