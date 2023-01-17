<%@page import="com.board.domain.PageIngredient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.board.domain.BoardVO"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>게시글 페이징</title>

<style type="text/css">
thead {
	background-color: yellow;
}

tr {
	text-align: center;
}

span {
	margin-right: 10px;
}

#boardTable {
	margin-bottom: 20px;
}

.pageList {
	
}
</style>
</head>
<body>

	<!-- 게시판 네비게이션 -->
	<jsp:include page="../nav/menuNav.jsp" flush="false"></jsp:include>


	<div id="boardGroup" align="center">
		<h1>게시글 목록(페이징)</h1>
		<table id="boardTable" border="1">
			<thead>
				<tr>
					<th style="width: 80px;">번호</th>
					<th style="width: 300px;">제목</th>
					<th style="width: 150px;">작성자</th>
					<th style="width: 150px;">작성일</th>
					<th style="width: 80px;">조회수</th>
				</tr>
			</thead>
			<tbody>
				<!--
				게시글 리스트 불러올때 변수명 편하게 보세용.
				private int bno; //primary key.
				private String title;
				private String content;
				private String writer;
				private Date regDate;
				private int viewCnt;
			 -->
				<!-- jstl -->
				<!-- jstl의 forEach문으로 데이터를 하나하나 불러올수 있는거 잊지말자 ㅇㅇ -->
				<c:forEach items="${list }" var="list">
					<tr>
						<td>${list.bno }</td>
						<td>
							<a href="/board/view?bno=${list.bno }">${list.title }</a>
						</td>
						<td>${list.writer }</td>
						<td>
							<fmt:formatDate value="${list.regDate}" pattern="yyyy-MM-dd" />
						</td>
						<td>${list.viewCnt }</td>

						<%-- <a class="btn btn-sm btn-danger"
						href="javascript:removeMember('${member.id }');">삭제</a> --%>
						<!-- 자바스크립트 함수 안에 매개변수로 id를 넘겨준다. 이때 el식 안에 싱글쿼테이션으로 묶어주어야한다. -->
						<!-- 데이터는 list.VO에서 선언한 변수명 으로 빼올수있음 아 물론 list는 키임 -->
					</tr>
				</c:forEach>

				<!-- 스크립틀릿 -->
				<%--	<%
				List<BoardVO> boardList = (List<BoardVO>) request.getAttribute("list");
				for (int i = 0; i < boardList.size(); i++) {
				
				<tr>
					<td><%=boardList.get(i).getBno()%></td>
					<td>
						<a href="/board/view?bno=<%=boardList.get(i).getBno()%>"><%=boardList.get(i).getTitle()%></a>
					</td>
					<td><%=boardList.get(i).getContent()%></td>
					<td><%=boardList.get(i).getWriter()%></td>
					<td>
						<fmt:formatDate value="<%=boardList.get(i).getRegDate()%>" pattern="yyyy-MM-dd" />
					</td>
					<td><%=boardList.get(i).getViewCnt()%></td>
					<td>
						<!-- 여기 td부분 delete는 도움받은부분. 나중에 혼자 해볼것 반드시 -->
						<a href="/board/remove?bno=<%=boardList.get(i).getBno()%>">
						<!-- 스크립틀릿은 꼭 "" 사이에 넣어주자!! 실수한부분임!! -->
							<button><%=boardList.get(i).getBno()%>번 게시글 삭제하기</button>
						</a>
					</td>
					<!-- 데이터는 list.VO에서 선언한 변수명 으로 빼올수있음 아 물론 list는 키임 -->
				</tr>
				<%
				}
				%> --%>
			</tbody>
		</table>
		<!--
			pageList = boardService.pageList(totalContentPage, eachPageNum);
			model.addAttribute("pageList", pageList);
			model.addAttribute("totalPageNum", totalPageNum);
		-->
		<%--
		무지성으로 일단 페이징이 잘 되었는지 확인만하는 "이전,다음"없는 전체 출력.
		<c:forEach begin="1" end="${totalPageNum }" var="pageNum" >
			<span><a class="pageList" href="/board/pageList?pageNum=${pageNum }">${pageNum }</a></span>
		</c:forEach>
		--%>
		<%
		/*
			model.addAttribute("list",list);
			model.addAttribute("page",page);
		*/
			PageIngredient pageIngredient = (PageIngredient)request.getAttribute("page");
			
			/* 이전페이지 버튼만들기 */
			if(pageIngredient.isPrevPage() == true){ %>
		<span>
			<a href="/board/pageList?pageNum=<%=pageIngredient.getStartPage()-1 %>">◀이전</a>
		</span>
		<%		
			}
			
			/* 페이지 쫙 출력하기 */
			for(int i = pageIngredient.getStartPage(); i <= pageIngredient.getEndPage(); i++){
				/* 주노좌한테 여기 왜 i를 page라고 선언하면 빨간줄에 듀플리케이트 뜨는지 질문하기 */
				/*
					2023-01-13
					page가 듀플이 뜨는 이유는 서블릿 스코프 때문이다. page < request < session < application
					위에 적어논 범위를 나타내는 스코프들은 jsp에서 변수명으로 사용하지 못한다.
					(js의 예약어를 생각하면 이해가 쉽다.)
				*/
		%>
		<span>
			<a href="/board/pageList?pageNum=<%=i%>"><%=i%></a>
		</span>
		<%
			}
			
			/* 다음버튼 만들기 */
			if(pageIngredient.isNextPage()==true){
		%>
		<span>
			<a href="/board/pageList?pageNum=<%=pageIngredient.getEndPage()+1%>">다음▶</a>
		</span>
		<%
			}
		%>
		<hr />
		<br>
		<a href="/board/write">게시글 작성</a>
	</div>
</body>

</html>