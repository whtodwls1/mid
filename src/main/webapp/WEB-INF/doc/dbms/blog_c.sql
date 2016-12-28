�� /webapp/WEB-INF/doc/dbms/blog_c.sql
-----------------------------------------------------------------------------------
DROP TABLE blog;
/**********************************/
/* Table Name: ��α� ���� */
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

COMMENT ON TABLE blog is '��α� ����';
COMMENT ON COLUMN blog.blogno is '��α׹�ȣ';
COMMENT ON COLUMN blog.categoryno is 'ī�װ���ȣ';
COMMENT ON COLUMN blog.mno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN blog.title is '����';
COMMENT ON COLUMN blog.content is '����';
COMMENT ON COLUMN blog.good is '��õ��';
COMMENT ON COLUMN blog.thumb is 'Thumb ����';
COMMENT ON COLUMN blog.file1 is '���� 1';
COMMENT ON COLUMN blog.size1 is '���� 1 ũ��';
COMMENT ON COLUMN blog.cnt is '��ȸ��';
COMMENT ON COLUMN blog.replycnt is '��ۼ�';
COMMENT ON COLUMN blog.rdate is '�����';
COMMENT ON COLUMN blog.grpno is '�׷��ȣ';
COMMENT ON COLUMN blog.indent is '�亯����';
COMMENT ON COLUMN blog.ansnum is '�亯 ����';


1) ���
-- member ȸ�� ���(���� 1)
SELECT mno, id, passwd, mname, tel, zipcode, address1, address2, mdate
FROM member
ORDER BY id ASC;

insert into mno,id,passwd,mname,tel,zipcode,address1,address2,mdate value 

 MNO ID    PASSWD MNAME TEL           ZIPCODE ADDRESS1                   ADDRESS2 MDATE
 --- ----- ------ ----- ------------- ------- -------------------------- -------- ---------------------
   1 user1 1234   �Ʒι�   111-1111-1111 00000   ��⵵                        ���ֽ�      2016-11-28 13:04:35.0
   2 user2 1234   �մ���   000-0000-0000 12345   ����� ���α�                    ��ö��      2016-11-28 13:04:36.0
   3 user3 1234   �մ���   000-0000-0000 12345   ����� ���α�                    ��ö��      2016-11-28 13:04:37.0
   4 user4 1234   �մ���   010-0000-0000 03154   ���� ���α� ���� 1 (����1��, �����������) 1        2016-11-28 13:17:11.0

-- category ī�װ� ���(���� 2)
SELECT categoryno, categrpno, title, seqno, visible, ids
FROM category 
ORDER BY seqno ASC;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 ---------- --------- ----- ----- ------- -----
          3         1 ��⵵       1 Y       admin
          1         2 ������       2 Y       admin
          2         2 �ƽþ�       3 Y       admin

              
-- blog ���� ���(���� 3)
- ���ο� ��, �亯 �ۿ����� ��� SQL���̰� �ֽ��ϴ�.
- ���ο� �� ����� ���ο� �׷��� ��������� ����� �ֽ��ϴ�. MAX + 1
INSERT INTO blog(blogno,
                          categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
                          grpno, indent, ansnum)  
VALUES((SELECT NVL(MAX(blogno), 0) + 1 as blogno FROM blog),
            1, 1, '����', '����', 0, 'fall_m.jpg', 'fall.jpg', 0, 0, 0, sysdate,
            (SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM blog), 0, 0);

-- ERROR: FK �÷��� ����� ���� �ٸ� ���̺� ����� �ȵǾ� �ִ� ���
    ORA-02291: integrity constraint (SOLDESK.SYS_C007131) violated - parent key not found
    ORA-02291: integrity constraint (SOLDESK.SYS_C007132) violated - parent key not found

2) ��ü ���(��� ����)
SELECT blogno,
           categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
           grpno, indent, ansnum
FROM blog
ORDER BY grpno DESC, ansnum ASC;

 BLOGNO CATEGORYNO MNO TITLE CONTENT GOOD THUMB      FILE1    SIZE1 CNT REPLYCNT RDATE                 GRPNO INDENT ANSNUM
 ------ -------------- --- ----- ------- ---- ---------- -------- ----- --- -------- --------------------- ----- ------ ------
      1              1   4 ����    ����         0 fall_m.jpg fall.jpg     0   0        0 2016-10-12 10:56:55.0     1      0      0

3) category �� ���(��� ����)
SELECT blogno,
           categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
           grpno, indent, ansnum
FROM blog
WHERE categoryno=1
ORDER BY grpno DESC, ansnum ASC;

 BLOGNO CATEGORYNO MNO TITLE CONTENT    GOOD THUMB       FILE1     SIZE1  CNT REPLYCNT RDATE                 GRPNO INDENT ANSNUM
 ------ ---------- --- ----- ---------- ---- ----------- --------- ------ --- -------- --------------------- ----- ------ ------
      3          1   3 �ٴٰǳ�  ũ���������� ������    0 win23_t.jpg win23.jpg 120488   0        0 2016-12-06 11:07:44.0     3      0      0

4) ��ü ī��Ʈ
SELECT COUNT(*) as count
FROM blog;

 COUNT
 -----
     5

5) ��ȸ
SELECT blogno,
           categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
           grpno, indent, ansnum
FROM blog
WHERE blogno=1; 

6) ����
UPDATE blog
SET title='�ܿ�', content='���̽÷���...', thumb='snow_t.jpg', file1='snow.jpg', size1=1500
WHERE blogno=1;

7) ����
DELETE FROM blog
WHERE blogno=1 OR blogno=1;

8) �˻�
-- title �÷����� �˻�
SELECT blogno,
          categoryno, mno, title, good, thumb, file1, size1, cnt, replycnt, rdate, 
          grpno, indent, ansnum
FROM blog
WHERE categoryno=1 AND title LIKE '%�ް�%'
ORDER BY blogno DESC;

-- content
SELECT blogno,
          categoryno, mno, title, good, thumb, file1, size1, cnt, replycnt, rdate, 
          grpno, indent, ansnum
FROM blog
WHERE categoryno=1 AND content LIKE '%�ް�%'
ORDER BY blogno DESC;

-- ����� �������� �˻�
SELECT blogno,
          categoryno, mno, title, good, thumb, file1, size1, cnt, replycnt, rdate, 
          grpno, indent, ansnum
FROM blog
WHERE categoryno=1 AND  title LIKE '%�ް�%' OR content LIKE '%�ް�%'
ORDER BY blogno DESC;

9) �˻� �� ��ü ���ڵ� ����
-- �˻����� �ʴ� ��� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM blog
WHERE categoryno=1;

-- title �˻� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM blog
WHERE categoryno=1 AND title LIKE '%�ް�%';

-- content �˻� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM blog
WHERE categoryno=1 AND content LIKE '%�ް�%';

-- ����� �������� �˻� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM blog
WHERE categoryno=1 AND  title LIKE '%�ް�%' OR content LIKE '%�ް�%';


10) ����¡

DROP TABLE PG;

CREATE TABLE PG(
  num NUMBER(5) NOT NULL,
  title  VARCHAR(20) NOT NULL,
  PRIMARY KEY(num)
);

INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '01��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '02��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '03��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '04��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '05��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '06��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '07��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '08��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '09��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '10��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '11��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '12��');

SELECT num, title FROM pg;

 NUM TITLE
 --- -----
   1 01��
   2 02��
   3 03��
   4 04��
   5 05��
   6 06��
   7 07��
   8 08��
   9 09��
  10 10��
  11 11��
  12 12��

-- �б⺰�� �����Ͽ� ���ڵ带 �����ϴ� ���(����¡)
SELECT num, title FROM pg;

-- rownum: oralce system���� select�ÿ� �ڵ����� �ٿ��ִ� �Ϸù�ȣ
SELECT num, title, rownum FROM pg;

 NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
   2 02��        2
   3 03��        3
   4 04��        4
   5 05��        5
   6 06��        6
   7 07��        7
   8 08��        8
   9 09��        9
  10 10��       10
  11 11��       11
  12 12��       12

-- 2,3�� ����
DELETE FROM pg WHERE num=2 or num=3;

SELECT num, title, rownum FROM pg;

 NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
   4 04��        2
   5 05��        3
   6 06��        4
   7 07��        5
   8 08��        6
   9 09��        7
  10 10��        8
  11 11��        9
  12 12��       10


-- ����¡�ô� ������ �������� �����Ǵ� rownum ���� ����մϴ�.
-- rownum����: rownum�� ����(ORDER BY ~)���� ���� ����������
   ������ �� �� rownum �÷��� ����մϴ�.
   
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
   1 01��        1
   4 04��        2
   5 05��        3
   6 06��        4
   7 07��        5
   8 08��        6
   9 09��        7
  10 10��        8
  11 11��        9
  12 12��       10
  
-- 2,3 ���� �߰��ϼ���.
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '02��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '03��');

-- ��� �ٽ� ���, �� rownum�� �����ǰ� ���� ����� �۵���
SELECT num, title, rownum
FROM pg
ORDER BY title ASC;
  
 NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
  13 02��       11
  14 03��       12
   4 04��        2
   5 05��        3
   6 06��        4
   7 07��        5
   8 08��        6
   9 09��        7
  10 10��        8
  11 11��        9
  12 12��       10
  
-- Subquery���� ������ rownum�� ���
SELECT num, title, rownum
FROM (
           SELECT num, title
           FROM pg
           ORDER BY title ASC
);

 NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
  13 02��        2
  14 03��        3
   4 04��        4
   5 05��        5
   6 06��        6
   7 07��        7
   8 08��        8
   9 09��        9
  10 10��       10
  11 11��       11
  12 12��       12
  
-- Paging Step 3, subquery
-- 1 �б�
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
   1 01��   1
  13 02��   2
  14 03��   3
   
-- 2 �б�
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
   4 04��   4
   5 05��   5
   6 06��   6

   
* rownum�� ���� 1�������� ���� ó���ǰ� 2���̺��ʹ� WHERE������ 
  �ν��̾ȵ˴ϴ�. ���� 3�� ������ ����ؾ��մϴ�.   
SELECT num, title, rownum
FROM (
          SELECT num, title 
          FROM pg
          ORDER BY title ASC
)  
WHERE rownum>=1 AND rownum <=3;

 NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
  13 02��        2
  14 03��        3  

SELECT num, title, rownum
FROM (
          SELECT num, title 
          FROM pg
          ORDER BY title ASC
)  
WHERE rownum>=4 AND rownum <=6;


11) ����¡ ����
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

12) �亯
[�亯 ����]
-- 1���� ���� �亯 ��Ͽ�: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
SELECT * FROM categrp;
SELECT * FROM category;

1) ���ο� �亯�� �ֽ����� ����ϱ����� ���� �亯�� �ڷ� �̷�ϴ�.
UPDATE blog
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 1;

2) �亯 ���
INSERT INTO blog(blogno,
                          categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
                          grpno, indent, ansnum)  
VALUES((SELECT NVL(MAX(blogno), 0) + 1 as blogno FROM blog),
            1, 1, '����', '����',0, 'summer_m.jpg', 'summer.jpg', 0, 0, 0, sysdate,
            1, 1, 1);


3) �亯�� ���� ���� ���� ����    
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




