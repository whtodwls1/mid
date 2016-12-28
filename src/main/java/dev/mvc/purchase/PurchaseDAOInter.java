package dev.mvc.purchase;

import java.util.List;


public interface PurchaseDAOInter {
  /**
   * 등록
   * <insert id="create" parameterType="PurchaseVO">
   * @param vo
   * @return
   */
  public int create(PurchaseVO vo);
  
  /**
   * 카테고리 JOIN 목록
   * <select id="list" resultType="Mid_PurchaseVO">
   * @return
   */
  public List<Mid_PurchaseVO> list();
  
  /**
   * 구매 JOIN 목록
   * <select id="list" resultType="Mid_PurchaseVO">
   * @return
   */
  public List<Mid_PurchaseVO> pur_list();
  
  /**
   * 결제  목록
   * <select id="list" resultType="Mid_PurchaseVO">
   * @param midnum 
   * @return
   */
  public List<Mid_PurchaseVO> purchase(int midnum);
  
  /**
   * 한건의 레코드 삭제
   * <delete id="delete" parameterType="int"> 
   * @param purnum
   * @return
   */
  public int delete(int purnum);
}


