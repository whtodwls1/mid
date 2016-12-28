package dev.mvc.mid;

import org.springframework.web.multipart.MultipartFile;

public class MidVO {
/*
   
    midnum                            NUMBER(10)     NOT NULL    PRIMARY KEY,
    genre                              VARCHAR2(10)   not null,
    midtitle                              VARCHAR2(50)   not null,
    thumb1                            VARCHAR2(100)    NULL ,
    poster                            VARCHAR2(100)    NULL ,
    file2                             VARCHAR2(50)     NULL ,
    price                             NUMBER(10)     NOT NULL,
    watch                             DATE     NOT NULL,
    viewcnt                           NUMBER(10)     NOT NULL,
    regdate                           DATE     NOT NULL);
    midlike    
*/
  /** �� ��ȣ */
  private int midnum;

  /** �帣 */
  private String genre;
  /*����*/
  private String midtitle;

  /** Preview ���� �̹��� 200 X 150, �ڵ� ������ */
  private String thumb1  = "";
  /*���� �̹���*/
  private String poster="";
  /** ���ε� ���� */
  private String file2 = "";
  /** �̵� ���� */
  private String midcontent ="";
  /** ���� */
  private long price = 0;
  /*��û�ϼ�*/
  private int watch;
  /*��ȸ*/
  private int viewcnt;
/*��¥*/
  private String regdate;
  private int midlike=0;   
  public int getMidlike() {
    return midlike;
  }

  public void setMidlike(int midlike) {
    this.midlike = midlike;
  }

  /** Spring Framework���� �ڵ� ���ԵǴ� ���ε� ���� ��ü,
       ���� �÷��� �������� ����.
  */  
  private MultipartFile file1MF;
  
  private MultipartFile file2MF;
  
  public MultipartFile getFile2MF() {
    return file2MF;
  }

  public void setFile2MF(MultipartFile file2mf) {
    file2MF = file2mf;
  }

  /** size1�� �ĸ� ���� ��¿� ����, ���� �÷��� �������� ����. */
  private String size1Label;


  public int getMidnum() {
    return midnum;
  }

  public void setMidnum(int midnum) {
    this.midnum = midnum;
  }

  public String getGenre() {
    return genre;
  }

  public void setGenre(String genre) {
    this.genre = genre;
  }
  public String getMidtitle() {
    return midtitle;
  }

  public void setMidtitle(String midtitle) {
    this.midtitle = midtitle;
  }


  public String getThumb1() {
    return thumb1;
  }

  public void setThumb1(String thumb1) {
    this.thumb1 = thumb1;
  }

  public String getPoster() {
    return poster;
  }

  public void setPoster(String poster) {
    this.poster = poster;
  }

  public String getFile2() {
    return file2;
  }

  public void setFile2(String file2) {
    this.file2 = file2;
  }

  public long getPrice() {
    return price;
  }

  public void setPrice(long price) {
    this.price = price;
  }

  public int getWatch() {
    return watch;
  }

  public void setWatch(int watch) {
    this.watch = watch;
  }

  public int getViewcnt() {
    return viewcnt;
  }

  public void setViewcnt(int viewcnt) {
    this.viewcnt = viewcnt;
  }

  public String getRegdate() {
    return regdate;
  }

  public void setRegdate(String regdate) {
    this.regdate = regdate;
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
  public String getMidcontent() {
    return midcontent;
  }

  public void setMidcontent(String midcontent) {
    this.midcontent = midcontent;
  }


  
}




