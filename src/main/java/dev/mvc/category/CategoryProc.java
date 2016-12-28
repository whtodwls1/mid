package dev.mvc.category;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component
public class CategoryProc implements CategoryProcInter {
  @Autowired
  @Qualifier("dev.mvc.category.CategoryDAO")
  private CategoryDAOInter categoryDAO;

  @Override
  public int create(CategoryVO vo) {
 
    return categoryDAO.create(vo);
  }
  
  
}
