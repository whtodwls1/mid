package dev.mvc.purchase;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository("dev.mvc.purchase.PurchaseDAO")
public class PurchaseDAO implements PurchaseDAOInter {
  
  @Autowired
  private SqlSessionTemplate mybatis; // MyBATIS 3 ¿¬°á °´Ã¼
  
  public PurchaseDAO(){
    
    System.out.println("--> PurchaseDAO created");
  }
  

  @Override
  public int create(PurchaseVO vo) {
    // TODO Auto-generated method stub
    return mybatis.insert("purchase.create",vo);
    
  }


  @Override
  public List<Mid_PurchaseVO> list() {
    // TODO Auto-generated method stub
    return mybatis.selectList("purchase.list");
  }


  @Override
  public int delete(int purnum) {
    // TODO Auto-generated method stub
    return mybatis.delete("purchase.delete", purnum);
  }


  @Override
  public List<Mid_PurchaseVO> pur_list() {
    // TODO Auto-generated method stub
    return mybatis.selectList("purchase.pur_list");
  }


  @Override
  public List<Mid_PurchaseVO> purchase(int midnum) {
    // TODO Auto-generated method stub
    return mybatis.selectList("purchase.purchase", midnum);
  }


 

}
