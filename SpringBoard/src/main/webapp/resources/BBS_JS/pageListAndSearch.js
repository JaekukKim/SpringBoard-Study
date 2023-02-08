/*
	아래 코드는 검색을 "첫 시작하는" js코드이다.
	내용을 입력하고 "input 태그에 종속되어 있는 button태그 검색버튼"을 누르면 실행되는 코드이다.
	1페이지 출력용 코드라고 보면 쉽다.
*/
function searchingActivate() {
	let searchType = document.getElementsByName("searchType")[0].value;
	let keyword = document.getElementsByName("keyword")[0].value;

	/* select 태그의 value인 searchType에 관한 option태그의 값과
	input태그에 들어간 keyword 값을 쿼리스트링으로 보내 첫페이지를 출력한다. */
	location.href = "/board/pageListAndSearch?pageNum=1" + "&searchType="
		+ searchType + "&keyword=" + keyword;
}

/* input 태그 안에서 enter키 (keyNumber == 13) 누르면 검색 시작. */
function enterSearching() {
	if (window.event.keyCode == 13) {
		searchingActivate();
	}
}

/* select 태그가 바뀌면 input 태그 초기화 */
function resetKeyword() {
	let searchType = document.getElementById("searchType");
	let searchTypeVal = searchType.value;

	let keyword = document.getElementsByName("keyword")[0].value;

	// select에서 선택된 option의 val
	let opVal = searchType.options[searchType.selectedIndex].value;

	// text
	let opText = searchType.options[searchType.selectedIndex].text;

	console.log('searchTypeVal : ' + searchTypeVal);
	console.log('opVal : ' + opVal);
	console.log('opText : ' + opText);
	console.log('keyword : ' + keyword);

	keyword = "";
}