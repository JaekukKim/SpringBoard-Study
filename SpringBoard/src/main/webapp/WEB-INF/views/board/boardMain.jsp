<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, height=device-height ,initial-scale=1">
<!-- 반응형 웹을 만들어주기 위한 메타태그 viewport -->
<title>게시판 메인페이지</title>
</head>
<body>
	<jsp:include page="../nav/menuNav.jsp" flush="false"></jsp:include>
	<h1>스프링으로 만드는 게시판 예제</h1>
	<br>
	<a href="/board/list">게시물 목록</a>
	<br>
	<br>
	<a href="/board/pageList?pageNum=1">페이징 처리된 게시글 목록</a>
	<br>
	<br>
	<a href="/board/write">게시글 작성</a>
	<br>
	<br>
</body>
</html>