package com.board.domain;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PageIngredient {
	// BoardController 부분의 페이징이 매우 복잡하다. 그냥 클래스로 하나 만들어서 관리하자.

	private int pageNum; // 현재 페이지 번호
	private int totalContent; // 전체 게시글의 갯수
	private int contentNum; // 출력할 게시글의 갯수
	private int totalPageNum; // 전체 페이지의 수
	private int selectContent; // 페이지당 출력할 게시글의 수
	private int maxPageNum; // 한 화면에 출력되는 페이지의 갯수
	private int startPage; // 한 화면에 출력되는 페이지 중 시작 페이지의 숫자
	private int endPage; // 한 화면에 출력되는 페이지 중 끝 페이지의 숫자
	private boolean prevPage; // 이전페이지 버튼
	private boolean nextPage; // 다음페이지 버튼

	// 생성자를 이용하여 기본값을 설정해준다.
	public PageIngredient() {
		this.contentNum = 10;
		this.maxPageNum = 10;
		this.selectContent = 10;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getTotalContent() {
		return totalContent;
	}

	public void setTotalContent(int totalContent) {
		this.totalContent = totalContent;
		log.info("페이지 관련 객체 호출 및 페이징 시작");

		calculatePage();
	}

	public int getContentNum() {
		return contentNum;
	}

	public void setContentNum(int contentNum) {
		this.contentNum = contentNum;
	}

	public int getTotalPageNum() {
		return totalPageNum;
	}

	public void setTotalPageNum(int totalPageNum) {
		this.totalPageNum = totalPageNum;
	}

	public int getSelectContent() {
		return selectContent;
	}

	public void setSelectContent(int selectContent) {
		this.selectContent = selectContent;
	}

	public int getMaxPageNum() {
		return maxPageNum;
	}

	public void setMaxPageNum(int maxPageNum) {
		this.maxPageNum = maxPageNum;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrevPage() {
		return prevPage;
	}

	public void setPrevPage(boolean prevPage) {
		this.prevPage = prevPage;
	}

	public boolean isNextPage() {
		return nextPage;
	}

	public void setNextPage(boolean nextPage) {
		this.nextPage = nextPage;
	}

	@Override
	public String toString() {
		return "PageIngredient [totalContent=" + totalContent + ", contentNum=" + contentNum + ", totalPageNum="
				+ totalPageNum + ", selectContent=" + selectContent + ", maxPageNum=" + maxPageNum + ", startPage="
				+ startPage + ", endPage=" + endPage + ", prevPage=" + prevPage + ", nextPage=" + nextPage + "]";
	}

	private void calculatePage() {
		// 이제 여기서 컨트롤러에서 했던 로직들을 수행하면된다.
		// 변수명은 일치시켜줬으니 복사붙여넣기 해서 다듬어도될듯?

		// 전체 페이지의 갯수
		totalPageNum = (int) Math.ceil((double) totalContent / contentNum);

		// 출력할 게시물 갯수
		selectContent = (pageNum - 1) * contentNum;

		// 마지막 페이지
		endPage = (int) (Math.ceil((double) pageNum / maxPageNum) * maxPageNum);

		// 실질적인 값을 담고있는 마지막 페이지
		int correctLastPage = (int) (Math.ceil((double) totalContent / maxPageNum));

		// 시작페이지
		startPage = endPage - maxPageNum + 1;

		if (endPage > correctLastPage) {
			endPage = correctLastPage;
		}

		// 이전버튼 : 시작페이지가 10 이상일때.
		if (startPage > maxPageNum) {
			prevPage = true;
		} else {
			prevPage = false;
		}

		// 다음버튼 : 해당 화면의 끝 페이지가 "전체 페이지 수"보다 작으면 활성화
		if (endPage < totalPageNum) {
			nextPage = true;
		} else {
			nextPage = false;
		}

	}

}
