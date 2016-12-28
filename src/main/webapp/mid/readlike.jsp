<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="dev.mvc.mid.MidVO"%>
<%@page import="dev.mvc.mid.MidDAO"%>
<%@page import="dev.mvc.mid.MidDAOInter"%>
<%@ page contentType="text/plain; charset=UTF-8" %> 
<%@ page import="org.json.simple.*" %>
 
<%

MidDAOInter midDAO=new MidDAO();
MidVO vo=new MidVO();
Map map=new HashMap();
// http://localhost:9090/jsp_test/jquery/good_up.jsp?no=1&cnt=0

int cnt = Integer.parseInt(request.getParameter("cnt"));
 
JSONObject obj = new JSONObject();
//JSONArray list = new JSONArray();
cnt++;

obj.put("cnt", cnt);
map.put("midlike",cnt);
map.put("midnum",1);
/* vo.setMidlike(cnt);
vo.setMidnum(1); */
midDAO.uplike(map);


out.print(obj);
%>