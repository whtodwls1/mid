package dev.mvc.mid;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import dev.mvc.purchase.Mid_PurchaseVO;
import web.tool.Tool;
import web.tool.Upload;

@Controller
public class MidCont {
  @Autowired
  @Qualifier("dev.mvc.mid.MidDAO")
  private MidDAOInter midDAO;

  public MidCont() {
    System.out.println("--> MidCont created.");
  }

  @RequestMapping(value = "/mid/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/mid/create");
    return mav;
  }

  @RequestMapping(value = "/mid/create.do", method = RequestMethod.POST)
  public ModelAndView create(MidVO midVO, HttpServletRequest request, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/mid/message");

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    // 파일 전송
    String thumb1 = "";
    String poster = "";
    String file2 = "";
    String upDir = Tool.getRealPath(request, "/blog/storage");
    MultipartFile file1MF = midVO.getFile1MF();
    MultipartFile file2MF = midVO.getFile2MF();
    file2 = Upload.saveFileSpring(file1MF, upDir);
    poster = Upload.saveFileSpring(file2MF, upDir);
    midVO.setFile2(file2);
    midVO.setPoster(poster);

    if (Tool.isImage(poster)) {
      thumb1 = Tool.preview(upDir, poster, 355, 200);
    } else {
      thumb1 = "";
    }
    
    //
    midVO.setThumb1(thumb1); // 덤프
    midVO.setPoster(poster); // 메인이미지
    midVO.setFile2(file2); // 원본
    //
    String genre = request.getParameter("genre");
    midVO.setGenre(genre);

    if (midDAO.create(midVO) == 1) {
      msgs.add("글을 등록했습니다.");
      links.add("<button type='button' onclick=\"location.href='./create.do?midnum=" + midVO.getMidnum()
          + "'\">계속 등록</button>");
    }
    links.add(
        "<button type='button' onclick=\"location.href='./list.do?midnum=" + midVO.getMidnum() + "'\">목록</button>");
    mav.addObject("msgs", msgs);
    mav.addObject("links", links);
    return mav;
  }

  @RequestMapping(value = "/mid/update.do", method = RequestMethod.GET)
  public ModelAndView update(int midnum) {
    ModelAndView mav = new ModelAndView();

    mav.setViewName("/mid/update");
    MidVO vo = midDAO.read(midnum);
    mav.addObject("vo", vo);

    return mav;
  }

  @RequestMapping(value = "/mid/update.do", method = RequestMethod.POST)
  public ModelAndView update(MidVO vo, HttpServletRequest request) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/mid/message");
 ArrayList<String> links=new ArrayList<String>();
    
    String thumb1 = "";
    String file2 = "";
    String poster = "";
    long size = 0;
    String upDir = Tool.getRealPath(request, "/blog/storage");
    MultipartFile file1MF = vo.getFile1MF();
    MultipartFile file2MF = vo.getFile2MF();

    MidVO oldvo = midDAO.read(vo.getMidnum());
    
    size = file1MF.getSize();
    if (size > 0) {
      Tool.deleteFile(upDir,oldvo.getFile2());
      file2=Upload.saveFileSpring(file1MF, upDir);    
    } else {  
      file2=oldvo.getFile2();
    }
    
    size=file2MF.getSize();
    if(size>0){
      Tool.deleteFile(upDir,oldvo.getPoster());
      poster=Upload.saveFileSpring(file2MF, upDir);
      if (Tool.isImage(poster)) {
        Tool.deleteFile(upDir, oldvo.getThumb1());
        thumb1 = Tool.preview(upDir, poster, 355, 200);
      } else {
        thumb1 = "";
      }
    }else{
      poster=oldvo.getPoster();
      thumb1=oldvo.getThumb1();
    }
    
    vo.setPoster(poster);
    vo.setThumb1(thumb1);
    vo.setFile2(file2);
    
    if(midDAO.update(vo)==1){
      midDAO.update(vo);
      mav.setViewName("redirect:./list.do");
    }else{
      links.add(
          "<button type='button' onclick=\"location.href='./list.do?midnum=" + vo.getMidnum() + "'\">실패 목록</button>");
    }
    
    mav.addObject("vo", vo);
    return mav;
  }

  @RequestMapping(value = "/mid/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int midnum) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/mid/delete");
    

    mav.addObject("midnum", midnum);
    return mav;
  }

  @RequestMapping(value = "/mid/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(HttpServletRequest request, MidVO midVO) {
    ModelAndView mav = new ModelAndView();

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    String upDir = Tool.getRealPath(request, "/blog/storage");
    MidVO oldVO = midDAO.read(midVO.getMidnum());
    String thumb1 = oldVO.getThumb1();
    String file2 = oldVO.getFile2();

    if (midDAO.delete(midVO.getMidnum()) == 1) {
      Tool.deleteFile(upDir, thumb1);
      Tool.deleteFile(upDir, file2);
      mav.setViewName("redirect:/mid/list.do");
    } else {
      mav.setViewName("/mid/message");
      msgs.add("글 삭제 실패");

      links.add("<button type='button' onclick=\"history.back()\"> 다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list'\"> 목록</button>");
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }

    return mav;
  }

  @ResponseBody
  @RequestMapping(value = "/mid/uplike.do", method = RequestMethod.POST)
  public String uplike(int cnt,int midnum, HttpServletRequest request) {
    JSONObject obj = new JSONObject();
    
   cnt++;
    Map map=new HashMap();
    map.put("midlike", cnt);
    map.put("midnum", midnum);
       midDAO.uplike(map);
       
    obj.put("cnt", cnt);
    return obj.toJSONString();
  }
  
  @RequestMapping(value = "/mid/read.do", method = RequestMethod.GET)
  public ModelAndView read(int midnum,HttpSession session,HttpServletRequest request) {
    ModelAndView mav = new ModelAndView();
    

   try{
     String id=session.getAttribute("id").toString();  
   if(id!=null){
     mav.setViewName("/mid/read");
     midDAO.viewcnt(midnum);
     MidVO vo= midDAO.read(midnum);
   
    mav.addObject("vo", vo);
   }
   }catch(Exception e){
     ArrayList<String> msgs = new ArrayList<String>();
     ArrayList<String> links = new ArrayList<String>();
     mav.setViewName("/mid/message");
     msgs.add("로그인 후 실행가능");
     links.add("<button type='button' onclick=\"location.href='/blog/member/login.do'\"> 로그인</button>");
     links.add("<button type='button' onclick=\"location.href='/blog/yego/list.do'\"> 홈으로</button>");
     mav.addObject("msgs",msgs);
     mav.addObject("links",links);
   }
   return mav;
  }
  

  @RequestMapping(value = "/mid/list.do", method = RequestMethod.GET)
  public ModelAndView list(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    try{
      String id=session.getAttribute("id").toString();  
    if(id!=null){
      mav.setViewName("/mid/list");
      List<MidVO> list = midDAO.list();
      mav.addObject("list", list);
    }
    }catch(Exception e){
      ArrayList<String> msgs = new ArrayList<String>();
      ArrayList<String> links = new ArrayList<String>();
      mav.setViewName("/mid/message");
      msgs.add("로그인 후 실행가능");
      links.add("<button type='button' onclick=\"location.href='/blog/member/login.do'\"> 로그인</button>");
      links.add("<button type='button' onclick=\"location.href='/blog/yego/list.do'\"> 홈으로</button>");
      mav.addObject("msgs",msgs);
      mav.addObject("links",links);
    }
      
    return mav;
  }
  @RequestMapping(value = "/mid/listgenre.do", method = RequestMethod.GET)
  public ModelAndView listgenre(String genre,HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    try{
      String id=session.getAttribute("id").toString();  
    if(id!=null){
      mav.setViewName("/mid/listgenre");
      MidVO vo=new MidVO();
      vo.setGenre(genre);
      List<MidVO> listgenre = midDAO.listgenre(genre);
      mav.addObject("listgenre", listgenre);
      mav.addObject("genre",genre);
    }
    }catch(Exception e){
      ArrayList<String> msgs = new ArrayList<String>();
      ArrayList<String> links = new ArrayList<String>();
      mav.setViewName("/mid/message");
      msgs.add("로그인 후 실행가능");
      links.add("<button type='button' onclick=\"location.href='/blog/member/login.do'\"> 로그인</button>");
      links.add("<button type='button' onclick=\"location.href='/blog/yego/list.do'\"> 홈으로</button>");
      mav.addObject("msgs",msgs);
      mav.addObject("links",links);
    }

    return mav;
  }
  @RequestMapping(value = "/mid/listtitle.do", method = RequestMethod.GET)
  public ModelAndView listtitle(String midtitle,HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    try{
      String id=session.getAttribute("id").toString();  
    if(id!=null){
      mav.setViewName("/mid/listtitle");
      MidVO vo=new MidVO();
      vo.setMidtitle(midtitle);
      List<Mid_PurchaseVO> listtitle = midDAO.listtitle(midtitle);
      mav.addObject("listtitle", listtitle);
      mav.addObject("midtitle",midtitle);
    }
    
    }catch(Exception e){
      ArrayList<String> msgs = new ArrayList<String>();
      ArrayList<String> links = new ArrayList<String>();
      mav.setViewName("/mid/message");
      msgs.add("로그인 후 실행가능");
      links.add("<button type='button' onclick=\"location.href='/blog/member/login.do'\"> 로그인</button>");
      links.add("<button type='button' onclick=\"location.href='/blog/yego/list.do'\"> 홈으로</button>");
      mav.addObject("msgs",msgs);
      mav.addObject("links",links);
      
    }

    return mav;
  }
  
  @RequestMapping(value = "/mid/review.do", method = RequestMethod.GET)
  public ModelAndView review(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    try{
      String id=session.getAttribute("id").toString();  
    if(id!=null){
      mav.setViewName("/mid/review");
      List<MidVO> list = midDAO.list();
      mav.addObject("list", list);
    }
    }catch(Exception e){
      ArrayList<String> msgs = new ArrayList<String>();
      ArrayList<String> links = new ArrayList<String>();
      mav.setViewName("/mid/message");
      msgs.add("로그인 후 실행가능");
      links.add("<button type='button' onclick=\"location.href='/blog/member/login.do'\"> 로그인</button>");
      links.add("<button type='button' onclick=\"location.href='/blog/yego/list.do'\"> 홈으로</button>");
      mav.addObject("msgs",msgs);
      mav.addObject("links",links);
    }
   
    return mav;
  }
}
