DROP TABLE midcomment CASCADE CONSTRAINTS;
DROP TABLE yego CASCADE CONSTRAINTS;
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
		MDATE                         		DATE		 NOT NULL
		
  CONSTRAINT SYS_C007004 UNIQUE (ID)
);
select * from member;
SELECT mno, id, passwd, mname, tel, zipcode, address1, address2, mdate
    FROM member
    WHERE id = 'admin';

INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'user1', '1234', '왕눈이', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'user2', '1234', '왕눈이', '000-0000-0000', '12345', '서울시 종로구', '관철동', sysdate);
 
INSERT INTO member(mno, id, passwd, mname, tel, zipcode, address1, address2, mdate)
VALUES ((SELECT NVL(MAX(mno), 0)+1 as mno FROM member),
'admin', '1234', '왕눈이', '000-0000-0000', '1234', '서울시 종로구', '관철동', sysdate);

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
COMMENT ON COLUMN MEMBER.v is '구매여부';


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
select * from blog;
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
		midtitle                      		VARCHAR2(500)		 NOT NULL,
		genre                         		VARCHAR2(10)		 NOT NULL,
		thumb1                        		VARCHAR2(500)		 NULL ,
		poster                        		VARCHAR2(500)		 NULL ,
		file2                         		VARCHAR2(500)		 NULL ,
		midcontent                    		VARCHAR2(500)		 NOT NULL,
		price                         		NUMBER(10)		 NOT NULL,
		watch                         		NUMBER(6)		 DEFAULT 0		 NOT NULL,
		viewcnt                       		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		regdate                       		DATE		 NOT NULL,
		midlike                           Number(10) null
);
 select * from mid;
    update mid
    set midlike=midlike+1
    where midnum=2;
     update mid
    set midlike=midlike+1
    where midnum=1;
COMMENT ON TABLE mid is '미드';
COMMENT ON COLUMN mid.midnum is '미드번호';
COMMENT ON COLUMN mid.midtitle is '제목';
COMMENT ON COLUMN mid.genre is '미드 종류';
COMMENT ON COLUMN mid.thumb1 is '손톱이미지';
COMMENT ON COLUMN mid.poster is '포스터 큰 이미지';
COMMENT ON COLUMN mid.file2 is '파일명';
COMMENT ON COLUMN mid.midcontent is '내용';
COMMENT ON COLUMN mid.price is '금액';
COMMENT ON COLUMN mid.watch is '시청가능일수';
COMMENT ON COLUMN mid.viewcnt is '조회수';
COMMENT ON COLUMN mid.regdate is '등록일';


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


select * from purchase;
COMMENT ON TABLE purchase is '구매';
COMMENT ON COLUMN purchase.purnum is '구매번호';
COMMENT ON COLUMN purchase.midnum is '미드번호';
COMMENT ON COLUMN purchase.MNO is '회원번호';
COMMENT ON COLUMN purchase.purreg is '구매날짜';


/**********************************/
/* Table Name: 미드 예고편 */
/**********************************/
CREATE TABLE yego(
    yegono                            NUMBER(10)     NOT NULL    PRIMARY KEY,
    yegotitle                         VARCHAR2(500)   NOT NULL,
    yegoimage                         VARCHAR2(500)    NULL ,
    yegothumb                         VARCHAR2(500)    NULL  ,
    file3                             VARCHAR2(500)    NULL
    
);

COMMENT ON TABLE yego is '미드 예고편';
COMMENT ON COLUMN yego.yegono is '예고편 번호';
COMMENT ON COLUMN yego.yegotitle is '예고편 제목';
COMMENT ON COLUMN yego.yegoimage is '예고편 이미지';
COMMENT ON COLUMN yego.file3 is '예고편 덤프';
COMMENT ON COLUMN yego.file3 is '파일명';


/**********************************/
/* Table Name: 미드 댓글게시판 */
/**********************************/
CREATE TABLE midcomment(
		comment_no                    		NUMBER(7)		 NOT NULL		 PRIMARY KEY,
		comment_id                    		VARCHAR2(20)		 NOT NULL,
		comments                      		VARCHAR2(200)		 NOT NULL,
		comment_date                  		DATE		 DEFAULT sysdate		 NULL ,
		midnum                        		NUMBER(10)		 NULL ,
  FOREIGN KEY (midnum) REFERENCES mid (midnum)
);

COMMENT ON TABLE midcomment is '미드 댓글게시판';
COMMENT ON COLUMN midcomment.comment_no is '댓글 번호';
COMMENT ON COLUMN midcomment.comment_id is '댓글 아이디';
COMMENT ON COLUMN midcomment.comments is '댓글';
COMMENT ON COLUMN midcomment.comment_date is '댓글 등록일';
COMMENT ON COLUMN midcomment.midnum is '미드번호';

select *
 from mid 
where midtitle LIKE '%' || '해커' || '%'


   SELECT d.midnum,d.midtitle, d.thumb1,d.price,'20'||to_char(to_date(p.purreg)) as purreg,  '20'||to_char(to_date(p.purreg + d.watch)) as purreg1, d.watch
FROM purchase p, mid d 
WHERE d.midtitle LIKE '%' || '해커' || '%'
