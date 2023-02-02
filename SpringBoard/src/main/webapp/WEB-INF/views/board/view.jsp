<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.board.domain.ReplyVO"%>
<!DOCTYPE html>
<html>
<head>

<!-- 간단 css (생각보다 길어져서 파일로..)-->
<link rel="stylesheet" type="text/css" href="/resources/boardCSS/viewCSS.css">

<!--
	하나 또 배웠다.
	css 경로 인식이 안돼어 검색을 해보니 servlet-context에 적혀있는 경로의 형식을 지켜서 파일을 넣어줘야 했다.
	따봉
-->

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, height=device-height ,initial-scale=1">
<!-- 반응형 웹을 만들어주기 위한 메타태그 viewport -->
<title>${view.bno }번게시글조회</title>
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
			<hr>
			<br>
			<label>게시글 제목 : </label>
			<span class="boardElementTitle">${view.title }</span>
			<hr>
			<br>
			<label>작성자 : </label>
			<span class="boardElement">${view.writer }</span>
			<hr>
			<br>
			<label>내용</label>
			<br>
			<textarea rows="5" cols="50" class="boardElement" name="content" maxlength="2000" readonly="readonly">${view.content}</textarea>
			<br>
			<!-- 
				**매우중요!!!
				-- jsp페이지에서 <button> 태그를 만들어 버튼을 누를 때 동작을 처리하여 서버와 연결하였는데
				button 태그에 type을 지정해주지 않아 버튼만 누르면 무조건 controller로 넘어가고 있는 것이었다..!
				(button의 type을 지정해주지 않으면 기본 type은 ***submit이 되기 때문에*** 주의해야한다. )
			 -->
		</form>
		<div align="right">
			<a href="/board/modify?bno=${view.bno }">
				<button type="button" class="boardUpdate">게시글 수정하기</button>
			</a>
			<a onclick="javascript:removeContent('${view.bno}');">
				<button type="button" class="boardUpdate">게시글삭제</button>
			</a>
		</div>
		<hr>
		<!-- 댓글 구현하기 -->
		<h2>댓글</h2>
		<div align="center">
			<table>
				<thead>
					<tr align="center">
						<th style="display: none;">댓글 번호</th>
						<th style="width: 250px;">작성자</th>
						<th style="width: 600px;">내용</th>
						<th style="width: 100px;">수정/삭제</th>
					</tr>
				</thead>
				<tbody>
					<!-- model.addAttribute("replyList" , replyList); -->
					<%
					/*
					private String content;	// 댓글 내용
					private String writer;	// 댓글 작성자
					private Date regDate;	// 댓글 등록날짜
					*/

					List<ReplyVO> replyList = (List<ReplyVO>) request.getAttribute("replyList");
					for (int replyNum = 0; replyNum < replyList.size(); replyNum++) {
					%>
					<tr class="replyVO">
						<td class="replyRno" style="display: none;"><%=replyList.get(replyNum).getRno()%></td>
						<td class="replyBno" style="display: none;"><%=replyList.get(replyNum).getBno()%></td>
						<td>
							<div class="replyWriter" style="margin-left: 20px;"><%=replyList.get(replyNum).getWriter()%></div>
							<div>
								<div class="replyRegDate" align="right" style="margin-right: 20px;">
									<font size="2" color="gray"> <fmt:formatDate value="<%=replyList.get(replyNum).getRegDate()%>" pattern="yyyy-MM-dd" />
									</font>
								</div>
							</div>
						</td>
						<td id="replyContent" class="replyContent"><%=replyList.get(replyNum).getContent()%></td>
						<td style="padding-right: 5px;" align="center">
							<font size="2"><button class="replyModifyBtn" type="button">[수정]</button></font>
							<br>
							<font size="2">
								<button class="replyDeleteBtn" type="button" onclick="removeReply('<%=replyList.get(replyNum).getRno()%>');">[삭제]</button>
							</font>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>

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
						<!-- 댓글번호 -->
						<input id="modalRno" type="hidden">
						<!-- 작성자 -->
						<input id="modalWriter" type="text" readonly="readonly" style="pointer-events: none;">
					</div>
					<hr>
					<!-- 글 내용 -->
					<textarea id="modalContent" rows="5" cols="80" style="width: 98%;" required="required"></textarea>
				</div>
				<div align="right">
					<button class="replyModalModify" onclick="modifyReply(${view.bno});">댓글수정</button>
					<button class="replyModalCancel" type="button" id="modalClose" onclick="modalClose();">취소</button>
				</div>
			</div>
			<div class="modal_layer"></div>
			<!-- modal_layer는 배경을 담당하는 클래스이다. 모달창이 뜨면 배경을 어둡게하는 역할인 생각보다 중요한 클래스임. -->
		</div>
		<!-- 댓글 수정 modal창 끝 -->
		<!-- ajax를 이용할 것이므로 form태그는 사용하지 않는다. -->

		<br>
		<hr>

		<h2>댓글 작성</h2>

		<div align="center">
			<table>
				<thead>
					<tr>
						<th style="border-bottom: none;">
							<div style="margin-right: 20px;" align="left">
								<input id="writer" type="text" placeholder="닉네임을 입력하세요.">
							</div>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="border-bottom: none;">
							<textarea id="content" rows="5" cols="100" placeholder="내용을 입력하세요"></textarea>
							<div align="right">
								<button class="replyButton" onclick="writeReply('${view.bno}');">등록</button>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- 댓글 구현 끝 -->
	</div>
</body>



<script type="text/javascript">
	/* 게시글 삭제 js 로직 */
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
	
	/* 댓글 등록 js 로직 (ajax) */
	function writeReply(bno) {
		
		let writer = document.getElementById("writer").value;
		let content = document.getElementById("content").value;
		
		if (writer.length < 2 || writer.length > 12) {
			alert("닉네임은 2글자 이상 12글자 이하여야 합니다.");
			document.getElementById("writer").focus();
			return false;
		}
		
		if (content.length < 10) {
			alert("댓글 내용은 10글자 이상 입력해주세요.");
			document.getElementById("content").focus();
			return false;
		}
		
		$.ajax({
			url : "/reply/writeReply",
			type : "POST",
			data : {
				bno : bno,
				writer : writer,
				content : content
			},
			
			success : function(data) {
				alert("댓글작성이 완료되었습니다.");
				location.reload(true);
				/*
					location.reload :
						true => 새로고침 한 결과를 "서버"단에서 가져옴
						false => 브라우저 "캐쉬"에서 가져옴
				*/
			},
			error : function(error) {
				alert("알 수 없는 에러가 발생하였습니다.");
				alert(error);
				console.log(error);
			}
		});
	}
	
	/* --------------------------- 댓글수정 관련 JS 로직 --------------------------- */
	/* 댓글 수정에 필요한 데이터(댓글 리스트 출력한것)를 modal창(modal관련 태그)으로 옮기는 로직 */
    $(".replyVO").on("click", ".replyModifyBtn" ,function() {
    	/*
    		[1] html의 body에 해당하는 데이터가 로딩이 먼저 되고
    		[2] js가 로딩이 된 다음
    		[3] 이벤트 처리를 진행한다.
    		=> 이것이 기본 메커니즘이다.
    		
    		위에 해당하는 코드는 replyVO라는 클래스의 "바로 아랫부분"에 js가 동작할 수 있도록 클릭 이벤트를 만들어준거나 마찬가지다!
    		=> replyVO라는 클래스 명을 가진 "영역"의 replyModifyBtn의 클래스 명을 가진 버튼을 "클릭"할 시 동작하는 이벤트인것이다.
    	*/
    	
    	// 모달창에 보내주기 전, 데이터를 따내야한다.
    	let replyVO = $(this).closest(".replyVO");
    		/* 	replyModifyBtn을 클릭했으니
    			this = replyModifyBtn이며 이와 가장 가까운 replyVO란 클래스를 찾는 로직이다. */
    			
    	let rno = replyVO.find(".replyRno").text();
    		
    	let writer = replyVO.find(".replyWriter").text();
    	/* text()로 뽑아내면 \t 이런거까지 전부다 뽑아낸다... 태그수정도 필요함.. */
    	
    	let content = replyVO.find(".replyContent").text();
    	
    	// 모달창에 댓글번호, 내용, 작성자를 보내주어야 한다.
    	$("#modalRno").val(rno);
    	$("#modalWriter").val(writer);
    	$("#modalContent").val(content);
    	
		modalOpen();
		/* jquery 떡칠이다. 꼭 js로 바꾸기. */
	})
	
	/* 댓글 수정 서버단 js(ajax) 로직 */
	function modifyReply(bno) {
		
		let rno = document.getElementById("modalRno").value;
		let content = document.getElementById("modalContent").value;
		
		$.ajax({
			url : "/reply/modifyReply",
			type : "POST",
			data : {
				bno : bno,
				rno : rno,
				content : content
			},
			
			success : function(data) {
				alert("댓글수정이 완료되었습니다.");
				location.reload(true);
				modalClose();
			},
			error : function(error) {
				alert("알 수 없는 에러가 발생하였습니다.");
				alert(error);
			}
		});
		
	}
	/*
		[1] (modal관련 태그)로 옮기는 로직은 익명 함수이므로 호이스팅이 된 상태에서 제일 먼저 실행이 되었다.
		[2] 그래서 [수정]버튼을 누르기 전에도 이미 modal창에 올라와있지만 우리 눈에 보이지 않는것일 뿐...
			[2-1] 크롬의 devTools로 실행해보면 modal창과 관련된 태그에 데이터가 이미 들어가있다.
		[3] 그리고 modal창의 수정완료 버튼을 누르면 ajax가 실행되면서 db를 찍는 로직이 실행될 수 있는것이다.
	*/
    /* --------------------------- 댓글수정 관련 JS 로직 끝 --------------------------- */
	
	/* 댓글 삭제 js(ajax) 로직 */
	function removeReply(rno) {
		
		let bno = ${view.bno};
		let removeYN = confirm("댓글을 삭제하시겠습니까? 삭제된 정보는 복구되지 않습니다.");
		
		if (removeYN == true) {
			
			$.ajax({
				url : "/reply/removeReply",
				type : "POST",
				data : {
					rno : rno,
					bno : bno
				},
				
				success : function(data) {
					alert("삭제가 완료되었습니다.");
					location.reload(true);
				},
				error : function(error) {
					alert("삭제도중 알 수 없는 오류가 발생하였습니다.");
				}
			});
		} else {
			alert("삭제가 취소되었습니다.");
		}
		
	}
	
	
	
	/* --- 댓글 수정 모달창 js 로직 --- */
	const replyModal = document.getElementById("modal");
	function modalOpen(){
		replyModal.style.display = 'block';
    }
	
    function modalClose(){
        $("#modalContent").val("");
        replyModal.style.display = 'none';
    }
    
    /* 
		e => {} 는 js의 람다식으로써 function(e){}와 같은 의미이다.
		---람다식---
		[1] 매개변수가 여러개일 경우
			const exam1 = function (x,y){...} 의 함수를
			const exam1 = (x,y) => {...}의 식으로 정의가 가능하다.
		[2] 매개변수가 한개인 경우
			const exam2 = function (x){...} 의 함수를
			const exam2 = (x) => {...} 또는 x(괄호생략가능) => {...}의 식으로 정의가 가능하다
		[3] 매개변수가 없을 경우
			const exam3 = function(){...} 의 함수를
			const exam3 = () => {...} 로 정의가 가능하다. 이때 괄호 생략은 불가능하다.
	*/
	
	/* 모달창 외의 영역을 클릭하면 모달창이 꺼지게 만들기 */
   	replyModal.addEventListener("click", e => {
        const evTarget = e.target;
        if(evTarget.classList.contains("modal_layer")) {
        	/* 
        		classList는 말 그대로 class=""으로 선언된 태그의 엘레먼트들이 들어가있는 리스트 이다.
        		classList.contains("class이름") : classList에 class이름이 포함이(contain) 되어 있는지?
     		*/
     		replyModal.style.display = "none";
        }
    })
    /* 모달창에서 esc를 누르면 모달창이 꺼지게 만들기 */
    window.addEventListener("keyup", e => {
    if(replyModal.style.display === "block" && e.key === "Escape") {
    	replyModal.style.display = "none";
    }
	})
    
</script>
</html>