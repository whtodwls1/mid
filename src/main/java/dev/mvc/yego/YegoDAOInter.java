package dev.mvc.yego;

import java.util.List;

import dev.mvc.mid.MidVO;





public interface YegoDAOInter {
  
  public int create(YegoVO vo);
  public List<YegoVO> list();
  public YegoVO read(int yegono);
  public int update(YegoVO vo);
  public int delete(int yegono);
}
