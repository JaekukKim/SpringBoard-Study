<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최초실행페이지(스프링)</title>
</head>
<body>
	<h1>현재시간</h1>
	<P>=> The time on the server is ${serverTime}. <=</P>
	
	서버 실행 성공시 뜨는 문구입니다. 원하시는 작업을 선택해주세용.
	<br>
	<br>
	
	<a href="/board/pageListAndSearch?pageNum=1">게시판 메인페이지 이동</a>
	<hr>
	<div>
		서블릿 버전 체크 : <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %>
	</div>
</body>
</html>


