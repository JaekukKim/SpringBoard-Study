<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link rel="stylesheet" type="text/css" href="/resources/memberCSS/memberModify.css">
</head>
<body>
	<!-- 게시판 네비게이션 -->
	<jsp:include page="../nav/menuNav.jsp" flush="false"></jsp:include>

	<div class="topWrapper" align="center">
		<div class="wrapper" style="margin: 2% 0 5% 0;">
			<h1 align="left">회원 정보 수정</h1>
			<form role="form" method="post" autocomplete="off" action="/member/modify">
				<!-- 자동완성은 막아버린다. -->
				<div class="input-box id-box" title="아이디는 수정이 불가합니다">
					<input type="text" name="userId" value="${memberInfo.userId }" readonly="readonly">
				</div>
				<div class="input-box">
					<input type="password" name="userPwd" placeholder="수정할 비밀번호를 입력하세요" value="${memberInfo.userPwd }" required>
				</div>
				<div class="input-box name-box" title="이름은 수정이 불가합니다">
					<input type="text" name="userName" value="${memberInfo.userName }" readonly="readonly">
				</div>
				<div class="input-box">
					<input type="email" name="userEmail" placeholder="수정할 이메일을 입력하세요" value="${memberInfo.userEmail }" required>
				</div>
				<div class="input-box nickname-box" title="닉네임은 수정이 불가합니다">
					<input type="text" name="userNickname" value="${memberInfo.userNickname }" readonly="readonly">
				</div>
				<div class="input-box">
					<input type="tel" name="userPhoneNumber" placeholder="수정할 휴대전화 번호를 입력하세요" value="${memberInfo.userPhoneNumber }" required>
				</div>
				<div class="input-box button">
					<input type="submit" value="정보수정">
				</div>
			</form>
		</div>
	</div>

	<!-- 게시판 꼬릿말 footer -->
	<jsp:include page="../footer/menuFooter.jsp" flush="false"></jsp:include>
</body>
</html>