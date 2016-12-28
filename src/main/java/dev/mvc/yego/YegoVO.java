package dev.mvc.yego;

import org.springframework.web.multipart.MultipartFile;

public class YegoVO {
  /*CREATE TABLE yego(
      yegono                            NUMBER(10)     NOT NULL    PRIMARY KEY,
      yegotitle                         VARCHAR2(500)   NOT NULL,
      yegoimage                         VARCHAR2(500)    NULL ,
      file3                             VARCHAR2(500)    NULL
  );*/
  
  private int yegono;
  private String yegotitle;
  private String yegoimage;
  private String yegothumb;
  private MultipartFile file3MF;
  private MultipartFile file4MF;
  
  
  public MultipartFile getFile4MF() {
    return file4MF;
  }
  public void setFile4MF(MultipartFile file4mf) {
    file4MF = file4mf;
  }
  public String getYegothumb() {
    return yegothumb;
  }
  public void setYegothumb(String yegothumb) {
    this.yegothumb = yegothumb;
  }
  private String file3;
  
  public int getYegono() {
    return yegono;
  }
  public String getYegotitle() {
    return yegotitle;
  }
  public String getYegoimage() {
    return yegoimage;
  }
  
  public String getFile3() {
    return file3;
  }
  public void setYegono(int yegono) {
    this.yegono = yegono;
  }
  public void setYegotitle(String yegotitle) {
    this.yegotitle = yegotitle;
  }
  public void setYegoimage(String yegoimage) {
    this.yegoimage = yegoimage;
  }
  public void setFile3(String file3) {
    this.file3 = file3;
  }
  
  

  public MultipartFile getFile3MF() {
    return file3MF;
  }
  public void setFile3MF(MultipartFile file3mf) {
    file3MF = file3mf;
  }
  
}
