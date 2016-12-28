package dev.mvc.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import web.tool.Tool;

@Controller
public class MemberCont {
  @Autowired
  @Qualifier("dev.mvc.member.MemberDAO")
  private MemberDAOInter memberDAO;

  public MemberCont() {
    System.out.println("--> MemberCont created.");
  }
/*관리자*/
  @ResponseBody
  @RequestMapping(value = "/member/admin.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public ModelAndView admin() {
    ModelAndView mav=new ModelAndView();
    mav.setViewName("/member/admin");
    

    return mav;
  }
  
  
  /**
   * 중복 아이디를 검사합니다.
   * 
   * @param id
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/member/checkId.do", method = RequestMethod.POST)
  public String checkId(String id) {
    JSONObject obj = new JSONObject();
    int cnt = memberDAO.checkId(id);

    obj.put("cnt", cnt);
    return obj.toJSONString();
  }

  @RequestMapping(value = "/member/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    System.out.println("--> create() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.addObject("id", "4자이상 입력해주세요.");

    mav.setViewName("/member/create"); // /webapp/member/create.jsp

    return mav;
  }

  @RequestMapping(value = "/member/create.do", method = RequestMethod.POST)
  public ModelAndView create(MemberVO memberVO) {
    System.out.println("--> create() POST called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/message"); // /webapp/member/message.jsp

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    if (memberDAO.create(memberVO) == 1) {
      msgs.add("회원가입이 처리 완료.");
      msgs.add("가입해주셔서 감사합니다.");
      links.add("<button type='button' onclick=\"location.href='./login.do'\">로그인</button>");
      links.add("<button type='button' onclick=\"location.href='/blog/yego/list.do'\">홈페이지</button>");
    } else {
      msgs.add("회원 가입에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요.");
      links.add("<button type='button' onclick=\"history.back()\">다시시도</button>");
      links.add("<button type='button' onclick=\"location.href='/blog/yego/list.do'\">홈페이지</button>");
    }

   

    mav.addObject("msgs", msgs); // request.setAttribute("msgs", msgs);
    mav.addObject("links", links); // request.setAttribute("links", links);

    return mav;
  }

  /**
   * 전체 목록을 출력합니다.
   * 
   * @return
   */
  @RequestMapping(value = "/member/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/list"); // /webapp/member/list.jsp

    // mav.addObject("list", memberDAO.list());

    List<MemberVO> list = memberDAO.list();
    mav.addObject("list", list);

    return mav;
  }

  @RequestMapping(value = "/member/read.do", method = RequestMethod.GET)
  public ModelAndView read(int mno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/read");  // /webapp/member/read.jsp
    
    // mav.addObject("memberVO", memberDAO.read(mno));
    MemberVO memberVO = memberDAO.read(mno);
    mav.addObject("memberVO", memberVO);
    
    return mav;
  }

  @RequestMapping(value = "/member/update.do", method = RequestMethod.POST)
  public ModelAndView update(MemberVO memberVO) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/message");

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    if (memberDAO.update(memberVO) == 1) {
      msgs.add("회원정보가 수정되었습니다.");
      links.add("<button type='button' onclick=\"location.href='./read.do?mno="+memberVO.getMno()+"'\">변경된 회원정보 확인</button>");
      links.add("<button type='button' onclick=\"location.href='/blog/yego/list.do'\">홈페이지</button>");
    } else {
      msgs.add("회원 정보 변경에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요.");
      links.add("<button type='button' onclick=\"history.back()\">다시시도</button>");
      links.add("<button type='button' onclick=\"location.href='/blog/yego/list.do'\">홈페이지</button>");
    }

    

    mav.addObject("msgs", msgs);
    mav.addObject("links", links);

    return mav;
  }

  /**
   * 패스워드 변경폼 출력
   * @param mno 회원 번호
   * @return 
   */
  @RequestMapping(value = "/member/passwd.do", 
                             method = RequestMethod.GET)
  public ModelAndView passwd(int mno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/passwd"); // /webapp/member/passwd.jsp

    mav.addObject("mno", mno);
    return mav;
  }
  
  /**
   * 패스워드 변경 처리
   * @param memberVO
   * @return
   */
  @RequestMapping(value = "/member/passwd.do", 
                             method = RequestMethod.POST)
  public ModelAndView passwd(MemberVO memberVO) {
    System.out.println("기존 패스워드: " + memberVO.getOld_passwd());
    System.out.println("새로운 패스워드: " + memberVO.getPasswd());
    
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/message");

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    // 현재 패스워드 일치 여부 검사
    Map map = new HashMap();
    map.put("mno", memberVO.getMno());
    map.put("passwd", memberVO.getOld_passwd());
    if (memberDAO.passwdCheck(map) == 1){
      // 패스워드 변경 실행
      map.put("passwd", memberVO.getPasswd());
      if (memberDAO.update_passwd(map) == 1) {
        msgs.add("패스워드를 변경했습니다.");
        links.add("<button type='button' onclick=\"location.href='./home.do'\">홈페이지</button>");
      } else {
        msgs.add("패스워드 변경에 실패했습니다.");
        msgs.add("죄송하지만 다시한번 시도해주세요.");
        links.add("<button type='button' onclick=\"history.back()\">다시시도</button>");
        links.add("<button type='button' onclick=\"location.href='/blog/yego/list.do'\">홈페이지</button>");
      }
    }else{
      msgs.add("현재 패스워드가 일치하지않습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요.");
      links.add("<button type='button' onclick=\"history.back()\">다시시도</button>");
      links.add("<button type='button' onclick=\"location.href='/blog/yego/list.do'\">홈페이지</button>");

    }

    

    mav.addObject("msgs", msgs);
    mav.addObject("links", links);

    return mav;
  }
  
  @RequestMapping(value = "/member/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int mno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/delete"); // /webapp/member/delete.jsp
    mav.addObject("mno", mno); // request.setAttribute("mno", mno);
    
    return mav;
  }

  @RequestMapping(value = "/member/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(MemberVO memberVO) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/message");

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    if (memberDAO.delete(memberVO.getMno()) == 1) {
      msgs.add("회원을 삭제했습니다.");
      links.add("<button type='button' onclick=\"location.href='/blog/yego/list.do'\">홈페이지</button>");
    } else {
      msgs.add("회원 삭제에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요.");
      links.add("<button type='button' onclick=\"history.back()\">다시시도</button>");
      links.add("<button type='button' onclick=\"location.href='/blog/yego/list.do'\">홈페이지</button>");
    }

    

    mav.addObject("msgs", msgs);
    mav.addObject("links", links);

    return mav;
  }
  
  @RequestMapping(value = "/member/login.do", method = RequestMethod.GET)
  public ModelAndView login() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/login_ck_form"); // /webapp/member/login_ck_form.jsp
    
    return mav;
  }

  @RequestMapping(value = "/member/login.do", method = RequestMethod.POST)
  public ModelAndView login(MemberVO memberVO, 
                                       HttpSession session, 
                                       HttpServletRequest request,
                                       HttpServletResponse response) {
    ModelAndView mav = new ModelAndView();

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    if (memberDAO.login(memberVO) == 1) {
      session.setAttribute("id", memberVO.getId());
      session.setAttribute("passwd", memberVO.getPasswd());

      // ------------------------------------------------------------------
      // id 저장 관련 쿠키 저장
      // ------------------------------------------------------------------
      String id_save = Tool.checkNull(memberVO.getId_save());
      if (id_save.equals("Y")){ // id 저장 할 경우
        Cookie ck_id = new Cookie("ck_id", memberVO.getId()); // id 저장
        ck_id.setMaxAge(600); // 초
        response.addCookie(ck_id);
      }else{ // id를 저장하지 않을 경우
        Cookie ck_id = new Cookie("ck_id", ""); 
        ck_id.setMaxAge(0); // 초
        response.addCookie(ck_id);
      }
      // id 저장 여부를 결정하는 쿠기 기록, Y or "" 저장
      Cookie ck_id_save = new Cookie("ck_id_save", memberVO.getId_save());
      ck_id_save.setMaxAge(600); // 초
      response.addCookie(ck_id_save);
      // ------------------------------------------------------------------
   
      // ------------------------------------------------------------------
      // passwd 저장 관련 쿠키 저장
      // ------------------------------------------------------------------
      String passwd_save = Tool.checkNull(memberVO.getPasswd_save());
      if (passwd_save.equals("Y")){ 
        Cookie ck_passwd = new Cookie("ck_passwd", memberVO.getPasswd()); 
        ck_passwd.setMaxAge(600); // 초
        response.addCookie(ck_passwd);
        
      }else{ // passwd를 저장하지 않을 경우
        Cookie ck_passwd = new Cookie("ck_passwd", "");
        ck_passwd.setMaxAge(0); // 초
        response.addCookie(ck_passwd);
        
      }
      // passwd 저장 여부를 결정하는 쿠기 기록, Y or "" 저장
      Cookie ck_passwd_save = new Cookie("ck_passwd_save", memberVO.getPasswd_save());
      ck_passwd_save.setMaxAge(600); // 초
      response.addCookie(ck_passwd_save);
      // ------------------------------------------------------------------

      String url_address = Tool.checkNull(memberVO.getUrl_address());
      if (url_address.length() > 0){
        mav.setViewName("redirect:" + memberVO.getUrl_address());
      }else{
        
        mav.setViewName("redirect:/yego/list.do"); // 확장자 명시
      }
      
    } else {
      mav.setViewName("/member/message");
      msgs.add("로그인에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요.");
      links.add("<button type='button' onclick=\"history.back()\">다시시도</button>");
      links.add("<button type='button' onclick=\"location.href='/blog/yego/list.do'\">홈페이지</button>");
    }

    mav.addObject("msgs", msgs);
    mav.addObject("links", links);

    return mav;
  }
 
  @RequestMapping(value = "/member/logout.do", method = RequestMethod.GET)
  public ModelAndView logout(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/message"); // /webapp/member/message.jsp
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    msgs.add("이용해주셔서 감사합니다.");
    msgs.add("from 왕눈이...");
    links.add("<button type='button' onclick=\"location.href='/blog/yego/list.do'\">홈페이지</button>");
    
    session.invalidate(); // session 변수 삭제
    
    mav.addObject("msgs", msgs);
    mav.addObject("links", links);
    
    return mav;
  }  
  
}



