package com.board.service;

import java.util.List;

import com.board.domain.BoardVO;

public interface BoardService {
	// 게시글 리스트를 불러오는 메소드, 이부분은 비즈니스 로직임.
	public List<BoardVO> list() throws Exception;
	
	// 게시글의 데이터 (내용,제목,작성자)를 담아서 보낼 메소드. 마찬가지로 비즈니스 로직.
	public void write(BoardVO boardVO) throws Exception;
	
	// 게시글 조회하기 메소드.
	public BoardVO view(int bno) throws Exception;
	
	// 게시글 조회수 증가 메소드
	public void increaseViewCount(int bno) throws Exception;
	
	// 게시글 수정하기 메소드 (service)
	public void modify(BoardVO boardVO) throws Exception;
	
	// 게시글 삭제 메소드 (service)
	public void removeContent(int bno) throws Exception;
	
}
