<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 네비게이션 탭</title>

<style type="text/css">
header {
	/* nav-bar 상단 고정 코드 시작 */
	position: fixed;
	top: 0;
	/* width: 100% */
	left: 0;
	right: 0;
	/* nav-bar 상단 고정 코드 끝 - 매우 많이 쓰이므로 그냥 외워두자 css는 답이없다. */
	
	height: 75px;
	padding: 1rem;
	color: white;
	background: gray;
	font-weight: bold;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

body {
	padding-top: 95px;
}
.navA{
	text-decoration: none;
}
#mainBoard{
	text-decoration: none;
}
#mainBoard:visited {
	color: white;
}
</style>

</head>
<body>
	<!-- breadcrump 는 알트 쉬프트 b -->
	<header>
		<h1><a id="mainBoard" href="../board/boardMain">SpringBoard</a></h1>
		<nav>
			<div id="navBtnGroup">
				<span>
					<a class="navA" href="../board/boardMain">
						<!-- 태그에 링크 달아줄때는 꼭 컨트롤러에 url이 있는지 확인하고 달아줘야할것. -->
						<button class="navButton">게시판 메인으로 이동</button>
					</a>
				</span>
				<span>
					<a class="navA" href="../board/list">
						<button>게시글 목록으로 이동</button>
					</a>
				</span>
				<span class="navSpan">
					<a class="navA" href="/board/pageList?pageNum=1">
						<button>페이징 목록으로 이동</button>
					</a>
				</span>
				<span class="navSpan">
					<a class="navA" href="../board/write">
						<button>게시글 작성하기</button>
					</a>
				</span>
			</div>
		</nav>
	</header>
</body>
</html>