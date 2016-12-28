package dev.mvc.purchase;

public class PurchaseVO {
 /* CREATE TABLE purchase(
      purnum                            NUMBER(10)     NOT NULL    PRIMARY KEY,
      midnum                            NUMBER(10)     NULL ,
      MNO                               NUMBER(6)    NULL ,
      purreg                            DATE     NOT NULL,
      endreg                            DATE     NOT NULL,
    FOREIGN KEY (midnum) REFERENCES mid (midnum),
    FOREIGN KEY (MNO) REFERENCES MEMBER (MNO)
  );*/

  /** �ֹ� ��ȣ */
  private int purnum;
  /** �̵� ��ȣ */
  private int midnum;
  /** ȸ�� ��ȣ */
  private int mno;
  /** ���� ��¥ */
  private String purreg;

  
  public int getPurnum() {
    return purnum;
  }
  public int getMidnum() {
    return midnum;
  }
  public int getMno() {
    return mno;
  }
  public String getPurreg() {
    return purreg.substring(0,10);
  }

  public void setPurnum(int purnum) {
    this.purnum = purnum;
  }
  public void setMidnum(int midnum) {
    this.midnum = midnum;
  }
  public void setMno(int mno) {
    this.mno = mno;
  }
  public void setPurreg(String purreg) {
    this.purreg = purreg;
  }

}
