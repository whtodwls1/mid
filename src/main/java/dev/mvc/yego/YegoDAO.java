package dev.mvc.yego;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository("dev.mvc.yego.YegoDAO")
public class YegoDAO implements YegoDAOInter {
  
  @Autowired
  private SqlSessionTemplate mybatis; // MyBATIS 3 ¿¬°á °´Ã¼
  
  public YegoDAO(){
    System.out.println("--> YegoDAO created.");  
  }

  @Override
  public int create(YegoVO vo) {
    return mybatis.insert("yego.create", vo);
  }

  @Override
  public List<YegoVO> list() {
    // TODO Auto-generated method stub
    return mybatis.selectList("yego.list");
  }

  @Override
  public YegoVO read(int yegono) {
    // TODO Auto-generated method stub
    return mybatis.selectOne("yego.read",yegono);
  }

  @Override
  public int update(YegoVO vo) {
    // TODO Auto-generated method stub
    return mybatis.update("yego.update",vo);
  }

  @Override
  public int delete(int yegono) {
    // TODO Auto-generated method stub
    return mybatis.delete("yego.delete",yegono);
  }
}
