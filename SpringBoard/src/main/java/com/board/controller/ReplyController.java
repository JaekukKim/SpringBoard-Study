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

	// 댓글 작성하기
	@ResponseBody
	@RequestMapping(value = "/reply/writeReply", method = RequestMethod.POST)
	public void writeReply(ReplyVO replyVO) throws Exception {
		log.info("ReplyController-writeReply 댓글 등록 : {}", replyVO);

		replyService.writeReply(replyVO);
	}
	
	// 댓글 수정하기
	@RequestMapping(value = "/reply/modifyReply", method = RequestMethod.GET)
	public void modifyReply(ReplyVO replyVO) throws Exception{
		log.info("ReplyController-modifyReply 댓글 수정 : {}", replyVO);
		
		replyService.modifyReply(replyVO);
	}
	
	// 단일 댓글 조회하여 가져오기 (수정에 필요)
	@RequestMapping(value="/reply/view", method = RequestMethod.POST)
	public void replySingleQuery (
			ReplyVO replyVO,
			@RequestParam("rno") int rno,
			@RequestParam("bno") int bno,
			Model model
			) throws Exception{
		log.info("ReplyController-replySingleQuery 단일 댓글 조회 : {}", replyVO);
		
		replyVO.setRno(rno);
		replyVO.setBno(bno);
		
		model.addAttribute("replyVO", replyVO);
		
	}
}
