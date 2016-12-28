package dev.mvc.blog;

import org.springframework.web.multipart.MultipartFile;

public class BlogVO {
/*
        blogno               NUMBER(7)        NOT NULL        PRIMARY KEY,
        categoryno         NUMBER(7)        NULL ,
        MNO                 NUMBER(6)        NULL ,
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
        
*/
  /** �� ��ȣ */
  private int blogno;
  /** �Խ��� �׷� ��ȣ */
  private int categoryno;
  /** ȸ�� ��ȣ */
  private int mno;
  /** ���� */
  private String title;
  /** ���� */
  private String content;
  /** ��õ �� */
  private int good;
  /** Preview ���� �̹��� 200 X 150, �ڵ� ������ */
  private String thumb = "";
  /** ���ε� ���� */
  private String file1 = "";
  /** ���ε�� ���� ũ�� */
  private long size1 = 0;
  /** ��ȸ�� */
  private int cnt = 0;
  /** �亯 ���� */
  private int replycnt;
  /** ����� */
  private String rdate;
  /** �׷� ��ȣ */ 
  private int grpno;
  /** �亯 ���� */
  private int indent;
  /** �亯 ���� */
  private int ansnum;
  
  /** Spring Framework���� �ڵ� ���ԵǴ� ���ε� ���� ��ü,
       ���� �÷��� �������� ����.
  */  
  private MultipartFile file1MF;
  
  /** size1�� �ĸ� ���� ��¿� ����, ���� �÷��� �������� ����. */
  private String size1Label;

  public int getBlogno() {
    return blogno;
  }

  public void setBlogno(int blogno) {
    this.blogno = blogno;
  }

  public int getCategoryno() {
    return categoryno;
  }

  public void setCategoryno(int categoryno) {
    this.categoryno = categoryno;
  }

  public int getMno() {
    return mno;
  }

  public void setMno(int mno) {
    this.mno = mno;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public int getGood() {
    return good;
  }

  public void setGood(int good) {
    this.good = good;
  }

  public String getThumb() {
    return thumb;
  }

  public void setThumb(String thumb) {
    this.thumb = thumb;
  }

  public String getFile1() {
    return file1;
  }

  public void setFile1(String file1) {
    this.file1 = file1;
  }

  public long getSize1() {
    return size1;
  }

  public void setSize1(long size1) {
    this.size1 = size1;
  }

  public int getCnt() {
    return cnt;
  }

  public void setCnt(int cnt) {
    this.cnt = cnt;
  }

  public int getReplycnt() {
    return replycnt;
  }

  public void setReplycnt(int replycnt) {
    this.replycnt = replycnt;
  }

  public String getRdate() {
    return rdate;
  }

  public void setRdate(String rdate) {
    this.rdate = rdate;
  }

  public int getGrpno() {
    return grpno;
  }

  public void setGrpno(int grpno) {
    this.grpno = grpno;
  }

  public int getIndent() {
    return indent;
  }

  public void setIndent(int indent) {
    this.indent = indent;
  }

  public int getAnsnum() {
    return ansnum;
  }

  public void setAnsnum(int ansnum) {
    this.ansnum = ansnum;
  }

  public MultipartFile getFile1MF() {
    return file1MF;
  }

  public void setFile1MF(MultipartFile file1mf) {
    file1MF = file1mf;
  }

  public String getSize1Label() {
    return size1Label;
  }

  public void setSize1Label(String size1Label) {
    this.size1Label = size1Label;
  } 
    

  
}




