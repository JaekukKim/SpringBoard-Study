
// 검색타입을 결정하는 select 태그가 카테고리로 바뀌면 시작되는 onchange 로직이다.
function changeInputTag() {
	// select 태그의 class = 'searchType'을 가져와 options [select태그관련변수명.selectedIndex].value로 option 태그의 값을 가져온다.
	let searchType = document.querySelector(".searchType");
	// select에서 선택된 option의 val
	let opVal = searchType.options[searchType.selectedIndex].value;
	
	// 만약 option 태그의 값이 'category' (select 태그 = 카테고리)라면 검색창인 input태그를 select 태그로 바꿔버린다.
	if(opVal=='category'){
		
		$(".keyword").replaceWith
		(
		  "<select id='searchType' name='searchType' onchange='changeCategoryValue();'>"
		+	"<option value='자유게시판' name='keyword'>자유게시판</option>"
		+	"<option value='JAVA' name='keyword'>JAVA</option>"
		+	"<option value='HTML' name='keyword'>HTML</option>"
		+	"<option value='Java Script' name='keyword'>Java Script</option>"
		+ "</select>"
		);
		
	} else {
		/* 
			else 부분은 "if문으로 이미 실행이 되서 바뀌어버린" select 태그의 option 태그가 다른 태그로 바뀐다면 원래대로 되돌리는 로직이다.
			그래서 바뀐 select 태그 id값을 가져와 바꾸어 주었다. 
		*/
		$("#searchType").replaceWith(
			"<input type='text' id='keyword' class='keyword' name='keyword' value='<%=pageIngredient.getKeyword()%>' onkeyup='enterSearching();'>"
		);
		
		/* 바뀐 option 태그의 value가 검색창에 그대로 남아있어 만약 바뀐다면 편의성을 위해 원래 input태그를 공란으로 만들어준다. */
		document.getElementById("keyword").value = "";
	}
	
}

/* 위의 함수에서 "이미 실행이 돼고 나온 태그"에 적용되는 로직이다. */
function changeCategoryValue() {
	/* 새롭게 생성된 select 태그의 id를 받아 option의 value를 저장한다. */
	let categorySearchType = document.getElementById("searchType");
	let secondCategoryValue = categorySearchType.options[categorySearchType.selectedIndex].value;
	
	/* 그리고 검색에 써먹기 위해 return을 시켜 값이 확정되도록 만든다. */
	return secondCategoryValue;
}

/*
	아래 코드는 검색을 "첫 시작하는" js코드이다.
	내용을 입력하고 "input 태그에 종속되어 있는 button태그 검색버튼"을 누르면 실행되는 코드이다.
	1페이지 출력용 코드라고 보면 쉽다.
*/
function searchingActivate() {
	let searchType = document.getElementsByName("searchType")[0].value;
	let keyword = document.getElementsByName("keyword")[0].value;
	
	/* 만약 select 태그가 카테고리(option 태그 value = 'category' 라면 changeCategoryValue 함수의 결과값을 키워드에 넣어 검색한다. */
	if(searchType == 'category'){
		keyword = changeCategoryValue();
	}
	
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