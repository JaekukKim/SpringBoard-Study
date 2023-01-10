<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<style type="text/css">
#boardWrite {
	padding-top: 20px;
	margin-left: 40px;
}

span {
	text-align: left;
}
#updateButton {
	position: relative;
}
.writer{
	margin-left: 38px;
}
#writer{
	pointer-events : none;
	/* 마우스 드래그나 올렸을때 변화, 클릭 등 모든 이벤트를 막아버린다. */
}
textarea {
	resize: none;
}

</style>
</head>
<body>
<!-- 게시판 네비게이션 -->
<jsp:include page="../nav/menuNav.jsp" flush="false"></jsp:include>

	<div id="boardWrite">
		<h1>게시글 수정하기</h1>
		<hr />
		<form method="post"> <!-- 여기서 post방식으로 데이터를 보내준다면 controller에서 같은 url일지라도 메소드=post로 된 곳으로 들어간다. -->
		<!-- 수정하기 부분은 조회의 일부분이라고 말할 수 있다. 수정을 하기 위해선 조회를 반드시 해야하기 때문이다.
			 그러므로 조회부분에서 추가해주었던 데이터를 통해 게시글 내용을 불러오기가 가능하다. -->
			<label>게시글 제목</label>
			<input type="text" name="title" maxlength="20" style="width: 300px;" value="${view.title }">
			<br>
			<br>
			<label class="writer">작성자</label>
			<input id="writer" type="text" name="writer" maxlength="20" style="border: none;" value="${view.writer }" readonly="readonly">
			<br>
			<br>
			<label>내용</label>
			<textarea cols="160" rows="10" name="content" maxlength="2000">${view.content}</textarea>
			<br>
			<div id="updateButton" align="center">
				<input type="submit" value="수정완료">
			</div>
		</form>
	</div>
</body>
</html>