<%@ page contentType="text/html; charset=UTF-8"%>
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

<script type="text/javascript">
  $(function(){
    $('#file1').load(function(){ // 태그 메모리 상주후 작동
      // var width = $('#file1').width();
      //alert('file1: ' + width); 
      if ($('#file1').width() > screen.width * 0.7){
        $('#file1').width('70%');      
      }
    });
  });
  
</script>
</head>

<body>
  <jsp:include page="/menu/top.jsp" flush='false' />
     
  <div class='content_menu'>
    <DIV style='float: left;'>
      <A href='../category/list.do'>게시판 목록</A> >
      <A href='./list_total.do?categoryno=1&col=${searchDTO.col}&word=${searchDTO.word}&nowPage=${searchDTO.nowPage}'>${categoryVO.title }</A>
    </DIV>
    <DIV style='float: right;'>
      <A href='./list.do?categoryno=${blogVO.categoryno}&col=${searchDTO.col}&word=${searchDTO.word}&nowPage=${searchDTO.nowPage}'>목록</A><span class='hdiv'>ㅣ</span>
      
    <!-- 관리자 구현 -->
    <%
      try {
      if(session.getAttribute("id")!=null){
      %>
      <A href='./create.do?categoryno=${blogVO.categoryno}'>등록</A><span class='hdiv'>ㅣ</span>
      <A href='./reply.do?categoryno=${blogVO.categoryno}&blogno=${blogVO.blogno}&nowPage=${searchDTO.nowPage}'>답변</A><span class='hdiv'>ㅣ</span>
<%
        if (session.getAttribute("id").toString().equals("admin")) {
    %>     
      <A href='./update.do?categoryno=${blogVO.categoryno}&blogno=${blogVO.blogno}&col=${searchDTO.col}&word=${searchDTO.word}&nowPage=${searchDTO.nowPage}'>수정</A><span class='hdiv'>ㅣ</span>
      <A href='./delete.do?categoryno=${blogVO.categoryno}&blogno=${blogVO.blogno}&col=${searchDTO.col}&word=${searchDTO.word}&nowPage=${searchDTO.nowPage}'>삭제</A>
      <%
      }
}
      } catch (Exception e) {
      }
    %>
    <!-- 관리자 구현 -->
    </DIV>
  </div>
  <div class='menu_line'></div>
  <DIV class='content'>
      <fieldset class="fieldset">
        <ul>
          <li>
            <label for='title' style="width:150px;">제목 : </label>
            <span>${blogVO.title}</span><br>
          </li>
          <li>
            <label for='content' style="width:150px;">내용 : </label>
            <span>${blogVO.content}</span>
          </li>
          <li>
            <label for="good" style="width:150px;">추천 수 : </label>
            <span>${blogVO.good}</span>
          </li>
          <li>
            <label for="rdate" style="width:150px;">등록일 : </label>
            <span>${blogVO.rdate.substring(0, 16)}</span>
          </li>
          <li>
            <label for="file1" style="width:150px;">업로드 파일: </label>
            <span>
              <c:if test="${blogVO.size1 > 0}">
                <A href='${pageContext.request.contextPath}/download?dir=/blog/storage&filename=${blogVO.file1}'>${blogVO.file1}</A> (${blogVO.size1Label})
              </c:if>
            </span>    
            <div id='file2Panel'>
              <c:set var='file1' value="${fn:toLowerCase(blogVO.file1)}" />
              <c:choose>
                <c:when test="${fn:endsWith(file1, '.jpg')}">
                  <IMG id='file1' src='./storage/${blogVO.file1}' >
                </c:when>
                <c:when test="${fn:endsWith(file1, '.gif')}">
                  <IMG id='file1'  src='./storage/${blogVO.file1}' >
                </c:when>
                <c:when test="${fn:endsWith(file1, '.png')}">
                  <IMG id='file1'  src='./storage/${blogVO.file1}'' >
                </c:when>
              </c:choose>
            </div>
          </li>
          <li>
            <label for="" style="width:150px;">블로그 카테고리 번호 : </label>
            <span>${blogVO.categoryno}</span>
          </li>
        </ul>
      </fieldset>
  </DIV>


  <jsp:include page="/menu/bottom.jsp" flush='false' />     
</body>

</html>

