<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.board.domain.BoardVO"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>테스트 리스트 확인</title>

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
	<table border="1">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>내용</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>삭제버튼</th>
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
			 	List<BoardVO> boardList = (List<BoardVO>)request.getAttribute("list");
			 	for(int i = 0; i < boardList.size(); i++){
			 %>
			<tr>
				<td><%=boardList.get(i).getBno() %></td>
				<td><%=boardList.get(i).getTitle() %></td>
				<td><%=boardList.get(i).getContent() %></td>
				<td><%=boardList.get(i).getWriter() %></td>
				<td><%=boardList.get(i).getRegDate() %></td>
				<td><%=boardList.get(i).getViewCnt() %></td>
				<td> <!-- 여기 td부분 delete는 도움받은부분. 나중에 혼자 해볼것 반드시 -->
					<button id="btn_<%=boardList.get(i).getBno() %>" onclick="deleteRecord(<%=boardList.get(i).getBno() %>)">
					<%=boardList.get(i).getBno() %></button>
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
</body>
<script>
/* ajax로 delete 구현은 도움받은부분. 나중에 혼자 해볼것 반드시 */
function deleteRecord(bno){
	$.ajax({
		url : "/board/deleteList",
		type : "POST",
		data : {
			bno : bno
		},
		/* datatype : "JSON", */
		success : function(data) {
			alert("contoller로 삭제 성공");
			location.href = "/board/list";
		},
		error : function() {
			alert("삭제 실패");
		}
	});
	
	//ajax로 bno와 함께 delete에 관한 컨트롤러 호출해서 mybatis로 동적으로 데이터 지우기.
}
</script>
</html>