package dev.mvc.yego;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.mid.MidVO;
import web.tool.Tool;
import web.tool.Upload;

@Controller
public class YegoCont {
  @Autowired
  @Qualifier("dev.mvc.yego.YegoDAO")
  private YegoDAOInter yegoDAO;

  public YegoCont() {
    System.out.println("--> YegoCont created.");
  }
  
  @RequestMapping(value = "/yego/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/yego/create");
    return mav;
  }
  
  @RequestMapping(value = "/yego/create.do", method = RequestMethod.POST)
  public ModelAndView create(YegoVO yegoVO, HttpServletRequest request, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/yego/message");

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    // 파일 전송
    String yegothumb = "";
    String yegoimage = "";
    String file3 = "";
    
    String upDir = Tool.getRealPath(request, "/blog/storage");
    MultipartFile file3MF = yegoVO.getFile3MF();
    MultipartFile file4MF = yegoVO.getFile4MF();
    
    file3 = Upload.saveFileSpring(file3MF, upDir);
    yegoimage = Upload.saveFileSpring(file4MF, upDir);
    
    if (Tool.isImage(yegoimage)) {
      yegothumb = Tool.preview(upDir, yegoimage, 355, 200);
    } else {
      yegothumb = "";
    }

    //
    yegoVO.setYegothumb(yegothumb); // 덤프
    yegoVO.setYegoimage(yegoimage); // 메인이미지
    yegoVO.setFile3(file3); // 원본
    //
    if (yegoDAO.create(yegoVO) == 1) {
      /*
       * Mid_PurchaseVO vo= midVO.getMidnum();
       * purchaseDAO.create("Mid_PurchaseVO, vo)
       */ msgs.add("글을 등록했습니다.");
      links.add("<button type='button' onclick=\"location.href='./create.do?midnum=" + yegoVO.getYegono()
          + "'\">계속 등록</button>");
    }
    links.add(
        "<button type='button' onclick=\"location.href='./list.do?midnum=" + yegoVO.getYegono() + "'\">목록</button>");
    mav.addObject("msgs", msgs);
    mav.addObject("links", links);
    return mav;
  }
  
  @RequestMapping(value = "/yego/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/yego/list");
    List<YegoVO> list = yegoDAO.list();
    mav.addObject("list", list);

    return mav;
  }
  
  @RequestMapping(value = "/yego/read.do", method = RequestMethod.GET)
  public ModelAndView read(int yegono) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/yego/read");
    /*midDAO.viewcnt(midnum);*/
    YegoVO vo = yegoDAO.read(yegono);
    mav.addObject("vo", vo);

    return mav;
  }
  
  @RequestMapping(value = "/yego/update.do", method = RequestMethod.GET)
  public ModelAndView update(int yegono) {
    ModelAndView mav = new ModelAndView();

    mav.setViewName("/yego/update");
    YegoVO vo = yegoDAO.read(yegono);
    mav.addObject("vo", vo);

    return mav;
  }

  @RequestMapping(value = "/yego/update.do", method = RequestMethod.POST)
  public ModelAndView update(YegoVO vo, HttpServletRequest request) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/yego/message");
    ArrayList<String> links = new ArrayList<String>();

    String yegothumb = "";
    String yegoimage = "";
    String file3 = "";
    
    long size = 0;
    String upDir = Tool.getRealPath(request, "/blog/storage");
    MultipartFile file3MF = vo.getFile3MF();
    MultipartFile file4MF = vo.getFile4MF();

    YegoVO oldvo = yegoDAO.read(vo.getYegono());

    size = file3MF.getSize();
    if (size > 0) {
      Tool.deleteFile(upDir, oldvo.getFile3());
      file3 = Upload.saveFileSpring(file3MF, upDir);
    } else {
      file3 = oldvo.getFile3();
    }

    size = file4MF.getSize();
    if (size > 0) {
      Tool.deleteFile(upDir, oldvo.getYegoimage());
      yegoimage = Upload.saveFileSpring(file4MF, upDir);
      if (Tool.isImage(yegoimage)) {
        Tool.deleteFile(upDir, oldvo.getYegothumb());
        yegothumb = Tool.preview(upDir, yegoimage, 355, 200);
      } else {
        yegothumb = "";
      }
    } else {
      yegoimage = oldvo.getYegoimage();
      yegothumb = oldvo.getYegothumb();
    }

    vo.setYegoimage(yegoimage);
    vo.setYegothumb(yegothumb);
    vo.setFile3(file3);

    if (yegoDAO.update(vo) == 1) {
      yegoDAO.update(vo);
      mav.setViewName("redirect:./list.do");
    } else {
      links.add(
          "<button type='button' onclick=\"location.href='./list.do?yegono=" + vo.getYegono() + "'\">실패 목록</button>");
    }

    mav.addObject("vo", vo);
    return mav;
  }
  
  @RequestMapping(value = "/yego/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int yegono) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/yego/delete");
    mav.addObject("yegono", yegono);
    return mav;
  }
  @RequestMapping(value = "/yego/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(HttpServletRequest request, YegoVO yegoVO) {
    ModelAndView mav = new ModelAndView();

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    String upDir = Tool.getRealPath(request, "/blog/storage");
    YegoVO oldVO = yegoDAO.read(yegoVO.getYegono());
    String yegothumb = oldVO.getYegothumb();
    String file3 = oldVO.getFile3();

    if (yegoDAO.delete(yegoVO.getYegono()) == 1) {
      Tool.deleteFile(upDir, yegothumb);
      Tool.deleteFile(upDir, file3);
      mav.setViewName("redirect:/yego/list.do");
    } else {
      mav.setViewName("/yego/message");
      msgs.add("글 삭제 실패");

      links.add("<button type='button' onclick=\"history.back()\"> 다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list'\"> 목록</button>");
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }

    return mav;
  }
}