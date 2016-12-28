package dev.mvc.blog;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.category.CategoryDAOInter;
import dev.mvc.category.CategoryVO;
import dev.mvc.member.MemberDAOInter;
import dev.mvc.member.MemberVO;
import web.tool.SearchDTO;
import web.tool.Tool;
import web.tool.Upload;

@Controller
public class BlogCont {
  @Autowired
  @Qualifier("dev.mvc.blog.BlogDAO")
  private BlogDAOInter blogDAO;

  @Autowired
  @Qualifier("dev.mvc.category.CategoryDAO")
  private CategoryDAOInter categoryDAO;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberDAO")
  private MemberDAOInter memberDAO;

  public BlogCont() {
    System.out.println("--> BlogCont created.");
  }

  /**
   * http://localhost:9090/blog/blog/create.do?categoryno=1
   * 
   * @param categoryno
   * @return
   */
  @RequestMapping(value = "/blog/create.do", method = RequestMethod.GET)
  public ModelAndView create(int categoryno) {
    // System.out.println("--> create() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/create"); // /webapp/blog/create.jsp

    CategoryVO categoryVO = categoryDAO.read(categoryno);
    mav.addObject("categoryVO", categoryVO);

    return mav;
  }

  /**
   * 등록 처리
   * 
   * @param blogVO
   * @param request
   * @param session
   * @return
   */
  @RequestMapping(value = "/blog/create.do", method = RequestMethod.POST)
  public ModelAndView create(BlogVO blogVO, HttpServletRequest request, HttpSession session) {
    // System.out.println("--> create() POST called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/message");

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    // -------------------------------------------------------------------
    // 파일 전송
    // -------------------------------------------------------------------
    String thumb = "";
    String file1 = "";
    long size1 = 0;
    String upDir = Tool.getRealPath(request, "/blog/storage");
    MultipartFile file1MF = blogVO.getFile1MF();

    // System.out.println("file1MF.getSize(): " + file1MF.getSize());
    size1 = file1MF.getSize();
    if (size1 > 0) {
      file1 = Upload.saveFileSpring(file1MF, upDir);
      blogVO.setFile1(file1); // 전송된 파일명 저장
      blogVO.setSize1(size1);

      // -------------------------------------------------------------------
      // Thumb 파일 생성
      // -------------------------------------------------------------------
      if (Tool.isImage(file1)) {
        thumb = Tool.preview(upDir, file1, 120, 80);
      } else {
        thumb = "";
      }
      // -------------------------------------------------------------------
    }
    blogVO.setThumb(thumb); // Thumb 이미지
    blogVO.setFile1(file1); // 원본 이미지
    blogVO.setSize1(size1);
    // -------------------------------------------------------------------
    
    try{
    String id= session.getAttribute("id").toString();
    MemberVO memberVO=memberDAO.sessionid(id);
    blogVO.setMno(memberVO.getMno());    
    if (blogDAO.create(blogVO) == 1) {
      categoryDAO.increaseCnt(blogVO.getCategoryno()); // category 글수 증가
      msgs.add("글을 등록했습니다.");
      links.add("<button type='button' onclick=\"location.href='./create.do?categoryno=" + blogVO.getCategoryno()
          + "'\">계속 등록</button>");
    }
    }catch(Exception e){
      msgs.add("글 등록에 실패했습니다.");
      msgs.add("다시 시도해주세요.");
      links.add("<button type='button' onclick=\"history.back()\">다시시도</button>");
 
    }
    // 개발이 된경우
    // Integer itg = (Integer)(session.getAttribute("mno"));
    // blogVO.setMno(itg.intValue());

    links.add("<button type='button' onclick=\"location.href='/blog/yego/list.do'\">홈페이지</button>");
    links.add("<button type='button' onclick=\"location.href='/blog/blog/list_total.do?categoryno=" + blogVO.getCategoryno()
        + "'\">목록</button>");
    mav.addObject("msgs", msgs);
    mav.addObject("links", links);

    return mav;
  }

/*  @ResponseBody
  @RequestMapping(value = "/member/list_tab.do", method = RequestMethod.POST)
  public String list_tab(int categoryno) {
    JSONObject obj = new JSONObject();
    

    
    return obj.toJSONString();
  }
  */
  
  @RequestMapping(value = "/blog/list_total.do", method = RequestMethod.GET)
  public ModelAndView list_total(HttpServletRequest request, int categoryno, SearchDTO searchDTO) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/list_total");
    List<CategoryVO> catelist=categoryDAO.list();
    List<BlogVO> list = blogDAO.list_total();
    Iterator<BlogVO> iter = list.iterator();
    while (iter.hasNext() == true) { // 다음 요소 검사
      BlogVO vo = iter.next(); // 요소 추출
      vo.setTitle(Tool.textLength(vo.getTitle(), 10)); // 문자열 10자 분리
      vo.setRdate(vo.getRdate().substring(0, 10)); // 년월일
      vo.setFile1(Tool.textLength(vo.getFile1(), 10));

    }
    mav.addObject("catelist",catelist);
    mav.addObject("list", list);

    int totalRecord = 0;
    // HashMap hashMap = new HashMap();
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("categoryno", categoryno);
    hashMap.put("col", searchDTO.getCol());
    hashMap.put("word", searchDTO.getWord());

    int recordPerPage = 10; // 페이지당 출력할 레코드 갯수
    // 페이지에서 출력할 시작 레코드 번호 계산, nowPage는 1부터 시작
    int beginOfPage = (searchDTO.getNowPage() - 1) * 10;
    // 1 page: 0
    // 2 page: 10
    // 3 page: 20
    int startNum = beginOfPage + 1; // 시작 rownum, 1
    int endNum = beginOfPage + recordPerPage; // 종료 rownum, 10
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);

    List<BlogVO> listone = blogDAO.list4(hashMap); // 검색
    Iterator<BlogVO> iterone = listone.iterator();
    while (iterone.hasNext() == true) { // 다음 요소 검사
      BlogVO vo = iterone.next(); // 요소 추출
      vo.setTitle(Tool.textLength(vo.getTitle(), 30));
      vo.setRdate(vo.getRdate().substring(0, 10));
      vo.setSize1Label(Tool.unit(vo.getSize1()));
    }
    mav.addObject("listone", listone);

    CategoryVO categoryVO = categoryDAO.read(categoryno);
    mav.addObject("categoryVO", categoryVO);
    mav.addObject("root", request.getContextPath());

    totalRecord = blogDAO.count(hashMap);
    mav.addObject("totalRecord", blogDAO.count(hashMap)); // 검색된 레코드 갯수

    String paging = new Paging().paging(categoryno, totalRecord, searchDTO.getNowPage(), recordPerPage,
        searchDTO.getCol(), searchDTO.getWord());
    mav.addObject("paging", paging);
    
    
    return mav;
  }


  /**
   * 글을 조회합니다
   * 
   * @param blogno
   * @return
   */
  /*
   * @RequestMapping(value = "/blog/read.do", method = RequestMethod.GET) public
   * ModelAndView read(int blogno) { ModelAndView mav = new ModelAndView();
   * mav.setViewName("/blog/read"); BlogVO blogVO = blogDAO.read(blogno);
   * 
   * String size1Label = Tool.unit(blogVO.getSize1());
   * blogVO.setSize1Label(size1Label);
   * 
   * mav.addObject("blogVO", blogVO);
   * 
   * // 게시판에 대한 정보 파악 CategoryVO categoryVO =
   * categoryDAO.read(blogVO.getCategoryno()); mav.addObject("categoryVO",
   * categoryVO);
   * 
   * return mav; }
   */

  /**
   * 수정폼
   * 
   * @param blogno
   * @return
   */
  @RequestMapping(value = "/blog/update.do", method = RequestMethod.GET)
  public ModelAndView update(int blogno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/update");
    BlogVO blogVO = blogDAO.read(blogno);
    mav.addObject("blogVO", blogVO);

    // 게시판에 대한 정보 파악
    CategoryVO categoryVO = categoryDAO.read(blogVO.getCategoryno());
    mav.addObject("categoryVO", categoryVO);

    return mav;

  }

  /**
   * 글과 파일을 수정 처리
   * 
   * @param blogVO
   * @return
   */
  @RequestMapping(value = "/blog/update.do", method = RequestMethod.POST)
  public ModelAndView update(BlogVO blogVO, HttpServletRequest request) {
    ModelAndView mav = new ModelAndView();

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    // -------------------------------------------------------------------
    // 파일 전송 관련
    // -------------------------------------------------------------------
    String thumb = "";
    String file1 = "";
    long size1 = 0;

    String upDir = Tool.getRealPath(request, "/blog/storage");
    // <input type="file" name='file1MF' id='file1MF' size='40' >
    MultipartFile file1MF = blogVO.getFile1MF();
    // 기존에 등록된 레코드 정보 조회
    BlogVO oldVO = blogDAO.read(blogVO.getBlogno());

    size1 = file1MF.getSize(); // 새로운 파일의 크기 산출
    if (size1 > 0) { // 새로운 파일을 전송하는지 확인
      Tool.deleteFile(upDir, oldVO.getFile1()); // 기존 등록된 파일 삭제
      file1 = Upload.saveFileSpring(file1MF, upDir); // 새로운 파일 저장
      // -------------------------------------------------------------------
      // Thumb 파일 생성
      // -------------------------------------------------------------------
      if (Tool.isImage(file1)) { // 이미지인지 검사
        Tool.deleteFile(upDir, oldVO.getThumb()); // Thumb 파일 삭제
        Tool.deleteFile(upDir, oldVO.getFile1()); // file1 파일 삭제
        thumb = Tool.preview(upDir, file1, 120, 80); // thumb 이미지 생성
      } else {
        thumb = "";
      }
      // -------------------------------------------------------------------

    } else {
      thumb = oldVO.getThumb(); // 파일 업로드를하지 않는 경우
      file1 = oldVO.getFile1();
      size1 = oldVO.getSize1();
    }
    blogVO.setThumb(thumb);
    blogVO.setFile1(file1);
    blogVO.setSize1(size1);
    // -------------------------------------------------------------------

    if (blogDAO.update(blogVO) == 1) {
      // 수정후 조회로 자동 이동
      mav.setViewName("redirect:/blog/read.do?blogno=" + blogVO.getBlogno() + "&categoryno=" + blogVO.getCategoryno()); // 확장자
                                                                                                                        // 명시
    } else {
      msgs.add("게시판 수정에 실패 하셨습니다.");
      links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do?categoryno=" + blogVO.getCategoryno()
          + "'\">목록</button>");
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }

    return mav;
  }

  /**
   * 삭제폼
   * 
   * @param blogno
   * @return
   */
  @RequestMapping(value = "/blog/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int blogno, int categoryno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/delete"); // /webapp/blog/delete.jsp
    mav.addObject("blogno", blogno);

    // 게시판에 대한 정보 파악
    CategoryVO categoryVO = categoryDAO.read(categoryno);
    mav.addObject("categoryVO", categoryVO);

    return mav;
  }

  /**
   * 삭제 처리
   * 
   * @param blogVO
   * @return
   */
  @RequestMapping(value = "/blog/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(HttpServletRequest request, BlogVO blogVO) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/message");

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    // 파일 삭제 관련
    String upDir = Tool.getRealPath(request, "/blog/storage");
    BlogVO oldVO = blogDAO.read(blogVO.getBlogno());
    String thumb = oldVO.getThumb();
    String file1 = oldVO.getFile1();

    if (blogDAO.delete(blogVO.getBlogno()) == 1) {
      // 글수 삭제
      categoryDAO.decreaseCnt(blogVO.getCategoryno());

      // 파일 삭제 관련
      Tool.deleteFile(upDir, thumb); // 파일 삭제
      Tool.deleteFile(upDir, file1); // 파일 삭제

      mav.setViewName("redirect:/blog/list.do?categoryno=" + blogVO.getCategoryno());// 확장자
                                                                                     // 명시

    } else {
      msgs.add("글 삭제에 실패했습니다.");
      links.add("<button type='button' onclick=\"history.back()\">다시시도</button>");
      links.add("<button type='button' onclick=\"location.href='./home.do'\">홈페이지</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do?categoryno=" + blogVO.getCategoryno()
          + "'\">목록</button>");
    }

    mav.addObject("msgs", msgs);
    mav.addObject("links", links);

    return mav;
  }



  /**
   * 검색 기반 글을 조회합니다
   * 
   * @param mno
   * @return
   */
  @RequestMapping(value = "/blog/read.do", method = RequestMethod.GET)
  public ModelAndView read2(HttpServletRequest request, int blogno, SearchDTO searchDTO) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/read3"); // /blog/read3.jsp

    BlogVO blogVO = blogDAO.read(blogno);
    blogVO.setSize1Label(Tool.unit(blogVO.getSize1()));
    mav.addObject("blogVO", blogVO);

    CategoryVO categoryVO = categoryDAO.read(blogVO.getCategoryno());
    mav.addObject("categoryVO", categoryVO);

    mav.addObject("searchDTO", searchDTO); // 검색 관련 내용

    mav.addObject("root", request.getContextPath());

    return mav;
  }

  @RequestMapping(value = "/blog/reply.do", method = RequestMethod.GET)
  public ModelAndView reply(BlogVO blogVO) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/reply"); // /webapp/blog/reply.jsp
    mav.addObject("blogVO", blogVO);

    CategoryVO categoryVO = categoryDAO.read(blogVO.getCategoryno());
    mav.addObject("categoryVO", categoryVO);

    return mav;
  }

  
  @RequestMapping(value = "/blog/reply.do", method = RequestMethod.POST)
  public ModelAndView reply(BlogVO blogVO, HttpServletRequest request) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/message");

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    // -------------------------------------------------------------------
    // 파일 전송
    // -------------------------------------------------------------------
    String thumb = "";
    String file1 = "";
    String upDir = Tool.getRealPath(request, "/blog/storage");
    MultipartFile file1MF = blogVO.getFile1MF();

    // System.out.println("file1MF.getSize(): " + file1MF.getSize());
    if (file1MF.getSize() > 0) {
      file1 = Upload.saveFileSpring(file1MF, upDir);
      blogVO.setFile1(file1); // 전송된 파일명 저장
      blogVO.setSize1(file1MF.getSize());

      // -------------------------------------------------------------------
      // Thumb 파일 생성
      // -------------------------------------------------------------------
      if (Tool.isImage(file1)) {
        thumb = Tool.preview(upDir, file1, 120, 80);
      } else {
        thumb = "";
      }
      // -------------------------------------------------------------------
    }
    blogVO.setThumb(thumb);
    blogVO.setFile1(file1);
    // -------------------------------------------------------------------
    
    // -------------------------------------------------------------------
    blogVO.setMno(1); // 회원 연동시 변경
    // -------------------------------------------------------------------

    // ---------------------- 답변 관련 코드 시작 ---------------------
    BlogVO parentVO = blogDAO.read(blogVO.getBlogno()); // 부모글 정보 추출
    blogVO.setGrpno(parentVO.getGrpno()); // 그룹 번호
    blogVO.setAnsnum(parentVO.getAnsnum()); // 답변 순서

    blogDAO.updateAnsnum(blogVO); // 현재 등록된 답변 뒤로 +1 처리함.

    blogVO.setIndent(parentVO.getIndent() + 1); // 답변 차수 증가
    blogVO.setAnsnum(parentVO.getAnsnum() + 1); // 부모 바로 아래 등록
    // ---------------------- 답변 관련 코드 종료 ---------------------

    if (blogDAO.reply(blogVO) == 1) {
      categoryDAO.increaseCnt(blogVO.getCategoryno());
      msgs.add("글을 등록했습니다.");
      links.add("<button type='button' onclick=\"location.href='./create.do?categoryno=" + blogVO.getCategoryno()
          + "'\">계속 등록</button>");
    } else {
      msgs.add("글 등록에 실패했습니다.");
      msgs.add("다시 시도해주세요.");
      links.add("<button type='button' onclick=\"history.back()\">다시시도</button>");
    }

    links.add("<button type='button' onclick=\"location.href='./home.do'\">홈페이지</button>");
    links.add("<button type='button' onclick=\"location.href='./list.do?categoryno=" + blogVO.getCategoryno()
        + "'\">목록</button>");
    mav.addObject("msgs", msgs);
    mav.addObject("links", links);

    return mav;
  }

  /**
   * categoryno 별로 게시판 목록을 검색+페이징+답변을 적용하여 출력합니다.
   * 
   * @param categoryno
   *          전체 목록에서 가져올 게시판 번호
   * @param searchDTO
   *          검색 정보
   * @return 추출된 게시판 목록
   */
  @RequestMapping(value = "/blog/list.do", method = RequestMethod.GET)
  public ModelAndView list4(HttpServletRequest request, int categoryno, SearchDTO searchDTO) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/list4");
    int totalRecord = 0;

    // HashMap hashMap = new HashMap();
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("categoryno", categoryno);
    hashMap.put("col", searchDTO.getCol());
    hashMap.put("word", searchDTO.getWord());

    int recordPerPage = 10; // 페이지당 출력할 레코드 갯수
    // 페이지에서 출력할 시작 레코드 번호 계산, nowPage는 1부터 시작
    int beginOfPage = (searchDTO.getNowPage() - 1) * 10;
    // 1 page: 0
    // 2 page: 10
    // 3 page: 20
    int startNum = beginOfPage + 1; // 시작 rownum, 1
    int endNum = beginOfPage + recordPerPage; // 종료 rownum, 10
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);

    List<BlogVO> listone = blogDAO.list4(hashMap); // 검색
    Iterator<BlogVO> iter = listone.iterator();
    while (iter.hasNext() == true) { // 다음 요소 검사
      BlogVO vo = iter.next(); // 요소 추출
      vo.setTitle(Tool.textLength(vo.getTitle(), 30));
      vo.setRdate(vo.getRdate().substring(0, 10));
      vo.setSize1Label(Tool.unit(vo.getSize1()));
    }
    mav.addObject("listone", listone);

    CategoryVO categoryVO = categoryDAO.read(categoryno);
    mav.addObject("categoryVO", categoryVO);
    mav.addObject("root", request.getContextPath());

    totalRecord = blogDAO.count(hashMap);
    mav.addObject("totalRecord", blogDAO.count(hashMap)); // 검색된 레코드 갯수

    String paging = new Paging().paging(categoryno, totalRecord, searchDTO.getNowPage(), recordPerPage,
        searchDTO.getCol(), searchDTO.getWord());
    mav.addObject("paging", paging);
    return mav;
  }

}
