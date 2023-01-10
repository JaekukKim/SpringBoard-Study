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
<title>게시글 목록</title>

<style type="text/css">
thead {
	background-color: yellow;
}

tr {
	text-align: center;
}
</style>
</head>
<body>
<!-- 게시판 네비게이션 -->
<jsp:include page="../nav/menuNav.jsp" flush="false"></jsp:include>


	<div align="center">
		<h1>게시글 목록</h1>
		<table border="1">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>삭제하기</th>
				</tr>
			</thead>
			<tbody>
				<!-- 게시글 리스트 불러올때 변수명 편하게 보세용.
				private int bno; //primary key.
				private String title;
				private String content;
				private String writer;
				private Date regDate;
				private int viewCnt;
			 -->
				<!-- 스크립틀릿 -->
				<%
				List<BoardVO> boardList = (List<BoardVO>) request.getAttribute("list");
				for (int i = 0; i < boardList.size(); i++) {
				%>
				<tr>
					<td><%=boardList.get(i).getBno()%></td>
					<td>
						<a href="/board/view?bno=<%=boardList.get(i).getBno()%>"><%=boardList.get(i).getTitle()%></a>
					</td>
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
				%>
				<!-- jstl -->
				<!-- jstl의 forEach문으로 데이터를 하나하나 불러올수 있는거 잊지말자 ㅇㅇ -->
				<%-- <c:forEach items="${list }" var="list">
				<tr>
					<td>${list.bno }</td>
					<td>${list.title }</td>
					<td>${list.content }</td>
					<td>${list.writer }</td>
					<td>${list.regDate }</td>
					<td>${list.viewCnt }</td>
					<td>
						<button id="btn_${list.bno}" onclick="deleteRecord(${list.bno})">${list.bno}</button>
					</td>
					<!-- 데이터는 list.VO에서 선언한 변수명 으로 빼올수있음 아 물론 list는 키임 -->
				</tr>
			</c:forEach> --%>
			</tbody>
		</table>
		<hr />
		<a href="/board/write">게시글 작성</a>
	</div>
</body>
<script>
	//도움받은 부분은 이미 답이 정해져 있어서 어떻게 처리할까 고민하다가 bno를 받아 컨트롤러에서 redirect 해주는식으로 하였다.
	/* ajax로 delete 구현은 도움받은부분. 나중에 혼자 해볼것 반드시 */
	/* function deleteRecord(bno){
	 $.ajax({
	 url : "/board/deleteList",
	 type : "POST",
	 data : {
	 bno : bno
	 },
	 datatype : "JSON",
	 success : function(data) {
	 alert("contoller로 삭제 성공");
	 location.href = "/board/list";
	 },
	 error : function() {
	 alert("삭제 실패");
	 }
	 });
	 //ajax로 bno와 함께 delete에 관한 컨트롤러 호출해서 mybatis로 동적으로 데이터 지우기.
	 }*/
	//도움받은 부분은 이미 답이 정해져 있어서 어떻게 처리할까 고민하다가 bno를 받아 컨트롤러에서 redirect 해주는식으로 하였다.
</script>
</html>