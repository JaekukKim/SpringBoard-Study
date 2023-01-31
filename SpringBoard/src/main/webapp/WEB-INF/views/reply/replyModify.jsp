<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 수정 (modal 사용)</title>
</head>
<body>
	<!-- 댓글 수정 모달창 : #modal -->
	<div id="modal" class="modal_overlay">
		<!-- 댓글의 내용을 입력하는 클래스 : .modal_content -->
		<div class="modal_content">
			<button type="button" class="close-button" onclick="modalClose();">X</button>
			<!-- modal_window -->
			<div class="replyTitle">
				<h2>댓글 수정</h2>
			</div>
			<br>
			<div class="replyContent">
				<div style="margin-right: 20px;" align="left">
					<input id="writer" type="text" readonly="readonly">
				</div>
				<hr>
				<textarea id="content" rows="5" cols="80" style="width: 98%;"></textarea>
				<div align="right">
					<button class="replyButton" onclick="updateReply();">수정</button>
					<button class="replyButton" type="button" id="modalClose" onclick="modalClose();">취소</button>
				</div>
			</div>
		</div>
		<div class="modal_layer"></div>
		<!-- modal_layer는 배경을 담당하는 클래스이다. 모달창이 뜨면 배경을 어둡게하는 역할하는 생각보다 중요한 클래스임. -->
	</div>
	<!-- ajax를 이용할 것이므로 form태그는 사용하지 않는다. -->
</body>
</html>