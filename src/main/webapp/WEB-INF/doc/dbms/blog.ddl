/**********************************/
/* Table Name: 카테고리 그룹 */
/**********************************/
CREATE TABLE categrp(
		categrpno                     		NUMBER(7)		 NOT NULL		 PRIMARY KEY,
		name                          		VARCHAR2(50)		 NOT NULL,
		seqno                         		NUMBER(7)		 DEFAULT 0		 NOT NULL
);

COMMENT ON TABLE categrp is '카테고리 그룹';
COMMENT ON COLUMN categrp.categrpno is '카테고리 그룹 번호';
COMMENT ON COLUMN categrp.name is '이름';
COMMENT ON COLUMN categrp.seqno is '출력 순서';


/**********************************/
/* Table Name: 카테고리 */
/**********************************/
CREATE TABLE category(

);

COMMENT ON TABLE category is '카테고리';


/**********************************/
/* Table Name: 블로그 내용 */
/**********************************/
CREATE TABLE blog(

);

COMMENT ON TABLE blog is '블로그 내용';


/**********************************/
/* Table Name: MEMBER */
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
  CONSTRAINT SYS_C007004 UNIQUE (ID)
);

COMMENT ON TABLE MEMBER is 'MEMBER';
COMMENT ON COLUMN MEMBER.MNO is 'MNO';
COMMENT ON COLUMN MEMBER.ID is 'ID';
COMMENT ON COLUMN MEMBER.PASSWD is 'PASSWD';
COMMENT ON COLUMN MEMBER.MNAME is 'MNAME';
COMMENT ON COLUMN MEMBER.TEL is 'TEL';
COMMENT ON COLUMN MEMBER.ZIPCODE is 'ZIPCODE';
COMMENT ON COLUMN MEMBER.ADDRESS1 is 'ADDRESS1';
COMMENT ON COLUMN MEMBER.ADDRESS2 is 'ADDRESS2';
COMMENT ON COLUMN MEMBER.MDATE is 'MDATE';


