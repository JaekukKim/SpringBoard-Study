<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<link rel="stylesheet" type="text/css" href="/resources/memberCSS/signUp.css">
</head>
<body>
	<!-- 게시판 네비게이션 -->
	<jsp:include page="../nav/menuNav.jsp" flush="false"></jsp:include>
	<div class="topWrapper" align="center">
		<div class="wrapper">
			<h1 align="left">회원가입</h1>
			<form action="#">
				<div class="input-box">
					<input type="text" placeholder="아이디를 입력하세요" required>
				</div>
				<div class="input-box">
					<input type="password" placeholder="비밀번호를 입력하세요" required>
				</div>
				<div class="input-box">
					<input type="text" placeholder="이름을 입력하세요" required>
				</div>
				<div class="input-box">
					<input type="email" placeholder="이메일을 입력하세요" required>
				</div>
				<div class="input-box">
					<input type="text" placeholder="닉네임을 입력하세요" required>
				</div>
				<div class="input-box">
					<input type="tel" placeholder="휴대전화 번호를 입력하세요" required>
				</div>
				<div class="policy">
					<input type="checkbox">
					<h3>회원가입에 동의합니다</h3>
				</div>
				<div class="input-box button">
					<input type="Submit" value="회원가입">
				</div>
				<div class="text">
					<h3>
						계정이 이미 있나요?
						<a href="#">로그인하기</a>
					</h3>
				</div>
			</form>
		</div>
	</div>

	<!-- 게시판 꼬릿말 footer -->
	<jsp:include page="../footer/menuFooter.jsp" flush="false"></jsp:include>
</body>
</html>