<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 네비게이션 탭</title>

<style type="text/css">
.board_nav {
	padding-top: 30px;
	padding-left: 30px;
}
button {
	margin-bottom: 7px;
}
</style>

</head>
<body>
<!-- breadcrump 는 알트 쉬프트 b -->
	<div class="board_nav">
		<a href="../board/boardMain">
			<button>게시판 메인으로 이동</button>
		</a>
		<br>
		<a href="../board/list">
			<button>게시글 목록으로 이동</button>
		</a>
		<br>
		<a href="../board/write">
			<button>게시글 작성하기</button>
		</a>
	</div>
</body>
</html>