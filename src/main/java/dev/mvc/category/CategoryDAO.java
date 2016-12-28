package dev.mvc.category;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.category.CategoryDAO")
public class CategoryDAO implements CategoryDAOInter {
  @Autowired
  private SqlSessionTemplate mybatis; // MyBATIS 3 ¿¬°á °´Ã¼

  public CategoryDAO(){
    System.out.println("--> CategoryDAO created.");  
  }
  
  @Override
  public int create(CategoryVO vo) {
    return mybatis.insert("category.create", vo);
  }

  @Override
  public List<CategoryVO> list() {
    return mybatis.selectList("category.list");
  }

  @Override
  public CategoryVO read(int categoryno) {
    return mybatis.selectOne("category.read", categoryno);
  }

  @Override
  public int update(CategoryVO vo) {
    return mybatis.update("category.update", vo);
  }

  @Override
  public int delete(int categoryno) {
    return mybatis.delete("category.delete", categoryno);
  }

  @Override
  public int up(int categoryno) {
    return mybatis.update("category.up", categoryno) ;
  }

  @Override
  public int down(int categoryno) {
    return mybatis.update("category.down", categoryno) ;
  }

  @Override
  public int increaseCnt(int categoryno) {
    return mybatis.update("category.increaseCnt", categoryno);
  }

  @Override
  public int decreaseCnt(int categoryno) {
    return mybatis.update("category.decreaseCnt", categoryno);
  }

  @Override
  public int count() {
    return mybatis.selectOne("category.count");
  }
  
}


