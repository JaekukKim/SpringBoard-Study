/**
 *  게시글 삭제, 댓글 관련, modal 로직
 */
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

	if (content.length == 0) {
		alert("댓글 내용은 반드시 입력되어야 합니다.");
		document.getElementById("content").focus();
		return false;
	}

	$.ajax({
		url: "/reply/writeReply",
		type: "POST",
		data: {
			bno: bno,
			writer: writer,
			content: content
		},

		success: function(data) {
			alert("댓글작성이 완료되었습니다.");
			location.reload(true);
			/*
				location.reload :
					true => 새로고침 한 결과를 "서버"단에서 가져옴
					false => 브라우저 "캐쉬"에서 가져옴
			*/
		},
		error: function(error) {
			alert("알 수 없는 에러가 발생하였습니다.");
			alert(error);
			console.log(error);
		}
	});
}

/* --------------------------- 댓글수정 관련 JS 로직 --------------------------- */
/* 댓글 수정에 필요한 데이터(댓글 리스트 출력한것)를 modal창(modal관련 태그)으로 옮기는 로직 */
$(".replyVO").on("click", ".replyModifyBtn", function() {
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
		url: "/reply/modifyReply",
		type: "POST",
		data: {
			bno: bno,
			rno: rno,
			content: content
		},

		success: function(data) {
			alert("댓글수정이 완료되었습니다.");
			location.reload(true);
			modalClose();
		},
		error: function(error) {
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
function removeReply(rno , bno) {
	/*
		원래 jsp파일이 너무 길어져서 js파일을 따로 만들어서 진행하니 el식을 받지 못하였다.
		그래서 매개변수를 2개를 받아서 처리해주었다. 댓글 pk와 게시글 fk.
	*/

	let removeYN = confirm("댓글을 삭제하시겠습니까? 삭제된 정보는 복구되지 않습니다.");
	
	if (removeYN == true) {

		$.ajax({
			url: "/reply/removeReply",
			type: "POST",
			data: {
				rno: rno,
				bno: bno
			},

			success: function(data) {
				alert("삭제가 완료되었습니다.");
				location.reload(true);
			},
			error: function(error) {
				alert("삭제도중 알 수 없는 오류가 발생하였습니다.");
			}
		});
	} else {
		alert("삭제가 취소되었습니다.");
	}

}

/* --- 댓글 수정 모달창 js 로직 --- */
const replyModal = document.getElementById("modal");
function modalOpen() {
	replyModal.style.display = 'block';
}

function modalClose() {
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
	if (evTarget.classList.contains("modal_layer")) {
		/* 
			classList는 말 그대로 class=""으로 선언된 태그의 엘레먼트들이 들어가있는 리스트 이다.
			classList.contains("class이름") : classList에 class이름이 포함이(contain) 되어 있는지?
			*/
		replyModal.style.display = "none";
	}
})
/* 모달창에서 esc를 누르면 모달창이 꺼지게 만들기 */
window.addEventListener("keyup", e => {
	if (replyModal.style.display === "block" && e.key === "Escape") {
		replyModal.style.display = "none";
	}
})