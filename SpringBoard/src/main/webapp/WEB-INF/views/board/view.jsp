<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.board.domain.ReplyVO"%>
<!DOCTYPE html>
<html>
<head>

<!-- 간단 css (생각보다 길어져서 파일로..)-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/boardCSS/viewCSS.css">
<style type="text/css">

</style>

<!--
	하나 또 배웠다.
	css 경로 인식이 안돼어 검색을 해보니 servlet-context에 적혀있는 경로의 형식을 지켜서 파일을 넣어줘야 했다.
	따봉
-->

<meta charset="UTF-8">
<title>${view.bno }번게시글조회</title>
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
		<!-- 댓글 구현하기 -->
		<hr>
		<h2>댓글</h2>
		<!--
			<th style="width: 150px;">작성자</th>
			<th style="width: 150px;">작성일</th>
			<th style="width: 80px;">조회수</th>
		-->
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
					for (int replyNum = 0; replyNum < replyList.size(); replyNum++) {
					%>
					<tr>
						<td style="display: none;"><%=replyList.get(replyNum).getRno()%></td>
						<td>
							<div style="margin-left: 20px;">
								<%=replyList.get(replyNum).getWriter()%>
								<br>
								<div align="right" style="margin-right: 20px;">
									<font size="2" color="gray"> <fmt:formatDate value="<%=replyList.get(replyNum).getRegDate()%>" pattern="yyyy-MM-dd" />
									</font>
								</div>
							</div>
						</td>

						<td id="replyContent"><%=replyList.get(replyNum).getContent()%></td>
						<td style="padding-right: 5px;" align="center">
							<font size="2"><a href="javascript:modifyReply('<%=replyList.get(replyNum).getRno()%>');">[수정]</a></font>
							<br>
							<font size="2"><a href="javascript:removeReply('<%=replyList.get(replyNum).getRno()%>');">[삭제]</a></font>
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
			<div class="modal_content"> <!-- modal_window -->
				<div class="replyTitle">
					<h2>댓글 수정</h2>
				</div>
				<div class="replyContent">
					<p>댓글 내용이 나올 부분</p>
				</div>
				<button type="button" id="modalClose" onclick="modalClose();">모달 창 닫기</button>
			</div>
			<div class="modal_layer"></div>
			<!-- modal_layer는 배경을 담당하는 클래스이다. 모달창이 뜨면 배경을 어둡게하는 역할하는 생각보다 중요한 클래스임. -->
		</div>

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
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="border-bottom: none;">
							<textarea id="content" rows="5" cols="100" placeholder="내용을 입력하세요"></textarea>
							<div align="right">
								<button class="replyButton" onclick="writeReply('${view.bno}');">등록</button>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- 댓글 구현 끝 -->
	</div>
</body>
<script type="text/javascript">
	/* 게시글 삭제 js 로직 */
	function removeContent(bno) {
		let YN = confirm('정말 [' + bno + ']번 게시글을 삭제하시겠습니까?\n삭제된 정보는 복구되지 않습니다.');

		if (YN == true) {
			alert('게시글이 삭제되었습니다.');
			location.href = "/board/remove?bno=" + bno;
		} else {
			alert('게시글 삭제를 취소하셨습니다.');
			location.href = "http://localhost:8080/board/view?bno=" + bno;
		}
	}
	/* 댓글 등록 js 로직 (ajax) */
	function writeReply(bno) {
		
		let writer = document.getElementById("writer").value;
		let content = document.getElementById("content").value;
		
		console.log(bno);
		console.log(writer);
		console.log(content);
		
		if (writer.length < 2 || writer.length > 12) {
			alert("닉네임은 2글자 이상 12글자 이하여야 합니다.");
			document.getElementById("writer").focus();
			return false;
		}
		
		if (content.length < 10) {
			alert("댓글 내용은 10글자 이상 입력해주세요.");
			document.getElementById("content").focus();
			return false;
		}
		
		$.ajax({
			url : "/reply/writeReply",
			type : "POST",
			data : {
				bno : bno,
				writer : writer,
				content : content
			},
			
			success : function(data) {
				alert("댓글작성이 완료되었습니다.");
				location.reload(true);
				/*
					location.reload :
						true => 새로고침 한 결과를 "서버"단에서 가져옴
						false => 브라우저 "캐쉬"에서 가져옴
				*/
			},
			error : function(error) {
				alert("알 수 없는 에러가 발생하였습니다.");
				alert(error);
				console.log(error);
			}
		});
	}
	/* 댓글 수정 js 로직 */
	function modifyReply(rno) {
		modalOpen();
	}
	/* 댓글 삭제 js 로직 */
	function removeReply(rno) {
		
	}
	/* --- 댓글 수정 모달창 js 로직 --- */
	const replyModal = document.getElementById("modal");
	function modalOpen(){
        modal.style.display = 'block';
    }
    function modalClose(){
        modal.style.display = 'none';
    }
    
</script>
</html>