package dev.mvc.category;

import java.util.List;

public interface CategoryDAOInter {
  
  /**
   * ī�װ� ���
   * <insert id="create" parameterType="CategoryVO"> 
   * @param vo
   * @return
   */
  public int create(CategoryVO vo);
  
  /**
   * ī�װ� ���
   * <select id="list" resultType="CategoryVO">
   * @return
   */
  public List<CategoryVO> list();
  
  /**
   * �Ѱ��� ���ڵ� ��ȸ
   * <select id="read" resultType="CategoryVO" parameterType="int"> 
   * @param categrpno
   * @return
   */
  public CategoryVO read(int categoryno);
  
  /**
   * ���ڵ带 �����մϴ�.
   * <update id="update" parameterType="CategoryVO"> 
   * @param vo
   * @return
   */
  public int update(CategoryVO vo); 

  /**
   * �Ѱ��� ���ڵ� ����
   * <delete id="delete" parameterType="int"> 
   * @param categoryno
   * @return
   */
  public int delete(int categoryno);
  
  /**
   * �Ѱ��� ���ڵ��� �켱 ������ �����Դϴ�.
   * <update id="up" parameterType="int">
   * @param categoryno
   * @return ����� ���ڵ� ����
   */
  public int up(int categoryno);

  /**
   * �Ѱ��� ���ڵ��� �켱 ������ ����ϴ�.
   * <update id="down" parameterType="int">
   * @param categoryno
   * @return ����� ���ڵ� ����
   */
  public int down(int categoryno);
  
  /**
   * �� �� ����
   * <update id="increaseCnt" parameterType="int"> 
   * @param categoryno
   * @return
   */
  public int increaseCnt(int categoryno);

  /**
   * �� �� ����
   * <update id="decreaseCnt" parameterType="int"> 
   * @param categoryno
   * @return
   */
  public int decreaseCnt(int categoryno);
  
  /**
   * ��ü ���ڵ� ������ ���մϴ�.
   * <select id="count" resultType="int">
   * @return
   */
  public int count();
  
}








