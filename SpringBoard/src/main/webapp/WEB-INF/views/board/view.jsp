<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${view.bno }번게시글조회</title>
<!-- 간단 css -->
<style type="text/css">
#boardTB {
	width: 1500px;
	padding-top: 30px;
	margin-left: 50px;
}

label {
	font-size: 22px;
}

.boardElement {
	margin-left: 80px;
}

.boardElementTitle {
	margin-left: 25px;
}

textarea {
	resize: none;
}

a {
	text-decoration: none;
}
</style>

</head>
<body>
	<!-- 게시글에 대한 정보는 데이터기도 하며 get은 글자수의 제한이 있으니 get보단 post로 전달해주어야 한다 -->
	<!--
		private String title;
		private String content;
		private String writer;
	 -->
	<!--
	 	form 태그 안에 있는 name속성의 값은 db의 컬럼명 (VO의 변수명)과 일치시켜주는게 편하다.
	 	게시글의 정보를 입력받아 BoardVO객체에 넣어서 전송시켜주는데, 이때 변수명과 name속성명이 동일하다면 추가작업을 해주는 과정을
	 	생략할 수 있어 작업이 매우 편해진다.
	 	그렇지 않다면 String id=getAttribute("name속성 명")이런식으로 데이터를 받아서 jdbc마냥 추가시켜주어야 한다.
	  -->
	<!-- 게시판 네비게이션 -->
	<jsp:include page="../nav/menuNav.jsp" flush="false"></jsp:include>

	<div id="boardTB">
		<h1>${view.bno }번게시글</h1>
		<form method="post">
			<label>조회수 : </label>
			<span class="boardElement">${view.viewCnt }</span>
			<br> <br>
			<label>게시글 제목 : </label>
			<span class="boardElementTitle">${view.title }</span>
			<br> <br>
			<label>작성자 : </label>
			<span class="boardElement">${view.writer }</span>
			<br> <br>
			<label>내용</label>
			<br>
			<textarea class="boardElement" cols="160" rows="10" name="content" maxlength="2000">${view.content}</textarea>
			<br> <br>
			<!-- 
				**매우중요!!!
				-- jsp페이지에서 <button> 태그를 만들어 버튼을 누를 때 동작을 처리하여 서버와 연결하였는데
				button 태그에 type을 지정해주지 않아 버튼만 누르면 무조건 controller로 넘어가고 있는 것이었다..!
				(button의 type을 지정해주지 않으면 기본 type은 ***submit이 되기 때문에*** 주의해야한다. )
			 -->
		</form>
		<hr>
		

		<hr>
		<a href="/board/modify?bno=${view.bno }">
			<button type="button">게시글 수정하기</button>
		</a>
		<a onclick="javascript:removeContent('${view.bno}');">
			<button>게시글삭제</button>
		</a>
	</div>
</body>
<script type="text/javascript">
	function removeContent(bno) {
		let YN = confirm('정말 [' + bno + ']번 게시글을 삭제하시겠습니까?\n삭제된 정보는 복구되지 않습니다.');

		if (YN == true) {
			alert('게시글이 삭제되었습니다.');
			location.href = "/board/remove?bno=" + bno;
		} else {
			alert('게시글 삭제를 취소하셨습니다.');
			location.href = "http://localhost:8080/board/view?bno=" + bno;
		}
	}
</script>
</html>