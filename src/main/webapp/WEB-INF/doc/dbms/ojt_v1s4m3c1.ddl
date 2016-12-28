DROP TABLE purchase CASCADE CONSTRAINTS;
DROP TABLE mid CASCADE CONSTRAINTS;
DROP TABLE BLOG CASCADE CONSTRAINTS;
DROP TABLE MEMBER CASCADE CONSTRAINTS;
DROP TABLE category CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: 카테고리 */
/**********************************/
CREATE TABLE category(
		categoryno                    		NUMBER(7)		 NOT NULL		 PRIMARY KEY,
		title                         		VARCHAR2(50)		 NOT NULL,
		seqno                         		NUMBER(3)		 DEFAULT 1		 NOT NULL,
		visible                       		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		ids                           		VARCHAR2(100)		 DEFAULT 'admin'		 NOT NULL,
		cnt                           		NUMBER(6)		 DEFAULT 0		 NOT NULL
);

COMMENT ON TABLE category is '카테고리';
COMMENT ON COLUMN category.categoryno is '카테고리 번호';
COMMENT ON COLUMN category.title is '게시판 이름';
COMMENT ON COLUMN category.seqno is '출력 순서';
COMMENT ON COLUMN category.visible is '출력 모드';
COMMENT ON COLUMN category.ids is '접근 계정';
COMMENT ON COLUMN category.cnt is '등록된 글 수';


/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE MEMBER(
		MNO                           		NUMBER(6)		 NOT NULL		 PRIMARY KEY,
		ID                            		VARCHAR2(20)		 NOT NULL,
		PASSWD                        		VARCHAR2(20)		 NOT NULL,
		MNAME                         		VARCHAR2(20)		 NOT NULL,
		TEL                           		VARCHAR2(14)		 NOT NULL,
		ZIPCODE                       		VARCHAR2(5)		 NULL ,
		ADDRESS1                      		VARCHAR2(80)		 NULL ,
		ADDRESS2                      		VARCHAR2(50)		 NULL ,
		MDATE                         		DATE		 NOT NULL,
		mlevelno                      		NUMBER(7)		 NULL ,
  CONSTRAINT SYS_C007004 UNIQUE (ID)
);

COMMENT ON TABLE MEMBER is '회원';
COMMENT ON COLUMN MEMBER.MNO is '회원번호';
COMMENT ON COLUMN MEMBER.ID is 'ID';
COMMENT ON COLUMN MEMBER.PASSWD is 'PASSWD';
COMMENT ON COLUMN MEMBER.MNAME is 'MNAME';
COMMENT ON COLUMN MEMBER.TEL is 'TEL';
COMMENT ON COLUMN MEMBER.ZIPCODE is 'ZIPCODE';
COMMENT ON COLUMN MEMBER.ADDRESS1 is 'ADDRESS1';
COMMENT ON COLUMN MEMBER.ADDRESS2 is 'ADDRESS2';
COMMENT ON COLUMN MEMBER.MDATE is 'MDATE';
COMMENT ON COLUMN MEMBER.mlevelno is '등급번호';

INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'user1', '1234', '왕눈이', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'user2', '1234', '왕눈이', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'user3', '1234', '왕눈이', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);


/**********************************/
/* Table Name: 블로그 */
/**********************************/
CREATE TABLE BLOG(
		BLOGNO                        		NUMBER(7)		 NOT NULL		 PRIMARY KEY,
		categoryno                    		NUMBER(7)		 NULL ,
		MNO                           		NUMBER(6)		 NULL ,
		TITLE                         		VARCHAR2(200)		 NOT NULL,
		CONTENT                       		VARCHAR2(4000)		 NOT NULL,
		GOOD                          		NUMBER(7)		 NOT NULL,
		THUMB                         		VARCHAR2(100)		 NULL ,
		FILE1                         		VARCHAR2(50)		 NULL ,
		SIZE1                         		NUMBER(9)		 NULL ,
		CNT                           		NUMBER(7)		 NOT NULL,
		REPLYCNT                      		NUMBER(7)		 NOT NULL,
		RDATE                         		DATE		 NOT NULL,
		GRPNO                         		NUMBER(7)		 NOT NULL,
		INDENT                        		NUMBER(2)		 NOT NULL,
		ANSNUM                        		NUMBER(5)		 NOT NULL,
  FOREIGN KEY (MNO) REFERENCES MEMBER (MNO),
  FOREIGN KEY (categoryno) REFERENCES category (categoryno)
);

COMMENT ON TABLE BLOG is '블로그';
COMMENT ON COLUMN BLOG.BLOGNO is '블로그 번호';
COMMENT ON COLUMN BLOG.categoryno is '카테고리 번호';
COMMENT ON COLUMN BLOG.MNO is 'MNO';
COMMENT ON COLUMN BLOG.TITLE is 'TITLE';
COMMENT ON COLUMN BLOG.CONTENT is 'CONTENT';
COMMENT ON COLUMN BLOG.GOOD is 'GOOD';
COMMENT ON COLUMN BLOG.THUMB is 'THUMB';
COMMENT ON COLUMN BLOG.FILE1 is 'FILE1';
COMMENT ON COLUMN BLOG.SIZE1 is 'SIZE1';
COMMENT ON COLUMN BLOG.CNT is 'CNT';
COMMENT ON COLUMN BLOG.REPLYCNT is 'REPLYCNT';
COMMENT ON COLUMN BLOG.RDATE is 'RDATE';
COMMENT ON COLUMN BLOG.GRPNO is 'GRPNO';
COMMENT ON COLUMN BLOG.INDENT is 'INDENT';
COMMENT ON COLUMN BLOG.ANSNUM is 'ANSNUM';


/**********************************/
/* Table Name: 미드 */
/**********************************/
CREATE TABLE mid(
		midnum                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		midtitle                           VARCHAR2(500) not null,
		genre                              VARCHAR2(10)   not null,
		thumb1                        		VARCHAR2(500)		 NULL ,
		poster                        		VARCHAR2(500)		 NULL ,
		file2                         		VARCHAR2(50)		 NULL ,
		midcontent                        VARCHAR2(500)  NOT NULL,
		price                         		NUMBER(10)		 NOT NULL,
		watch                         		NUMBER(6)	 NOT NULL,
		viewcnt                       		NUMBER(10)		 NOT NULL,
		regdate                       		DATE		 NOT NULL);
		
		
		drop table mid;
		midnum    genre    thumb1     poster    file2    price    watch    viewcnt regdate
--		추가
		insert into mid(midnum,midtitle,genre,thumb1,poster,file2,midcontent,price,watch,viewcnt,regdate)
		values((select NVL(max(midnum),0)+1 as midnum from mid),'gss','df','sd','sd','sd','dadfadfasdfaasdfasdfadsfadf',13,12,12,sysdate);
		
		
--		수정
		update mid
		set genre='sd', thumb1='sd',poster='sd',file2='sd',price=1,watch=1,viewcnt=1,regdate=sysdate
		where midnum=1;
		-- 삭제
		delete from MID
		where midnum=1;
		-- 검색
		select * from MID
		order by midnum desc;
		-- 한개 출력
   select * from MID;
		where midnum=1;
COMMENT ON TABLE mid is '미드';
COMMENT ON COLUMN mid.midnum is '미드번호';
COMMENT ON COLUMN mid.thumb1 is '손톱이미지';
COMMENT ON COLUMN mid.poster is '포스터 큰 이미지';
COMMENT ON COLUMN mid.file2 is '파일명';
COMMENT ON COLUMN mid.price is '금액';
COMMENT ON COLUMN mid.watch is '시청가능일수';
COMMENT ON COLUMN mid.viewcnt is '조회수';
COMMENT ON COLUMN mid.regdate is '등록일';

drop table mid;
/**********************************/
/* Table Name: 구매 */
/**********************************/
CREATE TABLE purchase(
		purnum                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		midnum                        		NUMBER(10)		 NULL ,
		MNO                           		NUMBER(6)		 NULL ,
		purreg                        		DATE		 NOT NULL,

  FOREIGN KEY (midnum) REFERENCES mid (midnum),
  FOREIGN KEY (MNO) REFERENCES MEMBER (MNO)
);
drop table purchase;

INSERT INTO purchase(purnum,midnum, mno, purreg, endreg)  
VALUES((SELECT NVL(MAX(purnum), 0) + 1 as purnum FROM purchase),
            1, 1, sysdate, sysdate);
            
            INSERT INTO purchase(purnum,midnum, mno, purreg, endreg)  
VALUES((SELECT NVL(MAX(purnum), 0) + 1 as purnum FROM purchase),
            2, 2, sysdate, sysdate);
            
            INSERT INTO purchase(purnum,midnum, mno, purreg, endreg)  
VALUES((SELECT NVL(MAX(purnum), 0) + 1 as purnum FROM purchase),
            3, 3, sysdate, sysdate);
            
                  INSERT INTO purchase(purnum,midnum, mno, purreg, endreg)  
VALUES((SELECT NVL(MAX(purnum), 0) + 1 as purnum FROM purchase),
            13, 3, sysdate, sysdate);

select * from purchase;
           
COMMENT ON TABLE purchase is '구매';
COMMENT ON COLUMN purchase.purnum is '구매번호';
COMMENT ON COLUMN purchase.midnum is '미드번호';
COMMENT ON COLUMN purchase.MNO is '회원번호';
COMMENT ON COLUMN purchase.purreg is '구매날짜';
COMMENT ON COLUMN purchase.endreg is '종료날짜';


select * from purchase;

조인

SELECT m.mno, m.id,d.midnum,d.genre,d.thumb1, d.midtitle, d.price, d.regdate, d.watch, p.purnum, p.midnum        
FROM purchase p, mid d , member m
WHERE p.midnum = d.midnum AND m.mno = p.mno
ORDER BY d.midnum ASC, d.midtitle ASC;


구매하기 리스트 조인
SELECT d.midtitle, d.thumb1,d.price,'20'||to_char(to_date(p.purreg)) as purreg,  '20'||to_char(to_date(p.purreg + d.watch)) as purreg1, d.watch
FROM purchase p, mid d 
WHERE p.midnum = d.midnum;


INSERT INTO purchase(purnum,midnum, mno, purreg)  
VALUES((SELECT NVL(MAX(purnum), 0) + 1 as purnum FROM purchase),
            13, 1, sysdate);
            INSERT INTO purchase(purnum,midnum, mno, purreg)  
VALUES((SELECT NVL(MAX(purnum), 0) + 1 as purnum FROM purchase),14, 1, sysdate);

select * from purchase;

수정(업데이트)

UPDATE m.midnum  
SET categrpno=1, title='변경', seqno=1, visible='N', ids='admin1/user1/user2'
WHERE categoryno=1;


삭제 
DELETE FROM purchase
WHERE purnum = 3;
 
select * from mid;

SELECT d.midtitle, d.thumb1,d.watch ,d.price
FROM purchase p, mid d 
WHERE p.midnum = d.midnum;

SELECT  DISTINCT d.midtitle, d.thumb1,d.watch ,d.price
FROM purchase p, mid d 
WHERE d.midnum = 14;


