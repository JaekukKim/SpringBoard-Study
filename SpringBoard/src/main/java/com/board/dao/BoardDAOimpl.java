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
	
	@Override
	public List<BoardVO> list() throws Exception {
		
		return sql.selectList(namespace + ".list");
		// 맨 처음에 namespace + ".list" 했던 부분은 <select id="list" resultType="boardList"> 부분에서 id를 불러온것이다.
		// 근데 namespace에 
	}
	
	// 나중에 혼자 해볼것 반드시
	@Override
	public List<HashMap> list2() throws Exception {
		
		return sql.selectList("mybatisBoard.list2");
	}
	
	@Override
	public void deleteList(HashMap map) throws Exception {
		System.out.println("짠7567567");
		sql.delete("mybatisBoard.list2", map);
		System.out.println("짠345345");
	}
	// 나중에 혼자 해볼것 반드시
}
