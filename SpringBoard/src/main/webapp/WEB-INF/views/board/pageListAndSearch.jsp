<%@page import="com.board.domain.PageIngredient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.board.domain.BoardVO"%>
<%@ page import="com.board.domain.PageIngredient"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, height=device-height ,initial-scale=1">
<!-- 반응형 웹을 만들어주기 위한 메타태그 viewport -->
<title>게시글 페이징</title>

<!-- CSS -->
<link rel="stylesheet" type="text/css" href="/resources/BBS_CSS/boardCSS/pageListAndSearch.css?ver=1">

</head>
<body>
	<!-- 게시판 네비게이션 -->
	<jsp:include page="../nav/menuNav.jsp" flush="false"></jsp:include>

	<div id="boardGroup" align="center">
		<h1>게시글 목록(페이징)</h1>
		<table>
			<thead>
				<tr>
					<th style="width: 80px;">번호</th>
					<th style="width: 300px;">제목</th>
					<th style="width: 150px;">작성자</th>
					<th style="width: 150px;">카테고리</th>
					<th style="width: 150px;">작성일</th>
					<th style="width: 80px;">조회수</th>
				</tr>
			</thead>
			<tbody>
				<!-- jstl -->
				<!-- jstl의 forEach문으로 데이터를 하나하나 불러올수 있는거 잊지말자 ㅇㅇ -->
				<c:forEach items="${list }" var="list">
					<tr>
						<td>${list.bno }</td>
						<td>
							<a href="/board/view?bno=${list.bno }">${list.title }</a>
						</td>
						<td>${list.writer }</td>
						<td>${list.category }</td>
						<td>
							<fmt:formatDate value="${list.regDate}" pattern="yyyy-MM-dd" />
						</td>
						<td>${list.viewCnt }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<!-- 게시글 검색기능 -->
		<%
			PageIngredient pageIngredient = (PageIngredient) request.getAttribute("page");
		%>
		<div>
			<select id="searchType" name="searchType" onchange="resetKeyword();">
				<!--
					option 태그의 는 selected 라는 속성이 존재한다.
					이 속성은 html에서는 디폴트 값을 설정하는데 사용하는게 주력이나
					db에서 넘어온 값에 대해선 특히 더 요긴하게 써먹을 수 있다.
					먼저 컨트롤러에서 넘겨준 searchType를 받아 이것이 option의 value 값과 같다면 그 옵션을 "선택된상태로(selected)"
					만들수 있게 할 수 있다.
				-->
				
				<!-- 
				<option value="searchType's value             selected 여부 (db값과 비교해서)					보여질문구
				 -->
				<option value="title" 			<%= pageIngredient.getSearchType().equals("title") ? "selected" : "" %>>제목</option>		
				<option value="content" 		<%= pageIngredient.getSearchType().equals("content") ? "selected" : "" %>>내용</option>
				<option value="title_and_content" <%= pageIngredient.getSearchType().equals("title_and_content") ? "selected" : "" %>>제목+내용</option>
				<option value="writer" 			<%= pageIngredient.getSearchType().equals("writer") ? "selected" : "" %>>작성자</option>
				<option value="category"		<%= pageIngredient.getSearchType().equals("category") ? "selected" : "" %>>카테고리</option>	
			</select>
			<input type="text" name="keyword" value="<%=pageIngredient.getKeyword()%>" onkeyup="enterSearching();">
			<button id="searchingActivate" type="button" onclick="searchingActivate();">검색</button>
		</div>
		<!-- 게시글 검색기능 끝 -->

		<!-- 페이징 시작 -->
		<%
		int selectedPageNum = (int) request.getAttribute("selectedPageNum");

		/* 이전페이지 버튼만들기 */
		if (pageIngredient.isPrevPage() == true) {
		%>
		<span>
			<a href="/board/pageListAndSearch?pageNum=<%=pageIngredient.getStartPage() - 1%><%=pageIngredient.getSearchTypeAndKeyword()%>">◀이전</a>
		</span>
		<%
		}

		/* 페이지 쫙(1,2,3,4...) 출력하기 */
		for (int i = pageIngredient.getStartPage(); i <= pageIngredient.getEndPage(); i++) {

		if (selectedPageNum != i) {
		%>
		<span>
			<a id="notSelectedPage" href="/board/pageListAndSearch?pageNum=<%=i%><%=pageIngredient.getSearchTypeAndKeyword()%>"><%=i%></a>
		</span>
		<%
		} else if (selectedPageNum == i) {
		%>
		<span>
			<b style="font-size: 22px"><%=i%></b>
		</span>
		<%
		}
		}

		/* 다음버튼 만들기 */
		if (pageIngredient.isNextPage() == true) {
		%>
		<span>
			<a href="/board/pageListAndSearch?pageNum=<%=pageIngredient.getEndPage() + 1%><%=pageIngredient.getSearchTypeAndKeyword()%>">다음▶</a>
		</span>
		<%
		}
		%>
		<!-- 페이징 끝 -->
		<hr />
		<br>
		<span>
			<button class="boardWriteButtonDiv" onclick="location.href='/board/write'">게시글 작성</button>
		</span>
	</div>
</body>
<script type="text/javascript" src="/resources/BBS_JS/pageListAndSearch.js"></script>
</html>