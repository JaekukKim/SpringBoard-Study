<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 반응형 웹을 만들어주기 위한 메타태그 viewport -->
<meta name="viewport" content="width=device-width, height=device-height ,initial-scale=1">

<title>게시판 네비게이션 탭</title>

<!-- jquery 구글 CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<!-- CSS -->
<link rel="stylesheet" type="text/css" href="/resources/BBS_CSS/boardCSS/menuNavCSS.css?ver=1">

</head>
<body>
	<header>
		<h1>
			<a id="mainBoard" href="../board/boardMain">SpringBoard</a>
		</h1>
		<nav>
			<div id="navBtnGroup" align="left">
				<!-- 태그에 링크 달아줄때는 꼭 컨트롤러에 url이 있는지 확인하고 달아줘야할것. -->
				<button class="navButton" onclick="location.href = '/board/boardMain'">게시판 메인으로 이동</button>
				<button class="navButton" onclick="location.href = '/board/list'">게시글 목록으로 이동</button>
				<button class="navButton" onclick="location.href = '/board/pageList?pageNum=1'">페이징 목록으로 이동</button>
				<button class="navButton" onclick="location.href = '/board/pageListAndSearch?pageNum=1'">페이징 + 검색으로 이동</button>
				<button class="navButton" onclick="location.href = '/board/write'">게시글 작성하기</button>
			</div>
		</nav>
	</header>
</body>
</html>