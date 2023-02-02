package com.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.domain.ReplyVO;
import com.board.service.ReplyService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
// @RequestMapping("/reply/*") <= mapping 명시방법, 컨트롤러 내부에 기술할 예시.
public class ReplyController {

	@Autowired
	private ReplyService replyService;

	// 댓글 리스트 불러오기.
	@RequestMapping(value = "/reply/replyList", method = RequestMethod.GET)
	public void getReplyList(ReplyVO replyVO, Model model) throws Exception {
		log.info("ReplyController-getReplyList 댓글 리스트 가져오기 시작.");

	}

	// 댓글 작성하기 (ajax)
	@ResponseBody
	@RequestMapping(value = "/reply/writeReply", method = RequestMethod.POST)
	public void writeReply(ReplyVO replyVO) throws Exception {
		log.info("ReplyController-writeReply 댓글 등록 : {}", replyVO);

		replyService.writeReply(replyVO);
	}
	
	// 댓글 수정하기 (ajax)
	@ResponseBody
	@RequestMapping(value = "/reply/modifyReply", method = RequestMethod.POST)
	public void modifyReply(ReplyVO replyVO) throws Exception{
		log.info("ReplyController-modifyReply 댓글 수정 : {}", replyVO);
		
		replyService.modifyReply(replyVO);
	}
	
	// 댓글 삭제하기 (ajax)
	@ResponseBody
	@RequestMapping(value = "/reply/removeReply", method = RequestMethod.POST)
	public void removeReply(ReplyVO replyVO) throws Exception{
		log.info("ReplyController-removeReply 댓글 삭제 : {}", replyVO);
		
		replyService.removeReply(replyVO);
	}
	
}
