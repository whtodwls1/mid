package dev.mvc.member;

import java.util.List;
import java.util.Map;

public interface MemberDAOInter {
  /**
   * �ߺ� ���̵� �˻��մϴ�.
   * <select id='checkId' resultType='int' parameterType='String'>
   * @param id ���̵�
   * @return 0: �ߺ� �ƴ�, 1: �ߺ�
   */
  public int checkId(String id);

  /**
   * ���ڵ带 ����մϴ�.
   * <insert id="create" parameterType="MemberVO">
   * @param vo ����� ������ ��ü
   * @return ��ϵ� ���ڵ� ��
   */
  public int create(MemberVO vo);
  
  /**
   * ȸ�� ��ü ���
   * <select id="list" resultType="MemberVO">
   * @return ȸ�� ���
   */
  public List<MemberVO> list();
  
  /**
   * ȸ�� ���� ��ȸ
   * <select id="read" resultType="MemberVO" parameterType="int">
   * @param mno
   * @return
   */
  public MemberVO read(int mno); 
  
  /**
   * ȸ���� �����մϴ�.
   * <update id="update" parameterType="MemberVO"> 
   * @param memberVO
   * @return ������ ���ڵ� ����
   */
  public int update(MemberVO memberVO);
  
  /**
   * �н����� �˻� 
   * <select id="passwdCheck" resultType="int" parameterType="Map">
   * @param memberVO mno, passwd�� ����
   * @return ��ġ�ϴ� ���ڵ� ����
   */
  public int passwdCheck(Map map);
  
  /**
   * �н����� ���� ó��
   * <update id="update_passwd" parameterType="Map">
   * @param memberVO mno, passwd�� ����
   * @return ����� ���ڵ��� ����
   */
  public int update_passwd(Map map);
  
  /**
   * ���ڵ� 1�� ����
   * <delete id="delete" parameterType="int">
   * @param mno ������ ȸ�� ��ȣ
   * @return ������ ���ڵ� ����
   */
  public int delete(int mno); 
  
  /**
   * �α����մϴ�.
   * <select id="login" resultType="int" parameterType="MemberVO">
   * @param memberVO
   * @return
   */
  public int login(MemberVO memberVO);
  /*���ǰ� ã��*/
  public MemberVO sessionid(String id);
}



