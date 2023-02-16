/* 보안을 위해 공란일시 게시글 작성이 안돼게 하는 로직, required를 사용하여도 devtools에서 지워버리고 입력하면 통과가 된다. */
function checkAllValue(){
	let titleValue = document.getElementsByName("title")[0].value;
	let writerValue = document.getElementsByName("writer")[0].value;
	let contentValue = document.getElementsByName("content")[0].value;
	
	if(titleValue.length == 0){
		alert("제목을 반드시 입력해주세요!");
	} else if(writerValue == 0) {
		alert("비회원은 반드시 작성자를 입력해주셔야 합니다!");
	} else if(contentValue == 0 ){
		alert("내용을 반드시 입력해주세요!");
	}
}