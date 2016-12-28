<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
<script type="text/javascript" src="../js/tool.js"></script>
<script type="text/javascript">
$(function(){

});
</script>
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush='false' />
     
<DIV class='title' style='width: 40%;'>카테고리(게시판) 목록</DIV>

<TABLE class='table table-hover'>
  <caption>관리자만 접근 할 수 있습니다.</caption>
  <thead>
  <TR>
    <TH>번호</TH>
    <TH>게시판(제목)</TH>
    <TH>순서</TH>
    <TH>모드</TH>
    <TH>접근계정</TH>
    <TH>글수</TH>
    <TH>기타</TH>
  </TR>
  </thead>
  
  <c:forEach var="vo" items="${list}"> 
  <TR>
    <TD>${vo.categoryno}</TD>
    <TD><A href='../blog/list.do?categoryno=${vo.categoryno}'>${vo.title}</A></TD>
    <TD>${vo.seqno}</TD>
    <TD>${vo.visible}</TD>
    <TD>${vo.ids}</TD>
    <TD>${vo.cnt}</TD>
    <TD>
      <A href="./update.do?categoryno=${vo.categoryno}"><IMG src='./images/update.png' title='수정'></A>
      <A href="./delete.do?categoryno=${vo.categoryno}"><IMG src='./images/delete.png' title='삭제'></A>
      <A href="./up.do?categoryno=${vo.categoryno}"><IMG src='./images/up.jpg' title='우선 순위 증가' style='width: 20px;'></A>
      <A href="./down.do?categoryno=${vo.categoryno}"><IMG src='./images/down.jpg' title='우선 순위 감소' style='width: 20px;'></A>
    </TD>
  </TR>
  </c:forEach>

</TABLE>

<DIV class='bottom'>
  <button type='button' onclick="location.href='./create.do'">등록</button>
  <button type='button' onclick="location.reload();">새로 고침</button>
</DIV>


<jsp:include page="/menu/bottom.jsp" flush='false' />     
</body>

</body>
</html> 


