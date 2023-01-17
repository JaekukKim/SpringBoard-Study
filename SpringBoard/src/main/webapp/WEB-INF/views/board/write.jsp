<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<style type="text/css">
#boardWrite {
	padding-top: 50px;
}

span {
	text-align: left;
}
a {
	text-decoration: none;
}
</style>
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

	<div id="boardWrite" align="center">
		<h1>게시글 작성하기</h1>
		<hr />
		<form method="post">
			<label>게시글 제목</label>
			<input type="text" name="title" maxlength="20">
			<br> <br>
			<label> 작성자</label>
			<input type="text" name="writer" maxlength="12">
			<br> <br>
			<label> 내용 </label>
			<br>
			<textarea cols="50" rows="10" name="content" maxlength="2000"></textarea>
			<br> <br>
			<input type="submit" value="게시글작성">
			<input type="reset" value="다시작성">
		</form>
		<br>
		<a href="/board/list">
			<button>목록으로 돌아가기</button>
		</a>
		<a href="/board/pageList?pageNum=1">
			<button>페이징 목록으로 돌아가기</button>
		</a>
	</div>
</body>
</html>