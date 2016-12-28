package dev.mvc.mid;

import java.util.List;
import java.util.Map;

import dev.mvc.purchase.Mid_PurchaseVO;

public interface MidDAOInter {
  
public int create(MidVO  vo);
public List<MidVO> list();
public MidVO read(int midnum);
public int update(MidVO vo);
public int delete(int midnum);
public int viewcnt(int midnum);
public int uplike(Map map);
public List<MidVO> listgenre(String genre);
public List<Mid_PurchaseVO> listtitle(String midtitle);
public List<MidVO> midtitle(String midtitle);
}
