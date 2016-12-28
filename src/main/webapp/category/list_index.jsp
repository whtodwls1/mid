<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
String root = request.getContextPath();
%>

<style type="text/css">
.categrp_category{
  width: 100%;
  margin: 0px auto; 
  border-left: none; 
  border-right: none;
  border-top: solid 1px #DDDDDD;  
  border-bottom: solid 1px #DDDDDD;  
  text-align: left;
}
.categrp_category_list{
  padding-left: 10%; 
  line-height: 15px;
}

.name_title{
  list-style-image: url("<%=root %>/category/images/title.png");
}
</style>

<fieldset class='categrp_category' >
  <legend style='margin-bottom: 0px; padding-bottom: 0px;'>▷ 카테고리</legend>
  <DIV>
    <img src='<%=root %>/category/images/title.png'>
    <A href="<%=root %>/blog/list_total.do">전체 보기</A>
    <span style='font-size:0.9em; color: #555555;'>(${total_count })</span>
  </DIV>
  <UL class='categrp_category_list' >
    <c:forEach var="str" items="${list}">
      ${str}
    </c:forEach>
  </UL>
</fieldset>
<br>

