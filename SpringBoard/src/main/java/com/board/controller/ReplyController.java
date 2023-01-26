package com.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	@RequestMapping(value = "/reply/replyList", method=RequestMethod.GET)
	public void getReplyList(ReplyVO replyVO, Model model) throws Exception{
		log.info("ReplyController 댓글 리스트 가져오기 시작.");

		
		
	}
}
