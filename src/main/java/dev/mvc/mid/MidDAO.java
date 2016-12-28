package dev.mvc.mid;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dev.mvc.purchase.Mid_PurchaseVO;

@Repository("dev.mvc.mid.MidDAO")
public class MidDAO implements MidDAOInter{
  @Autowired
  private SqlSessionTemplate mybatis; // MyBATIS 3 ¿¬°á °´Ã¼

  public MidDAO(){
    System.out.println("--> BlogDAO created.");  
  }

  @Override
  public int create(MidVO vo) {
    return mybatis.insert("mid.create",vo);
  }

  @Override
  public List<MidVO> list() {
    return mybatis.selectList("mid.list");
  }

  @Override
  public MidVO read(int midnum) {
    return mybatis.selectOne("mid.read",midnum);
  }

  @Override
  public int update(MidVO vo) {
    return mybatis.update("mid.update",vo);
  }

  @Override
  public int delete(int midnum) {
    return mybatis.delete("mid.delete",midnum);
  }
  @Override
  public int viewcnt(int midnum) {
    // TODO Auto-generated method stub
    return mybatis.update("mid.viewcnt", midnum);
  }

  @Override
  public List<MidVO> listgenre(String genre) {
    return mybatis.selectList("mid.listgenre",genre);
  }

  @Override
  public List<Mid_PurchaseVO> listtitle(String midtitle) {
    return mybatis.selectList("mid.listtitle",midtitle);
  }

  @Override
  public int uplike(Map map) {
    return mybatis.update("mid.uplike",map);
  }

  @Override
  public List<MidVO> midtitle(String midtitle) {
    return mybatis.selectList("mid.midtitle",midtitle);
  }


 
}
