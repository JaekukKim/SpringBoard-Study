<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<link rel="stylesheet" type="text/css" href="/resources/memberCSS/signUpAndLogin.css">
</head>
<body>
	<!-- 게시판 네비게이션 -->
	<jsp:include page="../nav/menuNav.jsp" flush="false"></jsp:include>

	<div class="topWrapper" align="center">
		<div class="wrapper" style="margin: 10% 0;">
			<h1 align="left">로그인</h1>
			<form method="post" autocomplete="off" action="/member/login">
				<!-- 자동완성은 막아버린다. -->
				<div class="input-box">
					<input type="text" name="userId" placeholder="아이디를 입력하세요" required>
				</div>
				<div class="input-box">
					<input type="password" name="userPwd" placeholder="비밀번호를 입력하세요" required>
				</div>
				
				<div>
					<label style="color: red;">아이디나 비밀번호를 다시한번 확인해주세요.</label>
				</div>
				
				<div class="input-box button">
					<input type="Submit" value="로그인">
				</div>
				<div class="text">
					<h3>
						아이디나 비밀번호를 잊으셨나요?
						<a href="#">계정찾기</a>
					</h3>
				</div>
			</form>
		</div>
	</div>

	<!-- 게시판 꼬릿말 footer -->
	<jsp:include page="../footer/menuFooter.jsp" flush="false"></jsp:include>
</body>
</html>