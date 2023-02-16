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
		<div class="wrapper" style="margin: 2% 0 5% 0;">
			<h1 align="left">회원가입</h1>
			<form role="form" method="post" autocomplete="off">
			<!-- 자동완성은 막아버린다. -->
				<div class="input-box id-box">
					<input type="text" name="userId" placeholder="아이디를 입력하세요" required>
				</div>
				<div class="duplicated_id" align="right">
					<button type="button" name="userId">아이디 중복검사</button>
				</div>
				<div class="input-box">
					<input type="password" name="userPwd" placeholder="비밀번호를 입력하세요" required>
				</div>
				<div class="input-box">
					<input type="text" name="userName" placeholder="이름을 입력하세요" required>
				</div>
				<div class="input-box">
					<input type="email" name="userEmail" placeholder="이메일을 입력하세요" required>
				</div>
				<div class="input-box">
					<input type="text" name="userNickname" placeholder="닉네임을 입력하세요" required>
				</div>
				<div class="input-box">
					<input type="tel" name="userPhoneNumber" placeholder="휴대전화 번호를 입력하세요" required>
				</div>
				<div class="policy">
					<input type="checkbox" value="">
					<h3>회원가입에 동의합니다(미구현)</h3>
				</div>
				<div class="input-box button">
					<input type="Submit" value="회원가입">
				</div>
				<div class="text">
					<h3>
						계정이 이미 있나요?
						<a href="/member/loginpage">로그인하기</a>
					</h3>
				</div>
			</form>
		</div>
	</div>

	<!-- 게시판 꼬릿말 footer -->
	<jsp:include page="../footer/menuFooter.jsp" flush="false"></jsp:include>
</body>
</html>