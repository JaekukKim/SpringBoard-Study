# SpringBoard-Study
스프링 기능을 최대한 활용하여 만들어보는 게시판

<h1>사용 기술</h1>
- Java,Spring,mySQL,Mybatis,HTML,Ajax,JavaScript
- 꾸미는 과정 (css)는 모든 로직을 구현 후 할 예정.

<h1>진행과정</h1>
1. 초반부 디자인은 신경쓰지 말고 댓글기능을 제외한 로직 위주로 구현
=> 2023 - 01 - 13 페이징처리까지 완료.
  
2. 모든 구현이 끝났으면 외래키 학습 및 예제 조금 만들어보고 본격적으로 댓글기능 구현.
  
3. 게시판의 제 기능을 모두 구현했을 시 디자인 신경써서 꾸며보기

<h1>더미데이터 생성 과정</h1>
페이징 처리 테스트를 위한 더미데이터 생성은 mySQL의 procedure를 이용하여 생성하였다.

---------------------------------코드-----------------------------------<br>
delimiter $$
drop PROCEDURE if EXISTS dummyContent$$
create PROCEDURE dummyContent()
begin
 	DECLARE i int DEFAULT 1;

-- mySQL의 while문으로 작성
     while i <= 1024 do
 		insert into tbl_board (bno, title, content, writer, regDate, viewCount)
         values(i, concat('테스트 제목 ', i, '번째 게시글'), concat('테스트 내용 ', i), concat('a', ((i%8)+1),'번 사용자'), now(), 0);
         -- concat('a', (i%5)+1)은 5명의 사용자가 돌려서 글을 쓴다는 의미로 만들어주었다.
 		set i = i+1;
     end while;
    
end$$
delimiter $$dummyContent

-- 프로시저 호출
call dummyContent; <br>
---------------------------------코드 끝---------------------------------

1024건의 데이터를 생성한 이유는 페이징 처리에 있어 마지막 페이지가 정확히 출력되는지를 알아보기 위해서이다.

추후 추가예정입니당.
