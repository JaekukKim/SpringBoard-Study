package com.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.board.domain.ReplyVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Autowired
	private SqlSession sqlSession;
	
	private static final String NAME_SPACE = "mybatisReply";

	// 댓글 리스트 불러오기
	@Override
	public List<ReplyVO> getReplyList(int bno) throws Exception {
		log.info("ReplyDAOImpl 댓글 리스트 DB접근");
		
		return sqlSession.selectList(NAME_SPACE + ".getReplyList", bno);
	}
}
