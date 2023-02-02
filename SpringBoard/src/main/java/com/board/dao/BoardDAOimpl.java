package com.board.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	private final static String namespace = "mybatisBoard";
	private final static String replyNamespace = "mybatisReply";
	
	// DB에서 게시글을 불러오는 메소드
	@Override
	public List<BoardVO> list() throws Exception {
		logger.info("게시글 리스트 불러오기 실행.");
		
		return sqlSession.selectList(namespace + ".list");
		// 맨 처음에 namespace + ".list" 했던 부분은 <select id="list" resultType="boardList"> 부분에서 id를 불러온것이다.
	}
	// 게시글 불러오기 및 페이징하는 메소드
	@Override
	public List<BoardVO> pageList(int displayTotalContent, int pageContent) throws Exception {
		// service에서 보내준 값을 여기의 매개변수로 받아야한다.
		
		HashMap <String,Integer> pageData = new HashMap<>();
		pageData.put("displayTotalContent", displayTotalContent);
		pageData.put("pageContent", pageContent);
		
		return sqlSession.selectList(namespace + ".pageList", pageData);
		// 엥 매개변수가 2개인데 어떻게 전달하지 하다가 맵을 생각하였다, setAttribute에서 파생된 생각임.
	}
	
	// 게시글 총 갯수 (페이징에 사용될 계획)
	@Override
	public int totalContent() throws Exception {
		logger.info("게시글 총 갯수 불러오기");
		
		return sqlSession.selectOne(namespace + ".totalContent");
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
		
		return sqlSession.selectOne(namespace + ".view", bno);
	}
	// 게시글 조회시 조회수 1 증가시켜야함, 원래 내용보이기 -> 1증가 였는데 클릭시->1증가로 로직 바꿈
	@Override
	public void increaseViewCount(int bno) throws Exception {
		
		sqlSession.update(namespace + ".increaseViewCount", bno);
	}
	
	// DB에 저장된 데이터를 가져와 조회(수정버튼누름) 한 후 내용을 수정하여 기존 DB에 덮어씌움 (UPDATE)
	@Override
	public void modify(BoardVO boardVO) throws Exception {
		logger.info("게시글 수정 실행");
		
		sqlSession.update(namespace + ".modify", boardVO);
		
	}
	
	// 게시글 삭제하기. (DELETE)
	// 2023-02-02 : 게시글 삭제시 댓글도 같이 삭제가 되어야한다. 댓글 삭제 로직 추가.
	@Override
	public void removeContent(int bno) throws Exception {
		logger.info("게시글 삭제하기 실행");
		
		// 2023-02-02 : 게시글을 삭제하기 "전에!!"
		// 댓글을 먼저 삭제하고 게시글이 삭제 되어야 한다. 인터프리터 언어의 순서를 꼭꼭 지켜야한다.
		sqlSession.delete(replyNamespace + ".removeAllReply", bno);
		
		// 댓글삭제 다했으면 남은 게시글을 지워주자.
		sqlSession.delete(namespace + ".removeContent", bno);
		
	}
	
	

}
