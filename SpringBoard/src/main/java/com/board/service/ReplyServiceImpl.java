package com.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.dao.ReplyDAO;
import com.board.domain.ReplyVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	private ReplyDAO replyDAO;
	
	// 댓글 리스트 불러오기
	@Override
	public List<ReplyVO> getReplyList(int bno) throws Exception {
		log.info("ReplyServiceImpl-getReplyList 댓글 리스트 DB요청");
		
		return replyDAO.getReplyList(bno);
	}
	
	// 댓글 작성하기
	@Override
	public void writeReply(ReplyVO replyVO) throws Exception {
		log.info("ReplyServiceImpl-writeReply 댓글 작성 : {}" , replyVO);
		
		replyDAO.writeReply(replyVO);
	}
	
	// 댓글 수정하기
	@Override
	public void modifyReply(ReplyVO replyVO) throws Exception {
		
		replyDAO.modifyReply(replyVO);
	}
	
	// 댓글 삭제하기
	@Override
	public void removeReply(ReplyVO replyVO) throws Exception {
		
		replyDAO.removeReply(replyVO);
	}
}
