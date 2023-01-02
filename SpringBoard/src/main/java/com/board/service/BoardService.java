package com.board.service;

import java.util.List;

import com.board.domain.BoardVO;

public interface BoardService {
	// 게시글 리스트를 불러오는 메소드, 이부분은 비즈니스 로직임.
	public List<BoardVO> list() throws Exception;
	
	// 게시글의 데이터 (내용,제목,작성자)를 담아서 보낼 메소드. 마찬가지로 비즈니스 로직.
	public void write(BoardVO boardVO) throws Exception;
	
	
	
	// 도움받은부분 나중에 혼자 해볼것 반드시
//	public List<HashMap> list2() throws Exception;
//	public void deleteList(HashMap map) throws Exception;
}
