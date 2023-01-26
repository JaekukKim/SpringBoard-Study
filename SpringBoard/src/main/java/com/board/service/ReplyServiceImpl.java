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
		log.info("ReplyServiceImpl 댓글 리스트 DB요청");
		
		return replyDAO.getReplyList(bno);
	}
}
