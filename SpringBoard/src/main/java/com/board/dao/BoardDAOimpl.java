package com.board.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.board.domain.BoardVO;

// BoardDAO interface를 구현하는 클래스.
@Repository
public class BoardDAOimpl implements BoardDAO{
	
	@Autowired
	private SqlSession sql;
	// mybatis에서 객체를 생성하는 부분은 너무 심층적으로 생각하지말고 사용법만 최대한 알자 아직 자세히 알기엔 시기상조다.
	
	// namespace는 mapper.xml과 동일해야한다. 태그안에 namespace선언한거임.
	private static String namespace = "mybatisBoard";
	
	// DB에서 게시글을 불러오는 메소드
	@Override
	public List<BoardVO> list() throws Exception {
		
		return sql.selectList(namespace + ".list");
		// 맨 처음에 namespace + ".list" 했던 부분은 <select id="list" resultType="boardList"> 부분에서 id를 불러온것이다.
		// 근데 namespace에 
	}
	
	// DB에다가 게시글을 넣는 메소드
	@Override
	public void write(BoardVO boardVO) throws Exception {
		// view에서 입력받은 데이터들은 boardVO로 들어가고 service를 지나 boardDao에 도착했다. 그거를 이제 db로 보내야한다.
		// view - controller - service - dao - model 의 과정을 항상그리자.
		sql.insert(namespace + ".write", boardVO);
	}
	
	// 나중에 혼자 해볼것 반드시
//	@Override
//	public List<HashMap> list2() throws Exception {
//		
//		return sql.selectList("mybatisBoard.list2");
//	}
//	
//	@Override
//	public void deleteList(HashMap map) throws Exception {
//		System.out.println("짠7567567");
//		sql.delete("mybatisBoard.list2", map);
//		System.out.println("짠345345");
//	}

}
