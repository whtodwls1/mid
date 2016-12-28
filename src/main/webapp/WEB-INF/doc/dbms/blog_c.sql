▷ /webapp/WEB-INF/doc/dbms/blog_c.sql
-----------------------------------------------------------------------------------
DROP TABLE blog;
/**********************************/
/* Table Name: 블로그 내용 */
/**********************************/
CREATE TABLE blog(
        blogno               NUMBER(7)        NOT NULL        PRIMARY KEY,
        categoryno         NUMBER(7)        NULL ,
        mno                  NUMBER(6)        NULL ,
        title                   VARCHAR2(200)        NOT NULL,
        content              VARCHAR2(4000)       NOT NULL,
        good                 NUMBER(7)        DEFAULT 0       NOT NULL,
        thumb               VARCHAR2(100)        NULL ,
        file1                   VARCHAR2(50)         NULL ,
        size1                  NUMBER(9)        DEFAULT 0       NULL ,
        cnt                    NUMBER(7)        DEFAULT 0       NOT NULL,
        replycnt              NUMBER(7)        DEFAULT 0       NOT NULL,
        rdate                  DATE         NOT NULL,
        grpno                 NUMBER(7)        NOT NULL,
        indent                NUMBER(2)        DEFAULT 0       NOT NULL,
        ansnum              NUMBER(5)        DEFAULT 0       NOT NULL,
  FOREIGN KEY (categoryno) REFERENCES category (categoryno),
  FOREIGN KEY (mno) REFERENCES MEMBER (mno)
);

COMMENT ON TABLE blog is '블로그 내용';
COMMENT ON COLUMN blog.blogno is '블로그번호';
COMMENT ON COLUMN blog.categoryno is '카테고리번호';
COMMENT ON COLUMN blog.mno is '회원 번호';
COMMENT ON COLUMN blog.title is '제목';
COMMENT ON COLUMN blog.content is '내용';
COMMENT ON COLUMN blog.good is '추천수';
COMMENT ON COLUMN blog.thumb is 'Thumb 파일';
COMMENT ON COLUMN blog.file1 is '파일 1';
COMMENT ON COLUMN blog.size1 is '파일 1 크기';
COMMENT ON COLUMN blog.cnt is '조회수';
COMMENT ON COLUMN blog.replycnt is '댓글수';
COMMENT ON COLUMN blog.rdate is '등록일';
COMMENT ON COLUMN blog.grpno is '그룹번호';
COMMENT ON COLUMN blog.indent is '답변차수';
COMMENT ON COLUMN blog.ansnum is '답변 순서';


1) 등록
-- member 회원 목록(팀원 1)
SELECT mno, id, passwd, mname, tel, zipcode, address1, address2, mdate
FROM member
ORDER BY id ASC;

insert into mno,id,passwd,mname,tel,zipcode,address1,address2,mdate value 

 MNO ID    PASSWD MNAME TEL           ZIPCODE ADDRESS1                   ADDRESS2 MDATE
 --- ----- ------ ----- ------------- ------- -------------------------- -------- ---------------------
   1 user1 1234   아로미   111-1111-1111 00000   경기도                        파주시      2016-11-28 13:04:35.0
   2 user2 1234   왕눈이   000-0000-0000 12345   서울시 종로구                    관철동      2016-11-28 13:04:36.0
   3 user3 1234   왕눈이   000-0000-0000 12345   서울시 종로구                    관철동      2016-11-28 13:04:37.0
   4 user4 1234   왕눈이   010-0000-0000 03154   서울 종로구 종로 1 (종로1가, 교보생명빌딩) 1        2016-11-28 13:17:11.0

-- category 카테고리 목록(팀원 2)
SELECT categoryno, categrpno, title, seqno, visible, ids
FROM category 
ORDER BY seqno ASC;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 ---------- --------- ----- ----- ------- -----
          3         1 경기도       1 Y       admin
          1         2 강원도       2 Y       admin
          2         2 아시아       3 Y       admin

              
-- blog 새글 등록(팀원 3)
- 새로운 글, 답변 글에따라 등록 SQL차이가 있습니다.
- 새로운 글 등록은 새로운 그룹이 만들어지는 기능이 있습니다. MAX + 1
INSERT INTO blog(blogno,
                          categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
                          grpno, indent, ansnum)  
VALUES((SELECT NVL(MAX(blogno), 0) + 1 as blogno FROM blog),
            1, 1, '제목', '내용', 0, 'fall_m.jpg', 'fall.jpg', 0, 0, 0, sysdate,
            (SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM blog), 0, 0);

-- ERROR: FK 컬럼에 사용할 값이 다른 테이블에 등록이 안되어 있는 경우
    ORA-02291: integrity constraint (SOLDESK.SYS_C007131) violated - parent key not found
    ORA-02291: integrity constraint (SOLDESK.SYS_C007132) violated - parent key not found

2) 전체 목록(댓글 구현)
SELECT blogno,
           categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
           grpno, indent, ansnum
FROM blog
ORDER BY grpno DESC, ansnum ASC;

 BLOGNO CATEGORYNO MNO TITLE CONTENT GOOD THUMB      FILE1    SIZE1 CNT REPLYCNT RDATE                 GRPNO INDENT ANSNUM
 ------ -------------- --- ----- ------- ---- ---------- -------- ----- --- -------- --------------------- ----- ------ ------
      1              1   4 제목    내용         0 fall_m.jpg fall.jpg     0   0        0 2016-10-12 10:56:55.0     1      0      0

3) category 별 목록(댓글 구현)
SELECT blogno,
           categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
           grpno, indent, ansnum
FROM blog
WHERE categoryno=1
ORDER BY grpno DESC, ansnum ASC;

 BLOGNO CATEGORYNO MNO TITLE CONTENT    GOOD THUMB       FILE1     SIZE1  CNT REPLYCNT RDATE                 GRPNO INDENT ANSNUM
 ------ ---------- --- ----- ---------- ---- ----------- --------- ------ --- -------- --------------------- ----- ------ ------
      3          1   3 바다건너  크리스마스에 갔던곳    0 win23_t.jpg win23.jpg 120488   0        0 2016-12-06 11:07:44.0     3      0      0

4) 전체 카운트
SELECT COUNT(*) as count
FROM blog;

 COUNT
 -----
     5

5) 조회
SELECT blogno,
           categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
           grpno, indent, ansnum
FROM blog
WHERE blogno=1; 

6) 수정
UPDATE blog
SET title='겨울', content='손이시려워...', thumb='snow_t.jpg', file1='snow.jpg', size1=1500
WHERE blogno=1;

7) 삭제
DELETE FROM blog
WHERE blogno=1 OR blogno=1;

8) 검색
-- title 컬럼으로 검색
SELECT blogno,
          categoryno, mno, title, good, thumb, file1, size1, cnt, replycnt, rdate, 
          grpno, indent, ansnum
FROM blog
WHERE categoryno=1 AND title LIKE '%휴가%'
ORDER BY blogno DESC;

-- content
SELECT blogno,
          categoryno, mno, title, good, thumb, file1, size1, cnt, replycnt, rdate, 
          grpno, indent, ansnum
FROM blog
WHERE categoryno=1 AND content LIKE '%휴가%'
ORDER BY blogno DESC;

-- 제목과 내용으로 검색
SELECT blogno,
          categoryno, mno, title, good, thumb, file1, size1, cnt, replycnt, rdate, 
          grpno, indent, ansnum
FROM blog
WHERE categoryno=1 AND  title LIKE '%휴가%' OR content LIKE '%휴가%'
ORDER BY blogno DESC;

9) 검색 및 전체 레코드 갯수
-- 검색하지 않는 경우 레코드 갯수
SELECT COUNT(*) as cnt
FROM blog
WHERE categoryno=1;

-- title 검색 레코드 갯수
SELECT COUNT(*) as cnt
FROM blog
WHERE categoryno=1 AND title LIKE '%휴가%';

-- content 검색 레코드 갯수
SELECT COUNT(*) as cnt
FROM blog
WHERE categoryno=1 AND content LIKE '%휴가%';

-- 제목과 내용으로 검색 레코드 갯수
SELECT COUNT(*) as cnt
FROM blog
WHERE categoryno=1 AND  title LIKE '%휴가%' OR content LIKE '%휴가%';


10) 페이징

DROP TABLE PG;

CREATE TABLE PG(
  num NUMBER(5) NOT NULL,
  title  VARCHAR(20) NOT NULL,
  PRIMARY KEY(num)
);

INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '01월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '02월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '03월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '04월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '05월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '06월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '07월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '08월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '09월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '10월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '11월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '12월');

SELECT num, title FROM pg;

 NUM TITLE
 --- -----
   1 01월
   2 02월
   3 03월
   4 04월
   5 05월
   6 06월
   7 07월
   8 08월
   9 09월
  10 10월
  11 11월
  12 12월

-- 분기별로 분할하여 레코드를 추출하는 경우(페이징)
SELECT num, title FROM pg;

-- rownum: oralce system에서 select시에 자동으로 붙여주는 일련번호
SELECT num, title, rownum FROM pg;

 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
   2 02월        2
   3 03월        3
   4 04월        4
   5 05월        5
   6 06월        6
   7 07월        7
   8 08월        8
   9 09월        9
  10 10월       10
  11 11월       11
  12 12월       12

-- 2,3월 삭제
DELETE FROM pg WHERE num=2 or num=3;

SELECT num, title, rownum FROM pg;

 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
   4 04월        2
   5 05월        3
   6 06월        4
   7 07월        5
   8 08월        6
   9 09월        7
  10 10월        8
  11 11월        9
  12 12월       10


-- 페이징시는 일정한 순차값이 생성되는 rownum 값을 사용합니다.
-- rownum주의: rownum은 정렬(ORDER BY ~)보다 먼저 생성됨으로
   정렬을 한 후 rownum 컬럼을 사용합니다.
   
-- Paging Step 1
SELECT num, title, rownum 
FROM pg
ORDER BY num ASC;

-- Paging Step 2, subquery
SELECT num, title, rownum
FROM (
           SELECT num, title 
           FROM pg
           ORDER BY num ASC
);
 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
   4 04월        2
   5 05월        3
   6 06월        4
   7 07월        5
   8 08월        6
   9 09월        7
  10 10월        8
  11 11월        9
  12 12월       10
  
-- 2,3 월을 추가하세요.
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '02월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '03월');

-- 목록 다시 출력, ☆ rownum이 생성되고 정렬 기능이 작동함
SELECT num, title, rownum
FROM pg
ORDER BY title ASC;
  
 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
  13 02월       11
  14 03월       12
   4 04월        2
   5 05월        3
   6 06월        4
   7 07월        5
   8 08월        6
   9 09월        7
  10 10월        8
  11 11월        9
  12 12월       10
  
-- Subquery에서 정렬후 rownum을 사용
SELECT num, title, rownum
FROM (
           SELECT num, title
           FROM pg
           ORDER BY title ASC
);

 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
  13 02월        2
  14 03월        3
   4 04월        4
   5 05월        5
   6 06월        6
   7 07월        7
   8 08월        8
   9 09월        9
  10 10월       10
  11 11월       11
  12 12월       12
  
-- Paging Step 3, subquery
-- 1 분기
SELECT num, title, r
FROM(
         SELECT num, title, rownum as r
         FROM (
                   SELECT num, title 
                   FROM pg
                   ORDER BY title ASC
         )  
)
WHERE r>=1 AND r <=3;

 NUM TITLE R
 --- ----- -
   1 01월   1
  13 02월   2
  14 03월   3
   
-- 2 분기
SELECT num, title, r
FROM(
         SELECT num, title, rownum as r
         FROM (
                   SELECT num, title 
                   FROM pg
                   ORDER BY title ASC
         )  
)
WHERE r>=4 AND r <=6;
   
 NUM TITLE R
 --- ----- -
   4 04월   4
   5 05월   5
   6 06월   6

   
* rownum은 최초 1페이지만 정상 처리되고 2페이부터는 WHERE문에서 
  인식이안됩니다. 따라서 3단 쿼리를 사용해야합니다.   
SELECT num, title, rownum
FROM (
          SELECT num, title 
          FROM pg
          ORDER BY title ASC
)  
WHERE rownum>=1 AND rownum <=3;

 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
  13 02월        2
  14 03월        3  

SELECT num, title, rownum
FROM (
          SELECT num, title 
          FROM pg
          ORDER BY title ASC
)  
WHERE rownum>=4 AND rownum <=6;


11) 페이징 구현
-- step 1
SELECT blogno, categoryno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate
FROM blog
WHERE categoryno=1
ORDER BY blogno DESC;

-- step 2         
SELECT blogno, categoryno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, rownum as r
FROM(
         SELECT blogno, categoryno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate
         FROM blog
         WHERE categoryno=1
         ORDER BY blogno DESC
);

-- step 3         
SELECT blogno, categoryno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, r
FROM(
         SELECT blogno, categoryno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, rownum as r
         FROM(
                  SELECT blogno, categoryno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate
                  FROM blog
                  WHERE categoryno=1
                  ORDER BY blogno DESC
         )
)
WHERE r >=1 AND r <= 3;

12) 답변
[답변 쓰기]
-- 1번글 기준 답변 등록예: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
SELECT * FROM categrp;
SELECT * FROM category;

1) 새로운 답변을 최신으로 등록하기위해 기존 답변을 뒤로 미룹니다.
UPDATE blog
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 1;

2) 답변 등록
INSERT INTO blog(blogno,
                          categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
                          grpno, indent, ansnum)  
VALUES((SELECT NVL(MAX(blogno), 0) + 1 as blogno FROM blog),
            1, 1, '제목', '내용',0, 'summer_m.jpg', 'summer.jpg', 0, 0, 0, sysdate,
            1, 1, 1);


3) 답변에 따른 정렬 순서 변경    
SELECT blogno, categoryno, mno, title, content, good, 
           thumb, file1, size1, cnt, replycnt, rdate, grpno, indent, ansnum, r
FROM(
         SELECT blogno, categoryno, mno, title, content, good,
                    thumb, file1, size1, cnt, replycnt, rdate, grpno, indent, ansnum, rownum as r
         FROM(
                  SELECT blogno, categoryno, mno, title, content, good,
                             thumb, file1, size1, cnt, replycnt, rdate, grpno, indent, ansnum
                  FROM blog
                  WHERE categoryno=1
                  ORDER BY grpno DESC, ansnum ASC
         )
)
WHERE r >=1 AND r <= 3;

     
-----------------------------------------------------------------------------------




