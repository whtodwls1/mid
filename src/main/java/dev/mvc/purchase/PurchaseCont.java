package dev.mvc.purchase;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.SynchronousQueue;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.member.MemberDAOInter;
import dev.mvc.member.MemberVO;
import dev.mvc.mid.MidDAOInter;
import dev.mvc.mid.MidVO;

@Controller
public class PurchaseCont {
  @Autowired
  @Qualifier("dev.mvc.purchase.PurchaseDAO")
  private PurchaseDAOInter purchaseDAO;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberDAO")
  private MemberDAOInter MemberDAO;
  
  @Autowired
  @Qualifier("dev.mvc.mid.MidDAO")
  private MidDAOInter MidDAO;

  public PurchaseCont() {
    System.out.println("--> PurchaseCont created");
  }

  @RequestMapping(value = "/purchase/create.do", method = RequestMethod.GET)
  public ModelAndView create(HttpSession session) {
    System.out.println("--> create() get called");
    ModelAndView mav = new ModelAndView();
    
    
    
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
  @RequestMapping(value = "/purchase/create.do", method = RequestMethod.POST)
  public ModelAndView create(PurchaseVO purchaseVO, HttpServletRequest request, HttpSession session) {
    System.out.println("--> create() POST called.");
    ModelAndView mav = new ModelAndView();
    

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    // -------------------------------------------------------------------
   
      try{
        String id= session.getAttribute("id").toString();
        MemberVO memberVO=MemberDAO.sessionid(id);
        purchaseVO.setMno(memberVO.getMno());   

    if (purchaseDAO.create(purchaseVO) == 1) {
      mav.setViewName("/purchase/purchase");
    }   
    }catch(Exception e){
      mav.setViewName("/purchase/message");
      msgs.add("������ ���ſ� �����߽��ϴ�.");
      msgs.add("�ٽ� �õ����ּ���.");
      links.add("<button type='button' onclick=\"history.back()\">�ٽýõ�</button>");
 
    }

   
    links.add("<button type='button' onclick=\"location.href='./list.do?purnum=" + purchaseVO.getPurnum()
        + "'\">���</button>");
    mav.addObject("msgs", msgs);
    mav.addObject("links", links);

    return mav;
  }
  
  /**
   * Categrp, Category ���̺��� ���캰�� �з��Ͽ� �����ɴϴ�.
   * @return
   */
  @RequestMapping(value = "/purchase/list.do", 
                             method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/purchase/list"); // /purchase/list.jsp
    
    List<Mid_PurchaseVO> list = purchaseDAO.list();
   /* MNO ID    MIDNUM GENRE THUMB1 MIDTITLE PRICE REGDATE               WATCH PURNUM MIDNUM ENDREG
    --- ----- ------ ----- ------ -------- ----- --------------------- ----- ------ ------ ---------------------
      1 user1      1 df    sd     gss         13 2016-12-17 15:18:02.0    12      1      1 2016-12-17 15:19:12.0
      2 user2      1 df    sd     gss         13 2016-12-17 15:18:02.0    12      1      1 2016-12-17 15:19:12.0
      3 user3      1 df    sd     gss         13 2016-12-17 15:18:02.0    12      1      1 2016-12-17 15:19:12.0
      1 user1      2 df    sd     gss         13 2016-12-17 15:18:12.0    12      2      2 2016-12-17 15:19:13.0
      2 user2      2 df    sd     gss         13 2016-12-17 15:18:12.0    12      2      2 2016-12-17 15:19:13.0
      3 user3      2 df    sd     gss         13 2016-12-17 15:18:12.0    12      2      2 2016-12-17 15:19:13.0
      1 user1      3 df    sd     gss         13 2016-12-17 15:18:53.0    12      3      3 2016-12-17 15:19:14.0
      2 user2      3 df    sd     gss         13 2016-12-17 15:18:53.0    12      3      3 2016-12-17 15:19:14.0
      3 user3      3 df    sd     gss         13 2016-12-17 15:18:53.0    12      3      3 2016-12-17 15:19:14.0*/


    mav.addObject("list", list);
 
    return mav;
  }
  
  /**
   * Categrp, Category ���̺��� ���캰�� �з��Ͽ� �����ɴϴ�.
   * @return
   */
  @RequestMapping(value = "/purchase/pur_list.do", 
                             method = RequestMethod.GET)
  public ModelAndView pur_list(String midtitle,PurchaseVO purchaseVO,HttpSession session) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/purchase/pur_list"); // /purchase/pur_list.jsp
    List<MidVO> pur_list= MidDAO.midtitle(midtitle);
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    // -------------------------------------------------------------------
   
      try{
        String id= session.getAttribute("id").toString();
        MemberVO memberVO=MemberDAO.sessionid(id);
        purchaseVO.setMno(memberVO.getMno());   
        purchaseVO.setMidnum(1);

    if (purchaseDAO.create(purchaseVO) == 1) {
      mav.setViewName("/purchase/pur_list");
    }   
    }catch(Exception e){
      mav.setViewName("/purchase/message");
      msgs.add("������ ���ſ� �����߽��ϴ�.");
      msgs.add("�ٽ� �õ����ּ���.");
      links.add("<button type='button' onclick=\"history.back()\">�ٽýõ�</button>");
 
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }

   
   

    
    
  
    
    

    mav.addObject("pur_list", pur_list);
 
    return mav;
  }
  
  /**
   * Categrp, Category ���̺��� ���캰�� �з��Ͽ� �����ɴϴ�.
   * @return
   */
  @RequestMapping(value = "/purchase/purchase.do", 
                             method = RequestMethod.GET)
  public ModelAndView purchase(int midnum, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/purchase/purchase"); // /purchase/purchase.jsp
    
    List<Mid_PurchaseVO> purchase = purchaseDAO.purchase(midnum);
    
    
/*    MIDTITLE THUMB1                 '20'||TO_CHAR(TO_DATE(P.PURREG)) '20'||TO_CHAR(TO_DATE(P.PURREG+D.WATCH)) WATCH
    -------- ---------------------- -------------------------------- ---------------------------------------- -----
    gss      sd                     2016/12/17                       2016/12/29                                  12
    gss      sd                     2016/12/17                       2016/12/29                                  12
    gss      sd                     2016/12/17                       2016/12/29                                  12
    gss      sd                     2016/12/20                       2017/01/01                                  12
    �ʹ��ʹ��ʹ�   (0)maxresdefault_t.jpg 2016/12/20                       2016/12/21                                   1*/
    System.out.println("�ǳ�");
   

    mav.addObject("purchase", purchase);
 
    return mav;
  }
  
  /**
   * ���� �� ���
   * @return
   */
  @RequestMapping(value = "/purchase/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int purnum) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/purchase/delete"); // /webapp/purchase/delete.jsp
    mav.addObject("purnum",  purnum);
    
    return mav;
  }
  
  /**
   * ���ڵ� 1���� �����մϴ�.
   * @param categoryno
   * @return
   */
  @RequestMapping(value = "/purchase/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(PurchaseVO purchaseVO) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/purchase/message");
 
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
 
    if (purchaseDAO.delete(purchaseVO.getPurnum()) == 1) {
      mav.setViewName("redirect:/purchase/list.do");
    } else {
      msgs.add("������ �����߽��ϴ�.");
      msgs.add("�ٽ� �õ����ּ���.");
      links.add("<button type='button' onclick=\"history.back()\">�ٽýõ�</button>");
      
    }
    links.add("<button type='button' onclick=\"location.href='./home.do'\">Ȩ������</button>");
    links.add("<button type='button' onclick=\"location.href='./list.do'\">���</button>");

    mav.addObject("msgs", msgs);
    mav.addObject("links", links);
    return mav;
  }

}