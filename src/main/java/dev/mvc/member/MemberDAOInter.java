package dev.mvc.member;

import java.util.List;
import java.util.Map;

public interface MemberDAOInter {
  /**
   * 중복 아이디를 검사합니다.
   * <select id='checkId' resultType='int' parameterType='String'>
   * @param id 아이디
   * @return 0: 중복 아님, 1: 중복
   */
  public int checkId(String id);

  /**
   * 레코드를 등록합니다.
   * <insert id="create" parameterType="MemberVO">
   * @param vo 등록할 데이터 객체
   * @return 등록된 레코드 수
   */
  public int create(MemberVO vo);
  
  /**
   * 회원 전체 목록
   * <select id="list" resultType="MemberVO">
   * @return 회원 목록
   */
  public List<MemberVO> list();
  
  /**
   * 회원 정보 조회
   * <select id="read" resultType="MemberVO" parameterType="int">
   * @param mno
   * @return
   */
  public MemberVO read(int mno); 
  
  /**
   * 회원을 수정합니다.
   * <update id="update" parameterType="MemberVO"> 
   * @param memberVO
   * @return 수정된 레코드 갯수
   */
  public int update(MemberVO memberVO);
  
  /**
   * 패스워드 검사 
   * <select id="passwdCheck" resultType="int" parameterType="Map">
   * @param memberVO mno, passwd의 전달
   * @return 일치하는 레코드 갯수
   */
  public int passwdCheck(Map map);
  
  /**
   * 패스워드 변경 처리
   * <update id="update_passwd" parameterType="Map">
   * @param memberVO mno, passwd의 전달
   * @return 변경된 레코드의 갯수
   */
  public int update_passwd(Map map);
  
  /**
   * 레코드 1건 삭제
   * <delete id="delete" parameterType="int">
   * @param mno 삭제할 회원 번호
   * @return 삭제된 레코드 갯수
   */
  public int delete(int mno); 
  
  /**
   * 로그인합니다.
   * <select id="login" resultType="int" parameterType="MemberVO">
   * @param memberVO
   * @return
   */
  public int login(MemberVO memberVO);
  /*세션값 찾기*/
  public MemberVO sessionid(String id);
}



