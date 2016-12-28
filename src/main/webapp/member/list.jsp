<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="../js/jquery.cookie.js"></script>
<script type="text/javascript" src="../js/tool.js"></script><base>

<script type="text/javascript">
$(function(){

});
</script>
</head> 
<!-- ----------------------------------------- -->
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<!-- ----------------------------------------- -->

<DIV class='title'>회원 목록</DIV>

<TABLE class='table'>
  <caption>관리자만 접근가능합니다.</caption>
  <colgroup>
    <col style='width: 5%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 20%;'/>
    <col style='width: 30%;'/>
    <col style='width: 15%;'/>
    <col style='width: 10%;'/>
  </colgroup>
  <TR>
    <TH >번호</TH>
    <TH >ID</TH>
    <TH >성명</TH>
    <TH>전화번호</TH>
    <TH >주소</TH>
    <TH >등록일</TH>
    <TH>기타</TH>
  </TR>

  <c:forEach var="vo" items="${list }">
  <TR>
    <TD class='td'>${vo.mno }</TD>
    <TD class='td'><A href="./read.do?mno=${vo.mno }">${vo.id }</A></TD>
    <TD class='td'><A href="./read.do?mno=${vo.mno }">${vo.mname }</A></TD>
    <TD class='td'>${vo.tel}</TD>
    <TD class='td'>
    <c:choose>
      <c:when test="${vo.address1.length() > 15}">
        ${vo.address1.substring(0, 15) }...
      </c:when>
      <c:otherwise>
         ${vo.address1 }
      </c:otherwise>
    </c:choose> 
    </TD>
    <TD class='td'>${vo.mdate.substring(0, 10) }</TD>
    <TD class='td'>
      <A href="./passwd.do?mno=${vo.mno }"><IMG src='./images/passwd.png' title='패스워드 변경'></A>
      <A href="./read.do?mno=${vo.mno }"><IMG src='./images/update.png' title='수정'></A>
      <A href="./delete.do?mno=${vo.mno }"><IMG src='./images/delete.png' title='삭제'></A>
    </TD>
    
  </TR>
  </c:forEach>

</TABLE>

<DIV class='bottom'>
  <button type='button' onclick="location.href='./create.do'">등록</button>
  <button type='button' onclick="location.reload();">새로 고침</button>
</DIV>
<!-- -------------------------------------------- -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
<!-- -------------------------------------------- -->
</html> 

