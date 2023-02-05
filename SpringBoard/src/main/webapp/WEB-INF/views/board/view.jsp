<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.board.domain.ReplyVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, height=device-height ,initial-scale=1">
<!-- 반응형 웹을 만들어주기 위한 메타태그 viewport -->
<title>${view.bno }번게시글조회</title>

<!-- 간단 css (생각보다 길어져서 파일로..)-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/BBS_CSS/boardCSS/viewCSS.css?ver=1">

<!--
	하나 또 배웠다.
	css 경로 인식이 안돼어 검색을 해보니 servlet-context에 적혀있는 경로의 형식을 지켜서 파일을 넣어줘야 했다.
	따봉
-->

</head>
<body>
	<!-- 게시글에 대한 정보는 데이터기도 하며 get은 글자수의 제한이 있으니 get보단 post로 전달해주어야 한다 -->
	<!--
		private String title;
		private String content;
		private String writer;
	 -->
	<!--
	 	form 태그 안에 있는 name속성의 값은 db의 컬럼명 (VO의 변수명)과 일치시켜주는게 편하다.
	 	게시글의 정보를 입력받아 BoardVO객체에 넣어서 전송시켜주는데, 이때 변수명과 name속성명이 동일하다면 추가작업을 해주는 과정을
	 	생략할 수 있어 작업이 매우 편해진다.
	 	그렇지 않다면 String id=getAttribute("name속성 명")이런식으로 데이터를 받아서 jdbc마냥 추가시켜주어야 한다.
	  -->
	<!-- 게시판 네비게이션 -->
	<jsp:include page="../nav/menuNav.jsp" flush="false"></jsp:include>

	<div id="boardTB">
		<h1>${view.bno }번게시글</h1>
		<form method="post">
			<label>조회수 : </label>
			<span class="boardElement">${view.viewCnt }</span>
			<hr>
			<br>
			<label>게시글 제목 : </label>
			<span class="boardElementTitle">${view.title }</span>
			<hr>
			<br>
			<label>작성자 : </label>
			<span class="boardElement">${view.writer }</span>
			<hr>
			<br>
			<label>내용</label>
			<br>
			<textarea rows="5" cols="50" class="boardElement" name="content" maxlength="2000" readonly="readonly">${view.content}</textarea>
			<br>
			<!-- 
				**매우중요!!!
				-- jsp페이지에서 <button> 태그를 만들어 버튼을 누를 때 동작을 처리하여 서버와 연결하였는데
				button 태그에 type을 지정해주지 않아 버튼만 누르면 무조건 controller로 넘어가고 있는 것이었다..!
				(button의 type을 지정해주지 않으면 기본 type은 ***submit이 되기 때문에*** 주의해야한다. )
			 -->
		</form>
		<div align="right">
			<a href="/board/modify?bno=${view.bno }">
				<button type="button" class="boardUpdate">게시글 수정하기</button>
			</a>
			<a onclick="javascript:removeContent('${view.bno}');">
				<button type="button" class="boardUpdate">게시글삭제</button>
			</a>
		</div>
		<hr>
		<!-- 댓글 구현하기 -->
		<h2>댓글</h2>
		<div align="center">
			<table>
				<thead>
					<tr align="center">
						<th style="display: none;">댓글 번호</th>
						<th style="width: 250px;">작성자</th>
						<th style="width: 600px;">내용</th>
						<th style="width: 100px;">수정/삭제</th>
					</tr>
				</thead>
				<tbody>
					<!-- model.addAttribute("replyList" , replyList); -->
					<%
					/*
					private String content;	// 댓글 내용
					private String writer;	// 댓글 작성자
					private Date regDate;	// 댓글 등록날짜
					*/

					List<ReplyVO> replyList = (List<ReplyVO>) request.getAttribute("replyList");
					boolean noticeMsg = (boolean)request.getAttribute("noticeMsg");
					
					for (int replyNum = 0; replyNum < replyList.size(); replyNum++) {
						
					%>
					<tr class="replyVO">
						<td class="replyRno" style="display: none;"><%=replyList.get(replyNum).getRno()%></td>
						<td id="replyBno" class="replyBno" style="display: none;"><%=replyList.get(replyNum).getBno()%></td>
						<td>
							<div class="replyWriter" style="margin-left: 20px;"><%=replyList.get(replyNum).getWriter()%></div>
							<div>
								<div class="replyRegDate" align="right" style="margin-right: 20px;">
									<font size="2" color="gray"> <fmt:formatDate value="<%=replyList.get(replyNum).getRegDate()%>" pattern="yyyy-MM-dd" />
									</font>
								</div>
							</div>
						</td>
					
						<td id="replyContent" class="replyContent"><%=replyList.get(replyNum).getContent()%></td>
					
						<td style="padding-right: 5px;" align="center">
							<font size="2"><button class="replyModifyBtn" type="button">[수정]</button></font>
							<br>
							<font size="2">
								<button class="replyDeleteBtn" type="button" 
								onclick="removeReply('<%=replyList.get(replyNum).getRno()%>','<%=replyList.get(replyNum).getBno()%>');">[삭제]</button>
							</font>
						</td>
					</tr>
					<%
					
					}
					%>
				</tbody>
			</table>
		</div>

		<!-- 댓글 수정 모달창 : #modal -->
		<div id="modal" class="modal_overlay">
			<!-- 댓글의 내용을 입력하는 클래스 : .modal_content -->
			<div class="modal_content">
				<button type="button" class="close-button" onclick="modalClose();">X</button>
				<!-- modal_window -->
				<div class="replyTitle">
					<h2>댓글 수정</h2>
				</div>
				<br>
				<div class="replyContent">
					<div style="margin-right: 20px;" align="left">
						<!-- 댓글번호 -->
						<input id="modalRno" type="hidden">
						<!-- 작성자 -->
						<input id="modalWriter" type="text" readonly="readonly" style="pointer-events: none;">
					</div>
					<hr>
					<!-- 글 내용 -->
					<textarea id="modalContent" rows="5" cols="80" style="width: 98%;" required="required"></textarea>
				</div>
				<div align="right">
					<button class="replyModalModify" onclick="modifyReply(${view.bno});">댓글수정</button>
					<button class="replyModalCancel" type="button" id="modalClose" onclick="modalClose();">취소</button>
				</div>
			</div>
			<div class="modal_layer"></div>
			<!-- modal_layer는 배경을 담당하는 클래스이다. 모달창이 뜨면 배경을 어둡게하는 역할인 생각보다 중요한 클래스임. -->
		</div>
		<!-- 댓글 수정 modal창 끝 -->
		<!-- ajax를 이용할 것이므로 form태그는 사용하지 않는다. -->

		<br>
		<hr>

		<h2>댓글 작성</h2>

		<div align="center">
			<table>
				<thead>
					<tr>
						<th style="border-bottom: none;">
							<div style="margin-right: 20px;" align="left">
								<input id="writer" type="text" placeholder="닉네임을 입력하세요.">
							</div>
							<div style="margin-right: 20px;" align="left">
								<input id="replyPwd" type="text" placeholder="비밀번호를 입력하세요.(미구현)">
							</div>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="border-bottom: none;">
							<textarea id="content" rows="5" cols="100" placeholder="내용을 입력하세요"></textarea>
							<div align="right">
								<button class="replySubmitButton" onclick="writeReply('${view.bno}');">등록</button>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- 댓글 구현 끝 -->
	</div>
</body>

<!-- 자바스크립트 로직 짠것. 외부파일 가져오기. -->
<script type="text/javascript" src="/resources/BBS_JS/viewJS.js"></script>

</html>