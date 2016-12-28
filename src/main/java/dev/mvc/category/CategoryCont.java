/*
 * Copyright 2016 JAVA CBD Project 1조, Inc. All rights reserved.
*/
package dev.mvc.category;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.blog.BlogDAOInter;


@Controller
public class CategoryCont {
  @Autowired
  @Qualifier("dev.mvc.category.CategoryDAO")
  private CategoryDAOInter categoryDAO;

  @Autowired
  @Qualifier("dev.mvc.category.CategoryProc")
  private CategoryProcInter categoryProc;
  @Autowired
  @Qualifier("dev.mvc.blog.BlogDAO")
  private BlogDAOInter blogDAO;
  
  public CategoryCont() {
    System.out.println("--> CategoryCont created.");
  }

  @RequestMapping(value = "/category/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/create"); // /webapp/category/create.jsp
    // JSP: List<CategrpVO> categrp_list =
    // (ArrayList<CategrpVO>)request.getAttribute("categrp_list");
    // 개발이 종료되지않은 경우의 처리
    // List<CategrpVO> code_list = new ArrayList<CategrpVO>();
    // categrp_list.add(new CategrpVO(1, "개발 자료", 1));
    // categrp_list.add(new CategrpVO(2, "해외 여행", 2));
    // categrp_list.add(new CategrpVO(3, "국내 여행", 3));

    return mav;
  }

  @RequestMapping(value = "/category/create.do", method = RequestMethod.POST)
  public ModelAndView create(CategoryVO categoryVO) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/message");

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    if (categoryDAO.create(categoryVO) == 1) {
      msgs.add("게시판(카테고리)이 생성되었습니다.");
      links.add("<button type='button' onclick=\"location.href='./create.do'\">계속 등록</button>");
    } else {
      msgs.add("게시판(카테고리) 생성에 실패했습니다.");
      msgs.add("다시 시도해주세요.");
      links.add("<button type='button' onclick=\"history.back()\">다시시도</button>");
    }

    links.add("<button type='button' onclick=\"location.href='./list.do'\">카테고리 목록</button>");

    // request.setAttribute("msgs", msgs);
    mav.addObject("msgs", msgs);
    mav.addObject("links", links);

    return mav;
  }

  /**
   * Categrp, Category 테이블을 구룹별로 분류하여 가져옵니다.
   * 
   * @return
   */
  @RequestMapping(value = "/category/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/list"); // /category/list.jsp

    List<CategoryVO> list = categoryDAO.list();
    /*
     * CATEGRPNO NAME SEQNO CATEGORYNO TITLE CATEGORY_SEQNO VISIBLE IDS
     * --------- ---- ----- ---------- ----- -------------- ------- ----- 1 영화 1
     * 1 퇴마 1 Y admin 1 영화 1 2 로맨스 2 Y admin 1 영화 1 3 코믹 3 Y admin 2 여행 2 4 국내
     * 여행 1 Y admin 2 여행 2 5 해외 여행 2 Y admin
     */

    mav.addObject("list", list);

    return mav;
  }

  /**
   * Categrp, Category 테이블을 구룹별로 분류하여 가져옵니다.
   * 
   * @return
   */
  @RequestMapping(value = "/category/list_index.do", method = RequestMethod.GET)
  public ModelAndView list_index(HttpServletRequest request) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/list_index"); // /category/list_index.jsp

    List<CategoryVO> list = categoryDAO.list();

    ArrayList<String> name_title = new ArrayList<String>(); // Category: title
    
    StringBuffer url = new StringBuffer(); // 카테고리 제목 링크 조합

    int total_count = blogDAO.total_count();
    mav.addObject("total_count", total_count);
    
    // 카테고리 그룹 목록을 순환하면서 카테고리 그룹에 해당하는 카테고리 이름 추출
    for (int index = 0; index < list.size(); index++) {
      CategoryVO vo = list.get(index); // JOIN 객체 추출
      url.append("<LI class='name_title'>");
      url.append("  <A href='"+request.getContextPath()+"/blog/list.do?categoryno="+vo.getCategoryno()+"'>");
      url.append(vo.getTitle());
      url.append("  </A>");
      url.append("  <span style='font-size:0.9em; color: #555555;'>("+vo.getCnt()+")</span>");
      url.append("</LI>");    
      name_title.add(url.toString());
      url.delete(0, url.toString().length()); // StringBuffer 문 자열 삭제
    }

    mav.addObject("list", name_title);

    return mav;
  }

  /**
   * 전체 레코드 갯수를 추출합니다.
   * 
   * @param id
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/category/count.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
  public String count(int categrpno) {
    JSONObject obj = new JSONObject();
    int cnt = categoryDAO.count();

    obj.put("cnt", cnt);
    return obj.toJSONString();
  }

  /**
   * 변경 폼 출력
   * 
   * @return
   */
  @RequestMapping(value = "/category/update.do", method = RequestMethod.GET)
  public ModelAndView update(int categoryno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/update"); // /webapp/category/update.jsp

    CategoryVO vo = categoryDAO.read(categoryno);
    mav.addObject("vo", vo);

    return mav;
  }

  @RequestMapping(value = "/category/update.do", method = RequestMethod.POST)
  public ModelAndView update(CategoryVO categoryVO) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/message");

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    if (categoryDAO.update(categoryVO) == 1) {
      mav.setViewName("redirect:/category/list.do");
    } else {
      msgs.add("게시판 정보 변경에 실패했습니다.");
      msgs.add("다시 시도해주세요.");
      links.add("<button type='button' onclick=\"history.back()\">다시시도</button>");
      links.add("<button type='button' onclick=\"location.href='./home.do'\">홈페이지</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }
    return mav;
  }

  /**
   * 삭제 폼 출력
   * 
   * @return
   */
  @RequestMapping(value = "/category/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int categoryno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/delete"); // /webapp/category/delete.jsp

    mav.addObject("categoryno", categoryno);

    return mav;
  }

  /**
   * 레코드 1건을 삭제합니다.
   * 
   * @param categoryno
   * @return
   */
  @RequestMapping(value = "/category/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(CategoryVO categoryVO) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/message");

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    if (categoryDAO.delete(categoryVO.getCategoryno()) == 1) {
      mav.setViewName("redirect:/category/list.do");
    } else {
      msgs.add("삭제에 실패했습니다.");
      msgs.add("다시 시도해주세요.");
      links.add("<button type='button' onclick=\"history.back()\">다시시도</button>");
      links.add("<button type='button' onclick=\"location.href='./home.do'\">홈페이지</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }

    return mav;
  }

  @RequestMapping(value = "/category/up.do", method = RequestMethod.GET)
  public ModelAndView up(CategoryVO categoryVO) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/message");

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    if (categoryDAO.up(categoryVO.getCategoryno()) == 1) {
      mav.setViewName("redirect:/category/list.do");
    } else {
      msgs.add("출력 순서 변경에 실패했습니다.");
      msgs.add("다시 시도해주세요.");
      links.add("<button type='button' onclick=\"history.back()\">다시시도</button>");
      links.add("<button type='button' onclick=\"location.href='./home.do'\">홈페이지</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }
    return mav;
  }

  @RequestMapping(value = "/category/down.do", method = RequestMethod.GET)
  public ModelAndView down(CategoryVO categoryVO) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/message");

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    if (categoryDAO.down(categoryVO.getCategoryno()) == 1) {
      mav.setViewName("redirect:/category/list.do");
    } else {
      msgs.add("출력 순서 변경에 실패했습니다.");
      msgs.add("다시 시도해주세요.");
      links.add("<button type='button' onclick=\"history.back()\">다시시도</button>");
      links.add("<button type='button' onclick=\"location.href='./home.do'\">홈페이지</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }
    return mav;
  }

}
