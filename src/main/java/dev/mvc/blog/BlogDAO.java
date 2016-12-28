package dev.mvc.blog;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.blog.BlogDAO")
public class BlogDAO implements BlogDAOInter{
  @Autowired
  private SqlSessionTemplate mybatis; // MyBATIS 3 ¿¬°á °´Ã¼

  public BlogDAO(){
    System.out.println("--> BlogDAO created.");  
  }

  @Override
  public int create(BlogVO vo) {
    return mybatis.insert("blog.create", vo);
  }
  
  @Override
  public List<BlogVO> list_total() {
    return mybatis.selectList("blog.list_total");
  }
  
  @Override
  public List<BlogVO> listByCategoryno(int categoryno) {
    return mybatis.selectList("blog.listByCategoryno", categoryno);
  }

  @Override
  public int total_count() {
    return mybatis.selectOne("blog.total_count");
  }
  
  @Override
  public BlogVO read(int blogno) {
    return mybatis.selectOne("blog.read", blogno);
  }
  
  @Override
  public int update(BlogVO vo) {
    return mybatis.update("blog.update", vo);
  }
  
  @Override
  public int delete(int blogno) {
    return mybatis.delete("blog.delete", blogno);
  }
 
  @Override
  public List<BlogVO> list2(HashMap hashmap) {
    return mybatis.selectList("blog.list2", hashmap);
  }

  @Override
  public int count(HashMap hashmap) {
    return mybatis.selectOne("blog.count", hashmap);
  }
 
  @Override
  public List<BlogVO> list3(HashMap hashmap) {
    return mybatis.selectList("blog.list3", hashmap);
  }
  
  @Override
  public int updateAnsnum(BlogVO vo) {
    return mybatis.update("blog.updateAnsnum", vo);
  }

  @Override
  public int reply(BlogVO vo) {
    return mybatis.insert("blog.reply", vo);
  }

  @Override
  public List<BlogVO> list4(HashMap<String, Object> map) {
    return mybatis.selectList("blog.list4", map);
  }  
}





