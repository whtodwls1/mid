▷ /WEB-INF/doc/category_c.sql

1. DDL(Data Definition Language): 테이블 구조
-------------------------------------------------------------------------------------
-- FOREIGN KEY (categrpno) REFERENCES categrp (categrpno):
-- categrpno 컬럼의 값은 categrp 테이블의 categrpno 컬럼에 등록된 값만
-- 사용할 수 있습니다.  
/**********************************/
/* Table Name: 카테고리 */
/**********************************/
DROP TABLE blog;
DROP TABLE category;

CREATE TABLE category(
  categoryno      NUMBER(7)                                NOT NULL,
  title                 VARCHAR2(50)                            NOT NULL,
  seqno              NUMBER(3)        DEFAULT 1         NOT NULL,
  visible              CHAR(1)            DEFAULT 'Y'        NOT NULL,
  ids                   VARCHAR2(100) DEFAULT 'admin' NOT NULL,
  cnt                   NUMBER(6)       DEFAULT 0          NOT NULL,
  PRIMARY KEY(categoryno)
);

COMMENT ON TABLE category is '카테고리';
COMMENT ON COLUMN category.title is '게시판 이름';
COMMENT ON COLUMN category.seqno is '출력 순서';
COMMENT ON COLUMN category.visible is '출력 모드';
COMMENT ON COLUMN category.ids is '접근 계정';
COMMENT ON COLUMN category.cnt is '등록된 글 수';
COMMENT ON COLUMN category.categoryno is '코드번호';


2. 레코드 추가, 부모 테이블 PK 컬럼에 값이 있는 경우
   - 레코드 추가 순서: 부모 categrp -> 자식 category

INSERT INTO category(categoryno, title, seqno, visible, ids)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             '퇴마', 1 , 'Y', 'admin');

INSERT INTO category(categoryno, title, seqno, visible, ids)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             '로맨스', 2 ,'Y' , 'admin');

INSERT INTO category(categoryno, title, seqno, visible, ids)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             '코믹' , 3 , 'Y' , 'admin');

             
3. 목록
-- DELETE FROM category;

SELECT categoryno, title, seqno, visible, ids, cnt
FROM category  
ORDER BY seqno ASC;

             
4. 조회
SELECT categoryno, title, seqno, visible, ids
FROM category 
WHERE categoryno=1;

 CATEGORYNO TITLE SEQNO VISIBLE IDS
 ---------- ----- ----- ------- -----
          1 퇴마        1 Y       admin


5. 수정: title, seqno, visible, ids
UPDATE category
SET title='변경', seqno=1, visible='N', ids='admin1/user1/user2'
WHERE categoryno=1;

 CATEGORYNO TITLE SEQNO VISIBLE IDS
 ---------- --------- ----- ----- ------- ------------------
          1         변경        1 N       admin1/user1/user2

6. 삭제
- 레코드 삭제 순서: 자식 category -> 부모 categrp 

1) FK  테이블 삭제
DELETE FROM category 
WHERE categoryno = 1;

7. 출력 우선 순위 높임, 10 -> 1
UPDATE category 
SET seqno = seqno - 1 
WHERE categoryno=1;


8. 출력 우선 순서 낮춤, 1 -> 10
UPDATE category 
SET seqno = seqno + 1 
WHERE categoryno=1;


9. blog 글 추가에따른 등록된 글수의 증가
UPDATE category 
SET cnt = cnt + 1 
WHERE categoryno=1;


10. blog 글 삭제에따른 등록된 글수의 감소
UPDATE category 
SET cnt = cnt - 1 
WHERE categoryno=1;

-------------------------------------------------------------------------------------







