package dev.mvc.blog;

import java.util.HashMap;
import java.util.List;

public interface BlogDAOInter {

  /**
   * ���
   * <insert id="create" parameterType="BlogVO">
   * @param vo
   * @return
   */
  public int create(BlogVO vo);
  
  /**
   * �Խ��� �� ��ü ����Դϴ�.
   * <select id="list_total" resultType="BlogVO">
   * @return
   */
  public List<BlogVO> list_total(); 
 
  /**
   * categoryno������ ���
   * <select id="listByCategoryno" resultType="BlogVO" parameterType="int">
   * @param categoryno
   * @return
   */
  public List<BlogVO> listByCategoryno(int categoryno);
  
  /**
   * ��ü ���ڵ� ����
   * <select id="total_count" resultType="int"> 
   * @return
   */
  public int total_count();  

  /**
   * �Ѱ��� ���ڵ� ��ȸ
   * <select id="read" resultType="BlogVO" parameterType="int">
   * @param blogno �� ��ȣ
   * @return
   */
  public BlogVO read(int blogno);
  
  /**
   * ����ó��
   * <update id="update" parameterType="BlogVO"> 
   * @param vo
   * @return
   */
  public int update(BlogVO vo);
  
  /**
   * ���� ó��
   * <delete id="delete" parameterType="int">
   * @param blogno
   * @return
   */
  public int delete(int blogno);
  
  /**
   * �˻� ���
   * <select id="list2" resultType="BlogVO" parameterType="HashMap" > 
   * @param hashmap �˻� ����
   * @return
   */
  public List<BlogVO> list2(HashMap hashmap);
  
  /**
   * �˻��� ���ڵ� ��
   * <select id="count" resultType="int" parameterType="HashMap" > 
   * @param hashmap �˻� ����
   * @return
   */
  public int count(HashMap hashmap);
  
  /**
   * �˻� ���
   * <select id="list3" resultType="BlogVO" parameterType="HashMap" > 
   * @param hashmap �˻� ����
   * @return
   */
  public List<BlogVO> list3(HashMap hashmap);
  
  /**
   * �亯 ������ �����մϴ�.
   * <update id='updateAnsnum' parameterType="BlogVO">
   * @param vo
   * @return ����� ���ڵ� ����
   */
  public int updateAnsnum(BlogVO vo);
  
  /**
   * �亯 ���
   * <insert id="reply" parameterType="BlogVO"> 
   * @param vo
   * @return 1: ����, 0: ����
   */
  public int reply(BlogVO vo);
  
  /**
   * �亯 ����� �����ϴ� ���
   * <select id="list4" resultType="BlogVO" parameterType="HashMap" > 
   * @param map �˻�/����¡
   * @return ��ü��� �Ǵ� �˻� ���
   */
  public List<BlogVO> list4(HashMap<String, Object> map);
  

  
}



