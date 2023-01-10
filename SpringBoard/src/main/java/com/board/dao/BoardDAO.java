package com.board.dao;

import java.util.List;

import com.board.domain.BoardVO;

public interface BoardDAO {
	// 게시글 불러오기 : 게시글 리스트를 불러오는 BoardVO객체를 담는 list 생성
	public List<BoardVO> list() throws Exception;
	
	// 게시글 리스트 불러오기 및 게시글 페이징하기
	public List<BoardVO> pageList(int displayTotalContent, int pageContent) throws Exception;
	// 페이징에 있는 매개변수는 limit의 동적쿼리에 들어갈 매개변수이다.
	
	// 게시글 총 갯수
	public int totalContent() throws Exception;
	
	// 게시글 작성하기 : 게시글 작성한 내용을 BoardVO객체에 담아서(매개변수) 보낸 후 db에 추가해주어야함.
	public void write(BoardVO boardVO) throws Exception;
	
	// 게시글 조회하기 : db에서 특정 게시글 (게시글 번호를 따올예정)을 조회해야함. select.
	// 따와야 하는 데이터는 bno 하나이므로 매개변수로 받아내면된다.
	// 리턴되는 타입은 게시글 자체를 리턴해주어야 하기때문에 데이터가 담긴 BoardVO 객체를 리턴시킨다.
	public BoardVO view(int bno) throws Exception;
	
	// 조회시 조회수 증가 메소드
	public void increaseViewCount(int bno) throws Exception;
	
	// 게시글 수정하기
	public void modify(BoardVO boardVO) throws Exception;
	
	// 게시글 삭제하기 (DAO)
	public void removeContent(int bno) throws Exception;
	
	
}
