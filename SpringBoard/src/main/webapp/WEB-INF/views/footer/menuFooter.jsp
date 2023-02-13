<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페이지 하단부 표시 footer</title>
<style type="text/css">
.footer-div {
	width: auto;
}
footer>div {
	width: 75%;
	position : relative;
	height: auto;
	min-height: 100%;
}

address>a {
	color: #42b983;
}

address>a:hover {
	color: #2c3e50;
}
</style>
</head>
<body>
	<hr>
	<div class="footer-div" align="center">
		<footer>
			<div align="center">
				<p>제작자 : Auden Kim</p>
				<address>
					GitHub :
					<a href="https://github.com/JaekukKim?tab=repositories" target="_blank">Click</a>
				</address>
			</div>
		</footer>
	</div>
	<br>
</body>
</html>