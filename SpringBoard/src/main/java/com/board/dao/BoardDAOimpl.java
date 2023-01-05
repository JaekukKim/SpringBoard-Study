package com.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.board.HomeController;
import com.board.domain.BoardVO;

// BoardDAO interface를 구현하는 클래스.
@Repository
public class BoardDAOimpl implements BoardDAO{
	
	// DB쪽 연결은 logger로 기록을 많이 찍어본다고 한다. 나도 한번 연습해보자.
	private static final Logger logger = LoggerFactory.getLogger(BoardDAOimpl.class);
	
	@Autowired
	private SqlSession sqlSession;
	// mybatis에서 객체를 생성하는 부분은 너무 심층적으로 생각하지말고 사용법만 최대한 알자 아직 자세히 알기엔 시기상조다.
	
	// namespace는 mapper.xml과 동일해야한다. 태그안에 namespace선언한거임.
	private static String namespace = "mybatisBoard";
	
	// DB에서 게시글을 불러오는 메소드
	@Override
	public List<BoardVO> list() throws Exception {
		logger.info("게시글 리스트 불러오기 실행.");
		
		return sqlSession.selectList(namespace + ".list");
		// 맨 처음에 namespace + ".list" 했던 부분은 <select id="list" resultType="boardList"> 부분에서 id를 불러온것이다.
	}
	
	// DB에다가 게시글을 넣는 메소드 (게시글작성)
	@Override
	public void write(BoardVO boardVO) throws Exception {
		// view에서 입력받은 데이터들은 boardVO로 들어가고 service를 지나 boardDao에 도착했다. 그거를 이제 db로 보내야한다.
		// view - controller - service - dao - model 의 과정을 항상그리자.
		
		logger.info("게시글 작성 실행.");
		
		sqlSession.insert(namespace + ".write", boardVO);
	}
	
	// DB에 저장된 데이터중 게시글 번호(bno)를 불러와 [게시글을 조회]한다.
	@Override
	public BoardVO view(int bno) throws Exception {
		// sqlSession 객체에 담긴 쿼리문에 bno를 담아서 리턴시킨다.
		logger.info("게시글 조회(bno값) 실행.");
		
		// 게시글이 조회될 시 조회수도 1 증가시켜주어야 한다.
		sqlSession.update(namespace + ".increaseViewCount", bno);
		
		return sqlSession.selectOne(namespace + ".view", bno);
	}
	
	// DB에 저장된 데이터를 가져와 조회(수정버튼누름) 한 후 내용을 수정하여 기존 DB에 덮어씌움 (UPDATE)
	@Override
	public void modify(BoardVO boardVO) throws Exception {
		logger.info("게시글 수정 실행");
		
		sqlSession.update(namespace + ".modify", boardVO);
		
	}
	
	// 게시글 삭제하기. (DELETE)
	@Override
	public void removeContent(int bno) throws Exception {
		logger.info("게시글 삭제하기 실행");
		
		sqlSession.delete(namespace + ".removeContent", bno);
		
	}

}
