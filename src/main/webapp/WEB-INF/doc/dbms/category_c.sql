�� /WEB-INF/doc/category_c.sql

1. DDL(Data Definition Language): ���̺� ����
-------------------------------------------------------------------------------------
-- FOREIGN KEY (categrpno) REFERENCES categrp (categrpno):
-- categrpno �÷��� ���� categrp ���̺��� categrpno �÷��� ��ϵ� ����
-- ����� �� �ֽ��ϴ�.  
/**********************************/
/* Table Name: ī�װ� */
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

COMMENT ON TABLE category is 'ī�װ�';
COMMENT ON COLUMN category.title is '�Խ��� �̸�';
COMMENT ON COLUMN category.seqno is '��� ����';
COMMENT ON COLUMN category.visible is '��� ���';
COMMENT ON COLUMN category.ids is '���� ����';
COMMENT ON COLUMN category.cnt is '��ϵ� �� ��';
COMMENT ON COLUMN category.categoryno is '�ڵ��ȣ';


2. ���ڵ� �߰�, �θ� ���̺� PK �÷��� ���� �ִ� ���
   - ���ڵ� �߰� ����: �θ� categrp -> �ڽ� category

INSERT INTO category(categoryno, title, seqno, visible, ids)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             '��', 1 , 'Y', 'admin');

INSERT INTO category(categoryno, title, seqno, visible, ids)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             '�θǽ�', 2 ,'Y' , 'admin');

INSERT INTO category(categoryno, title, seqno, visible, ids)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             '�ڹ�' , 3 , 'Y' , 'admin');

             
3. ���
-- DELETE FROM category;

SELECT categoryno, title, seqno, visible, ids, cnt
FROM category  
ORDER BY seqno ASC;

             
4. ��ȸ
SELECT categoryno, title, seqno, visible, ids
FROM category 
WHERE categoryno=1;

 CATEGORYNO TITLE SEQNO VISIBLE IDS
 ---------- ----- ----- ------- -----
          1 ��        1 Y       admin


5. ����: title, seqno, visible, ids
UPDATE category
SET title='����', seqno=1, visible='N', ids='admin1/user1/user2'
WHERE categoryno=1;

 CATEGORYNO TITLE SEQNO VISIBLE IDS
 ---------- --------- ----- ----- ------- ------------------
          1         ����        1 N       admin1/user1/user2

6. ����
- ���ڵ� ���� ����: �ڽ� category -> �θ� categrp 

1) FK  ���̺� ����
DELETE FROM category 
WHERE categoryno = 1;

7. ��� �켱 ���� ����, 10 -> 1
UPDATE category 
SET seqno = seqno - 1 
WHERE categoryno=1;


8. ��� �켱 ���� ����, 1 -> 10
UPDATE category 
SET seqno = seqno + 1 
WHERE categoryno=1;


9. blog �� �߰������� ��ϵ� �ۼ��� ����
UPDATE category 
SET cnt = cnt + 1 
WHERE categoryno=1;


10. blog �� ���������� ��ϵ� �ۼ��� ����
UPDATE category 
SET cnt = cnt - 1 
WHERE categoryno=1;

-------------------------------------------------------------------------------------







