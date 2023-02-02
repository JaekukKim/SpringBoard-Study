package com.board.dao;

import java.util.List;

import com.board.domain.ReplyVO;

public interface ReplyDAO {
	
	// 댓글 리스트 불러오기
	public List<ReplyVO> getReplyList(int bno) throws Exception;
	
	// 댓글 작성하기
	public void writeReply(ReplyVO replyVO) throws Exception;
	
	// 댓글 수정하기
	public void modifyReply(ReplyVO replyVO) throws Exception;
	
	// 댓글 삭제하기
	public void removeReply(ReplyVO replyVO) throws Exception;
	
}
