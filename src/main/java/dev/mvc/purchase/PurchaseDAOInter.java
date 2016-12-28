package dev.mvc.purchase;

import java.util.List;


public interface PurchaseDAOInter {
  /**
   * ���
   * <insert id="create" parameterType="PurchaseVO">
   * @param vo
   * @return
   */
  public int create(PurchaseVO vo);
  
  /**
   * ī�װ� JOIN ���
   * <select id="list" resultType="Mid_PurchaseVO">
   * @return
   */
  public List<Mid_PurchaseVO> list();
  
  /**
   * ���� JOIN ���
   * <select id="list" resultType="Mid_PurchaseVO">
   * @return
   */
  public List<Mid_PurchaseVO> pur_list();
  
  /**
   * ����  ���
   * <select id="list" resultType="Mid_PurchaseVO">
   * @param midnum 
   * @return
   */
  public List<Mid_PurchaseVO> purchase(int midnum);
  
  /**
   * �Ѱ��� ���ڵ� ����
   * <delete id="delete" parameterType="int"> 
   * @param purnum
   * @return
   */
  public int delete(int purnum);
}


