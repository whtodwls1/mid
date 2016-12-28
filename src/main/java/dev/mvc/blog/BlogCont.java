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
   * ��� ó��
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
    // ���� ����
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
      blogVO.setFile1(file1); // ���۵� ���ϸ� ����
      blogVO.setSize1(size1);

      // -------------------------------------------------------------------
      // Thumb ���� ����
      // -------------------------------------------------------------------
      if (Tool.isImage(file1)) {
        thumb = Tool.preview(upDir, file1, 120, 80);
      } else {
        thumb = "";
      }
      // -------------------------------------------------------------------
    }
    blogVO.setThumb(thumb); // Thumb �̹���
    blogVO.setFile1(file1); // ���� �̹���
    blogVO.setSize1(size1);
    // -------------------------------------------------------------------
    
    try{
    String id= session.getAttribute("id").toString();
    MemberVO memberVO=memberDAO.sessionid(id);
    blogVO.setMno(memberVO.getMno());    
    if (blogDAO.create(blogVO) == 1) {
      categoryDAO.increaseCnt(blogVO.getCategoryno()); // category �ۼ� ����
      msgs.add("���� ����߽��ϴ�.");
      links.add("<button type='button' onclick=\"location.href='./create.do?categoryno=" + blogVO.getCategoryno()
          + "'\">��� ���</button>");
    }
    }catch(Exception e){
      msgs.add("�� ��Ͽ� �����߽��ϴ�.");
      msgs.add("�ٽ� �õ����ּ���.");
      links.add("<button type='button' onclick=\"history.back()\">�ٽýõ�</button>");
 
    }
    // ������ �Ȱ��
    // Integer itg = (Integer)(session.getAttribute("mno"));
    // blogVO.setMno(itg.intValue());

    links.add("<button type='button' onclick=\"location.href='/blog/yego/list.do'\">Ȩ������</button>");
    links.add("<button type='button' onclick=\"location.href='/blog/blog/list_total.do?categoryno=" + blogVO.getCategoryno()
        + "'\">���</button>");
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
    while (iter.hasNext() == true) { // ���� ��� �˻�
      BlogVO vo = iter.next(); // ��� ����
      vo.setTitle(Tool.textLength(vo.getTitle(), 10)); // ���ڿ� 10�� �и�
      vo.setRdate(vo.getRdate().substring(0, 10)); // �����
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

    int recordPerPage = 10; // �������� ����� ���ڵ� ����
    // ���������� ����� ���� ���ڵ� ��ȣ ���, nowPage�� 1���� ����
    int beginOfPage = (searchDTO.getNowPage() - 1) * 10;
    // 1 page: 0
    // 2 page: 10
    // 3 page: 20
    int startNum = beginOfPage + 1; // ���� rownum, 1
    int endNum = beginOfPage + recordPerPage; // ���� rownum, 10
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);

    List<BlogVO> listone = blogDAO.list4(hashMap); // �˻�
    Iterator<BlogVO> iterone = listone.iterator();
    while (iterone.hasNext() == true) { // ���� ��� �˻�
      BlogVO vo = iterone.next(); // ��� ����
      vo.setTitle(Tool.textLength(vo.getTitle(), 30));
      vo.setRdate(vo.getRdate().substring(0, 10));
      vo.setSize1Label(Tool.unit(vo.getSize1()));
    }
    mav.addObject("listone", listone);

    CategoryVO categoryVO = categoryDAO.read(categoryno);
    mav.addObject("categoryVO", categoryVO);
    mav.addObject("root", request.getContextPath());

    totalRecord = blogDAO.count(hashMap);
    mav.addObject("totalRecord", blogDAO.count(hashMap)); // �˻��� ���ڵ� ����

    String paging = new Paging().paging(categoryno, totalRecord, searchDTO.getNowPage(), recordPerPage,
        searchDTO.getCol(), searchDTO.getWord());
    mav.addObject("paging", paging);
    
    
    return mav;
  }


  /**
   * ���� ��ȸ�մϴ�
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
   * // �Խ��ǿ� ���� ���� �ľ� CategoryVO categoryVO =
   * categoryDAO.read(blogVO.getCategoryno()); mav.addObject("categoryVO",
   * categoryVO);
   * 
   * return mav; }
   */

  /**
   * ������
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

    // �Խ��ǿ� ���� ���� �ľ�
    CategoryVO categoryVO = categoryDAO.read(blogVO.getCategoryno());
    mav.addObject("categoryVO", categoryVO);

    return mav;

  }

  /**
   * �۰� ������ ���� ó��
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
    // ���� ���� ����
    // -------------------------------------------------------------------
    String thumb = "";
    String file1 = "";
    long size1 = 0;

    String upDir = Tool.getRealPath(request, "/blog/storage");
    // <input type="file" name='file1MF' id='file1MF' size='40' >
    MultipartFile file1MF = blogVO.getFile1MF();
    // ������ ��ϵ� ���ڵ� ���� ��ȸ
    BlogVO oldVO = blogDAO.read(blogVO.getBlogno());

    size1 = file1MF.getSize(); // ���ο� ������ ũ�� ����
    if (size1 > 0) { // ���ο� ������ �����ϴ��� Ȯ��
      Tool.deleteFile(upDir, oldVO.getFile1()); // ���� ��ϵ� ���� ����
      file1 = Upload.saveFileSpring(file1MF, upDir); // ���ο� ���� ����
      // -------------------------------------------------------------------
      // Thumb ���� ����
      // -------------------------------------------------------------------
      if (Tool.isImage(file1)) { // �̹������� �˻�
        Tool.deleteFile(upDir, oldVO.getThumb()); // Thumb ���� ����
        Tool.deleteFile(upDir, oldVO.getFile1()); // file1 ���� ����
        thumb = Tool.preview(upDir, file1, 120, 80); // thumb �̹��� ����
      } else {
        thumb = "";
      }
      // -------------------------------------------------------------------

    } else {
      thumb = oldVO.getThumb(); // ���� ���ε带���� �ʴ� ���
      file1 = oldVO.getFile1();
      size1 = oldVO.getSize1();
    }
    blogVO.setThumb(thumb);
    blogVO.setFile1(file1);
    blogVO.setSize1(size1);
    // -------------------------------------------------------------------

    if (blogDAO.update(blogVO) == 1) {
      // ������ ��ȸ�� �ڵ� �̵�
      mav.setViewName("redirect:/blog/read.do?blogno=" + blogVO.getBlogno() + "&categoryno=" + blogVO.getCategoryno()); // Ȯ����
                                                                                                                        // ���
    } else {
      msgs.add("�Խ��� ������ ���� �ϼ̽��ϴ�.");
      links.add("<button type='button' onclick=\"history.back()\">�ٽ� �õ�</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do?categoryno=" + blogVO.getCategoryno()
          + "'\">���</button>");
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }

    return mav;
  }

  /**
   * ������
   * 
   * @param blogno
   * @return
   */
  @RequestMapping(value = "/blog/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int blogno, int categoryno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/blog/delete"); // /webapp/blog/delete.jsp
    mav.addObject("blogno", blogno);

    // �Խ��ǿ� ���� ���� �ľ�
    CategoryVO categoryVO = categoryDAO.read(categoryno);
    mav.addObject("categoryVO", categoryVO);

    return mav;
  }

  /**
   * ���� ó��
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

    // ���� ���� ����
    String upDir = Tool.getRealPath(request, "/blog/storage");
    BlogVO oldVO = blogDAO.read(blogVO.getBlogno());
    String thumb = oldVO.getThumb();
    String file1 = oldVO.getFile1();

    if (blogDAO.delete(blogVO.getBlogno()) == 1) {
      // �ۼ� ����
      categoryDAO.decreaseCnt(blogVO.getCategoryno());

      // ���� ���� ����
      Tool.deleteFile(upDir, thumb); // ���� ����
      Tool.deleteFile(upDir, file1); // ���� ����

      mav.setViewName("redirect:/blog/list.do?categoryno=" + blogVO.getCategoryno());// Ȯ����
                                                                                     // ���

    } else {
      msgs.add("�� ������ �����߽��ϴ�.");
      links.add("<button type='button' onclick=\"history.back()\">�ٽýõ�</button>");
      links.add("<button type='button' onclick=\"location.href='./home.do'\">Ȩ������</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do?categoryno=" + blogVO.getCategoryno()
          + "'\">���</button>");
    }

    mav.addObject("msgs", msgs);
    mav.addObject("links", links);

    return mav;
  }



  /**
   * �˻� ��� ���� ��ȸ�մϴ�
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

    mav.addObject("searchDTO", searchDTO); // �˻� ���� ����

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
    // ���� ����
    // -------------------------------------------------------------------
    String thumb = "";
    String file1 = "";
    String upDir = Tool.getRealPath(request, "/blog/storage");
    MultipartFile file1MF = blogVO.getFile1MF();

    // System.out.println("file1MF.getSize(): " + file1MF.getSize());
    if (file1MF.getSize() > 0) {
      file1 = Upload.saveFileSpring(file1MF, upDir);
      blogVO.setFile1(file1); // ���۵� ���ϸ� ����
      blogVO.setSize1(file1MF.getSize());

      // -------------------------------------------------------------------
      // Thumb ���� ����
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
    blogVO.setMno(1); // ȸ�� ������ ����
    // -------------------------------------------------------------------

    // ---------------------- �亯 ���� �ڵ� ���� ---------------------
    BlogVO parentVO = blogDAO.read(blogVO.getBlogno()); // �θ�� ���� ����
    blogVO.setGrpno(parentVO.getGrpno()); // �׷� ��ȣ
    blogVO.setAnsnum(parentVO.getAnsnum()); // �亯 ����

    blogDAO.updateAnsnum(blogVO); // ���� ��ϵ� �亯 �ڷ� +1 ó����.

    blogVO.setIndent(parentVO.getIndent() + 1); // �亯 ���� ����
    blogVO.setAnsnum(parentVO.getAnsnum() + 1); // �θ� �ٷ� �Ʒ� ���
    // ---------------------- �亯 ���� �ڵ� ���� ---------------------

    if (blogDAO.reply(blogVO) == 1) {
      categoryDAO.increaseCnt(blogVO.getCategoryno());
      msgs.add("���� ����߽��ϴ�.");
      links.add("<button type='button' onclick=\"location.href='./create.do?categoryno=" + blogVO.getCategoryno()
          + "'\">��� ���</button>");
    } else {
      msgs.add("�� ��Ͽ� �����߽��ϴ�.");
      msgs.add("�ٽ� �õ����ּ���.");
      links.add("<button type='button' onclick=\"history.back()\">�ٽýõ�</button>");
    }

    links.add("<button type='button' onclick=\"location.href='./home.do'\">Ȩ������</button>");
    links.add("<button type='button' onclick=\"location.href='./list.do?categoryno=" + blogVO.getCategoryno()
        + "'\">���</button>");
    mav.addObject("msgs", msgs);
    mav.addObject("links", links);

    return mav;
  }

  /**
   * categoryno ���� �Խ��� ����� �˻�+����¡+�亯�� �����Ͽ� ����մϴ�.
   * 
   * @param categoryno
   *          ��ü ��Ͽ��� ������ �Խ��� ��ȣ
   * @param searchDTO
   *          �˻� ����
   * @return ����� �Խ��� ���
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

    int recordPerPage = 10; // �������� ����� ���ڵ� ����
    // ���������� ����� ���� ���ڵ� ��ȣ ���, nowPage�� 1���� ����
    int beginOfPage = (searchDTO.getNowPage() - 1) * 10;
    // 1 page: 0
    // 2 page: 10
    // 3 page: 20
    int startNum = beginOfPage + 1; // ���� rownum, 1
    int endNum = beginOfPage + recordPerPage; // ���� rownum, 10
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);

    List<BlogVO> listone = blogDAO.list4(hashMap); // �˻�
    Iterator<BlogVO> iter = listone.iterator();
    while (iter.hasNext() == true) { // ���� ��� �˻�
      BlogVO vo = iter.next(); // ��� ����
      vo.setTitle(Tool.textLength(vo.getTitle(), 30));
      vo.setRdate(vo.getRdate().substring(0, 10));
      vo.setSize1Label(Tool.unit(vo.getSize1()));
    }
    mav.addObject("listone", listone);

    CategoryVO categoryVO = categoryDAO.read(categoryno);
    mav.addObject("categoryVO", categoryVO);
    mav.addObject("root", request.getContextPath());

    totalRecord = blogDAO.count(hashMap);
    mav.addObject("totalRecord", blogDAO.count(hashMap)); // �˻��� ���ڵ� ����

    String paging = new Paging().paging(categoryno, totalRecord, searchDTO.getNowPage(), recordPerPage,
        searchDTO.getCol(), searchDTO.getWord());
    mav.addObject("paging", paging);
    return mav;
  }

}
