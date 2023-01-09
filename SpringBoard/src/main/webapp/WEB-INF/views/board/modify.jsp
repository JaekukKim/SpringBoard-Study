<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<style type="text/css">
#boardWrite {
	padding-top: 50px;
}

span {
	text-align: left;
}
</style>
</head>
<body>
<!-- 게시판 네비게이션 -->
<jsp:include page="../nav/menuNav.jsp" flush="false"></jsp:include>

	<div id="boardWrite" align="center">
		<h1>게시글 수정하기</h1>
		<hr />
		<form method="post"> <!-- 여기서 post방식으로 데이터를 보내준다면 controller에서 같은 url일지라도 메소드=post로 된 곳으로 들어간다. -->
		<!-- 수정하기 부분은 조회의 일부분이라고 말할 수 있다. 수정을 하기 위해선 조회를 반드시 해야하기 때문이다.
			 그러므로 조회부분에서 추가해주었던 데이터를 통해 게시글 내용을 불러오기가 가능하다. -->
			<label>게시글 제목</label>
			<input type="text" name="title" maxlength="20" value="${view.title }">
			<br> <br>
			<label>작성자</label>
			<div>작성자 수정 불가</div>
			<br> <br>
			<label>내용</label>
			<br>
			<textarea cols="50" rows="10" name="content" maxlength="2000">${view.content}</textarea>
			<br> <br>
			<input type="submit" value="수정완료">
		</form>
	</div>
</body>
</html>