package dev.mvc.category;

public interface CategoryProcInter {
  /**
   * 카테고리 등록
   * <insert id="create" parameterType="CategoryVO"> 
   * @param vo
   * @return
   */
  public int create(CategoryVO vo);
}
