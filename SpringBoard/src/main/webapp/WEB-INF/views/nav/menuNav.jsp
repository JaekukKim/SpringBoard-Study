<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, height=device-height ,initial-scale=1">
<!-- 반응형 웹을 만들어주기 위한 메타태그 viewport -->
<title>게시판 네비게이션 탭</title>

<!-- jquery 구글 CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<style type="text/css">
header {
	/* nav-bar 상단 고정 코드 시작 */
	position: fixed;
	top: 0;
	/* width: 100% */
	left: 0;
	right: 0;
	/* nav-bar 상단 고정 코드 끝 - 매우 많이 쓰이므로 그냥 외워두자 css는 답이없다. */
	height: 40px;
	padding: 1rem;
	color: white;
	background: gray;
	font-weight: bold;
	display: flex;
	justify-content: space-between;
	align-items: center;
}
body {
	padding-top: 60px;
}

#mainBoard {
	text-decoration: none;
	color: white;
}

#mainBoard:visited {
	color: white;
}

#mainBoard:hover {
	color: #dcdcdc;
}

#navBtnGroup {
	float: left;
}

.navButton {
	border: none;
	float: left;
	background: gray;
	color: white;
	height: 70px;
	font-weight: bold;
}

.navButton:hover {
	border-radius : 12px;
	background-color: #bebebe;
	color: black;
	cursor: pointer;
}

button:nth-child(even) {
	border-radius : 12px;
	background-color: #e9e9e9;
	color: black;
}

button:nth-child(even):hover {
	
	color: white;
}
</style>

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