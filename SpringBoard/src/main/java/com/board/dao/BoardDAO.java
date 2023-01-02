package com.board.dao;

import java.util.List;

import com.board.domain.BoardVO;

public interface BoardDAO {
	// 게시글 불러오기 : 게시글 리스트를 불러오는 BoardVO객체를 담는 list 생성
	public List<BoardVO> list() throws Exception;
	
	// 게시글 작성하기 : 게시글 작성한 내용을 BoardVO객체에 담아서(매개변수) 보낸 후 db에 추가해주어야함.
	public void write(BoardVO boardVO) throws Exception;
	
	// 나중에 혼자 해볼것 반드시
//	public List<HashMap> list2() throws Exception;
//	public void deleteList(HashMap map) throws Exception;
}
