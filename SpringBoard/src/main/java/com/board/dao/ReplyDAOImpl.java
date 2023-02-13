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
		log.info("ReplyDAOImpl-getReplyList 댓글 리스트 DB접근 : {}", bno);
		
		return sqlSession.selectList(NAME_SPACE + ".getReplyList", bno);
	}
	
	// 댓글 작성하기
	@Override
	public void writeReply(ReplyVO replyVO) throws Exception {
		log.info("ReplyDAOImpl-writeReply 댓글 작성 실행 : {}" , replyVO);
		
		sqlSession.insert(NAME_SPACE + ".writeReply", replyVO);
	}
	
	// 댓글 수정하기
	@Override
	public void modifyReply(ReplyVO replyVO) throws Exception {
		log.info("ReplyDAOImpl-modifyReply 댓글 수정 실행 : {}" , replyVO);
		
		sqlSession.update(NAME_SPACE + ".modifyReply", replyVO);
	}
	
	// 댓글 삭제하기
	@Override
	public void removeReply(ReplyVO replyVO) throws Exception {
		log.info("ReplyDAOImpl-writeReply 댓글 삭제 실행 : {}", replyVO);
		
		sqlSession.delete(NAME_SPACE + ".removeReply", replyVO);
		
		
		
		int a = 0;
		String name = "100";
		
		if (a==1) {
			name = "200";
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}
