package com.board.service;

import java.util.List;

import com.board.domain.ReplyVO;

public interface ReplyService {
	
	// 댓글 리스트 불러오기
	public List<ReplyVO> getReplyList(int bno) throws Exception;
}
