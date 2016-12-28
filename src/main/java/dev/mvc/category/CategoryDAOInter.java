package dev.mvc.category;

import java.util.List;

public interface CategoryDAOInter {
  
  /**
   * 카테고리 등록
   * <insert id="create" parameterType="CategoryVO"> 
   * @param vo
   * @return
   */
  public int create(CategoryVO vo);
  
  /**
   * 카테고리 목록
   * <select id="list" resultType="CategoryVO">
   * @return
   */
  public List<CategoryVO> list();
  
  /**
   * 한건의 레코드 조회
   * <select id="read" resultType="CategoryVO" parameterType="int"> 
   * @param categrpno
   * @return
   */
  public CategoryVO read(int categoryno);
  
  /**
   * 레코드를 수정합니다.
   * <update id="update" parameterType="CategoryVO"> 
   * @param vo
   * @return
   */
  public int update(CategoryVO vo); 

  /**
   * 한건의 레코드 삭제
   * <delete id="delete" parameterType="int"> 
   * @param categoryno
   * @return
   */
  public int delete(int categoryno);
  
  /**
   * 한건의 레코드의 우선 순위를 높임입니다.
   * <update id="up" parameterType="int">
   * @param categoryno
   * @return 변경된 레코드 갯수
   */
  public int up(int categoryno);

  /**
   * 한건의 레코드의 우선 순위를 낮춥니다.
   * <update id="down" parameterType="int">
   * @param categoryno
   * @return 변경된 레코드 갯수
   */
  public int down(int categoryno);
  
  /**
   * 글 수 증가
   * <update id="increaseCnt" parameterType="int"> 
   * @param categoryno
   * @return
   */
  public int increaseCnt(int categoryno);

  /**
   * 글 수 감소
   * <update id="decreaseCnt" parameterType="int"> 
   * @param categoryno
   * @return
   */
  public int decreaseCnt(int categoryno);
  
  /**
   * 전체 레코드 갯수를 구합니다.
   * <select id="count" resultType="int">
   * @return
   */
  public int count();
  
}








