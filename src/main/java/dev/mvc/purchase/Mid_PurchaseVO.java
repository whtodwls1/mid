package dev.mvc.purchase;

public class Mid_PurchaseVO {
  //Mid table
 
  /** ȸ�� ���̵� */
  private String id;
  /** ȸ�� ��ȣ */
  private int mno;
  /** ���� ��¥ */
  /**���� ��ȣ */
  private int purnum;
  /**�̵� ��ȣ */
  private int midnum;
  /** �帣 */
  private String genre;
  /** Preview ���� �̹��� 200 X 150, �ڵ� ������ */
  private String thumb1  = "";
  /** ���� */
  private String midtitle;
  /** ���� */
  private long price = 0;
  /*��û�ϼ�*/
  private String regdate;
  /*����ϼ�*/
  private int watch;
  
  private String purreg;
  
  private String purreg1;
  
  public String getPurreg1() {
    return purreg1;
  }
  public void setPurreg1(String purreg1) {
    this.purreg1 = purreg1;
  }
  public int getPurnum() {
    return purnum;
  }
  public int getMidnum() {
    return midnum;
  }
  public String getGenre() {
    return genre;
  }
  public String getThumb1() {
    return thumb1;
  }
  public String getMidtitle() {
    return midtitle;
  }
  public long getPrice() {
    return price;
  }
  public String getRegdate() {
    return regdate;
  }

  public int getWatch() {
    return watch;
  }
  public void setPurnum(int purnum) {
    this.purnum = purnum;
  }
  public void setMidnum(int midnum) {
    this.midnum = midnum;
  }
  public void setGenre(String genre) {
    this.genre = genre;
  }
  public void setThumb1(String thumb1) {
    this.thumb1 = thumb1;
  }
  public void setMidtitle(String midtitle) {
    this.midtitle = midtitle;
  }
  public void setPrice(long price) {
    this.price = price;
  }
  public void setRegdate(String regdate) {
    this.regdate = regdate;
  }
  public void setWatch(int watch) {
    this.watch = watch;
  }
  public String getId() {
    return id;
  }
  public int getMno() {
    return mno;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setMno(int mno) {
    this.mno = mno;
  }
  public String getPurreg() {
    return purreg;
  }
  public void setPurreg(String purreg) {
    this.purreg = purreg;
  }

}
