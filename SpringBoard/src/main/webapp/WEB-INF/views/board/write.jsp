<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.domain.MemberDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, height=device-height ,initial-scale=1">
<!-- 반응형 웹을 만들어주기 위한 메타태그 viewport -->
<title>게시글 작성</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/BBS_CSS/boardCSS/writeCSS.css">
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
	<div id="boardWrite">
		<h1>게시글 작성하기</h1>
		<form method="post">
			<!-- 여기서 post방식으로 데이터를 보내준다면 controller에서 같은 url일지라도 메소드=post로 된 곳으로 들어간다. -->
			<!-- 수정하기 부분은 조회의 일부분이라고 말할 수 있다. 수정을 하기 위해선 조회를 반드시 해야하기 때문이다.
			 그러므로 조회부분에서 추가해주었던 데이터를 통해 게시글 내용을 불러오기가 가능하다. -->
			<div align="right">
				<label>게시글 제목 : </label>
			</div>
			<span>
				<input type="text" name="title" maxlength="20" placeholder="제목을 입력해주세요" required>
			</span>
			<hr>
			<br>
			<div align="right">
				<label>작성자 : </label>
			</div>
			<%
			MemberDTO memberInfo = (MemberDTO) session.getAttribute("memberInfo");
			if (memberInfo == null) {
			%>
			<span>
				<input name="writer" type="text" maxlength="20" placeholder="비회원은 작성자를 반드시 입력해주세요" required>
			</span>
			<%
			} else {
			%>
			<span>
				<input name="writer" type="text" maxlength="20" style="border: none; pointer-events: none;" value="${memberInfo.userNickname }" readonly="readonly">
			</span>
			<%
			}
			%>
			<hr>
			<br>
			<div align="left">
				<label>내용</label>
			</div>
			<br>
			<textarea rows="5" cols="50" class="boardElement" placeholder="내용을 입력해주세요" name="content" maxlength="2000" required></textarea>
			<br>
			<span>
				<button id="updateButton" type="submit" onclick="checkAllValue();">작성완료</button>
			</span>
		</form>
	</div>
	<!-- 게시판 꼬릿말 footer -->
	<jsp:include page="../footer/menuFooter.jsp" flush="false"></jsp:include>
</body>
<script type="text/javascript" src="/resources/BBS_JS/writeJS.js"></script>
</html>