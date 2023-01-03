<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${view.bno }번게시글 조회</title>
<!-- 간단 css -->
<style type="text/css">
#boardTB{
	padding-top: 50px;
	margin-top: 20px;
}
label{
	font-size: 22px;
	
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
	<h1 align="center">${view.bno }번게시글</h1>
	<div id="boardTB" align="center">
		<form method="post">
			<label>게시글 제목</label>
			<div class="boardElement">${view.title }</div>
			<br> <br>
			<label>작성자</label>
			<div class="boardElement">${view.writer }</div>
			<br> <br>
			<label>내용</label>
			<br>
			<div class="boardElement">${view.content }</div>
			<br> <br>
			<!-- <input type="submit" value="제출">
		<input type="reset" value="다시작성"> -->
		</form>
	</div>
</body>
</html>