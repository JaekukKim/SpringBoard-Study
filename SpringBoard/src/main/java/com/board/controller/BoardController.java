package com.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.domain.BoardVO;
import com.board.service.BoardService;

@Controller
public class BoardController {
	
	// 만약 넘어온 데이터가 null값이면 안돼니깐 골라서받자
	// 
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value = "/board/list", method=RequestMethod.GET)
	public void getList(Model model) throws Exception {
		List<BoardVO> list = null;
		List<HashMap> list2 = null;
		list = boardService.list();
		list2 = boardService.list2();
//		System.out.println(list2+"ㅇㅇㄹㅇㄹ");
		
		model.addAttribute("list", list);
	}
	
	// 도움받은부분 나중에 혼자 해볼것 반드시
	@RequestMapping(value = "/board/deleteList")
	@ResponseBody
	public String deleteList(HttpServletRequest request) throws Exception {
		String bno = request.getParameter("bno");
		HashMap map = new HashMap();
		map.put("bno", bno);
		System.out.println("456짠");
		boardService.deleteList(map);
		System.out.println("4356짠");
		return "test";
	}
	
	@RequestMapping(value = "/board/write", method = RequestMethod.POST)
	public void writeContent() {
		
	}
}
