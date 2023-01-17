package com.board.domain;

import java.util.Date;

public class ReplyVO {
	/*
	  rno int not null auto_increment, -- 댓글 번호 (pk)
	  bno int not null, -- 댓글은 게시글에 종속되어 있어야 하므로 외래키 설정.
	  content text not null, -- 댓글 내용
	  writer varchar(30) not null, -- 댓글 작성자
	  regDate timestamp not null default now(), -- 댓글 작성날짜
	*/
	
	private int rno;		// 댓글번호 pk
	private int bno;		// 댓글 외래키 (게시글번호 - pk)
	private String content;	// 댓글 내용
	private String writer;	// 댓글 작성자
	private Date regDate;	// 댓글 등록날짜

	public int getRno() {
		return rno;
	}

	public void setRno(int rno) {
		this.rno = rno;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "ReplyVO [rno=" + rno + ", bno=" + bno + ", content=" + content + ", writer=" + writer + ", regDate="
				+ regDate + "]";
	}
	
	
}
