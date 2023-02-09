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
<link rel="stylesheet" type="text/css" href="/resources/BBS_CSS/boardCSS/menuNavCSS.css">

</head>
<body>
	<!-- 시멘틱 태그인 nav 태그와 ul, li, a를 이용하여 네비바 구성 -->
	<!-- 
        dropdown: 각각의 메뉴를 구성하는 컨테이너 클래스.
        dropdown-menu : 메인 메뉴 항목을 정의하는 클래스.
        dropdown-content : 서브메뉴가 있을 경우 드롭다운으로 나타나는 메뉴 목록 지정 클래스.
        home : 메인 화면으로의 링크를 위해 메뉴와 컬러 구성을 달리한 클래스.
    -->
	<header class="nav_header">
		<h1><a href="/board/boardMain">SpringBoard</a></h1>
		<nav>
			<div>
				<ul>
					<li class="dropdown">
						<div class="dropdown-menu">Board</div>
						<div class="dropdown-content">
							<a href="/board/boardMain">게시판 메인</a>
							<a href="/board/list">게시글 목록</a>
							<a href="/board/pageList?pageNum=1">페이징 목록</a>
							<a href="/board/pageListAndSearch?pageNum=1">페이징 + 검색 목록</a>
							<a href="/board/write">게시글 작성</a>
						</div>
					</li>
					<li class="dropdown">
						<div class="dropdown-menu">Member</div>
						<div class="dropdown-content">
							<a href="/member/signUp">회원가입</a>
							<a href="#">회원정보수정</a>
							<a href="#">회원탈퇴</a>
						</div>
					</li>
					<li class="dropdown">
						<div class="dropdown-menu">Image</div>
						<div class="dropdown-content">
							<a href="#">이미지 게시판</a>
							<a href="#">이미지 업로드</a>
							<a href="#">...</a>
							<a href="#">...</a>
						</div>
					</li>
					<li class="dropdown">
						<div class="dropdown-menu">관리자 페이지</div>
					</li>
				</ul>
			</div>
		</nav>
	</header>
</body>
</html>