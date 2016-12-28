package dev.mvc.blog;

import java.util.HashMap;
import java.util.List;

public interface BlogDAOInter {

  /**
   * 등록
   * <insert id="create" parameterType="BlogVO">
   * @param vo
   * @return
   */
  public int create(BlogVO vo);
  
  /**
   * 게시판 글 전체 목록입니다.
   * <select id="list_total" resultType="BlogVO">
   * @return
   */
  public List<BlogVO> list_total(); 
 
  /**
   * categoryno에의한 목록
   * <select id="listByCategoryno" resultType="BlogVO" parameterType="int">
   * @param categoryno
   * @return
   */
  public List<BlogVO> listByCategoryno(int categoryno);
  
  /**
   * 전체 레코드 갯수
   * <select id="total_count" resultType="int"> 
   * @return
   */
  public int total_count();  

  /**
   * 한건의 레코드 조회
   * <select id="read" resultType="BlogVO" parameterType="int">
   * @param blogno 글 번호
   * @return
   */
  public BlogVO read(int blogno);
  
  /**
   * 수정처리
   * <update id="update" parameterType="BlogVO"> 
   * @param vo
   * @return
   */
  public int update(BlogVO vo);
  
  /**
   * 삭제 처리
   * <delete id="delete" parameterType="int">
   * @param blogno
   * @return
   */
  public int delete(int blogno);
  
  /**
   * 검색 목록
   * <select id="list2" resultType="BlogVO" parameterType="HashMap" > 
   * @param hashmap 검색 조건
   * @return
   */
  public List<BlogVO> list2(HashMap hashmap);
  
  /**
   * 검색된 레코드 수
   * <select id="count" resultType="int" parameterType="HashMap" > 
   * @param hashmap 검색 조건
   * @return
   */
  public int count(HashMap hashmap);
  
  /**
   * 검색 목록
   * <select id="list3" resultType="BlogVO" parameterType="HashMap" > 
   * @param hashmap 검색 조건
   * @return
   */
  public List<BlogVO> list3(HashMap hashmap);
  
  /**
   * 답변 순서를 변경합니다.
   * <update id='updateAnsnum' parameterType="BlogVO">
   * @param vo
   * @return 변경된 레코드 갯수
   */
  public int updateAnsnum(BlogVO vo);
  
  /**
   * 답변 등록
   * <insert id="reply" parameterType="BlogVO"> 
   * @param vo
   * @return 1: 성공, 0: 실패
   */
  public int reply(BlogVO vo);
  
  /**
   * 답변 기능을 지원하는 목록
   * <select id="list4" resultType="BlogVO" parameterType="HashMap" > 
   * @param map 검색/페이징
   * @return 전체목록 또는 검색 목록
   */
  public List<BlogVO> list4(HashMap<String, Object> map);
  

  
}



