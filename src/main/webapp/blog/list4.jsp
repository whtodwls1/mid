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

});
</script>

<script type="text/javascript">
</script>
</head>

<body>
<jsp:include page="/menu/top.jsp" flush='false' />

  <form name="frmSearch" method="get" action="./list.do"> 
  <input type='hidden' name='categoryno' id='categoryno' value='${categoryVO.categoryno }'>
  
  <div class='content_menu'>
    <DIV style='float: left;'>
      <A href='../category/list.do'>게시판 목록</A> >
      <A href='./list.do'>${categoryVO.title } (${totalRecord })</A>
    </DIV>
    <DIV style='float: right;'>
      <A href='./create.do?categoryno=${categoryVO.categoryno }'>등록</A><span class='hdiv'>ㅣ</span>
      <A href="javascript:location.reload();">새로고침</A>
      <select name="col"> 
        <option value="">선택</option> 
        <option value="title" ${searchDTO.col == "title" ? "selected=selected" : "" }>제목</option> 
        <option value="content" ${searchDTO.col == "content" ? "selected=selected" : "" }>내용</option> 
        <option value="title_content" ${searchDTO.col == "title_content" ? "selected=selected" : "" }>제목+내용</option> 
        <option value="total" ${searchDTO.col == "" ? "selected=selected" : "" }>전체 목록</option>
      </select>
      <c:choose>
        <c:when test="${searchDTO.col != 'total' }">
          <input type="text" name="word" size="15" value="${searchDTO.word }">
        </c:when>
        <c:when test="${searchDTO.col == 'total' }">
          <input type="text" name="word" size="15" value="">
        </c:when>
      </c:choose>
    <input type="submit" value="검색">
    </DIV>
  </div>
  </form> 
  <div class='menu_line'></div>
  
  <div class="content">
    <table class="table">
      <colgroup>
        <col style="width: 60%;"></col>
        <col style="width: 5%;"></col>
        <col style="width: 15%;"></col>
        <col style="width: 5%;"></col>
        <col style="width: 15%;"></col>
      </colgroup>
          
      <thead>
        <tr>
          <th>제목</th>
          <th>파일</th>
          <th>등록일</th>
          <th>추천</th>
          <th>기타</th>
        </tr>
      </thead>
      
      <tbody>
        <c:forEach var="vo" items="${list }">
          <tr>
            <td style='vertical-align: middle;'>
              <c:choose>
                <c:when test="${vo.ansnum == 0 }">
                  <img src='./images/url4.png' style='width: 14px;'>
                </c:when>
                <c:when test="${vo.ansnum > 0 }">
                  <c:forEach var="indent"  begin="1" end="${vo.indent }" step="1">
                    <img src='./images/white.jpg' style='width: 30px; height: 20px; opacity: 0.0;'>    
                  </c:forEach>
                  <img src='./images/reply3.jpg'> 
                </c:when>
              </c:choose>
              <a href="./read.do?blogno=${vo.blogno}&categoryno=${vo.categoryno}&col=${searchDTO.col}&word=${searchDTO.word}&nowPage=${searchDTO.nowPage}">${vo.title}</a> 
            </td> 
            
            <td style='vertical-align: middle;'>
            <c:choose>
              <c:when test="${vo.thumb != null}">
                <c:set var='thumb' value="${fn:toLowerCase(vo.thumb)}" />
                <c:choose>
                  <c:when test="${fn:endsWith(thumb, '.jpg')}">
                    <IMG id='thumb' src='./storage/${vo.thumb}' >
                  </c:when>
                  <c:when test="${fn:endsWith(thumb, '.gif')}">
                    <IMG id='thumb'  src='./storage/${vo.thumb}' >
                  </c:when>
                  <c:when test="${fn:endsWith(thumb, '.png')}">
                    <IMG id='thumb'  src='./storage/${vo.thumb}' >
                  </c:when>
                  <c:otherwise>
                    ${vo.file1}
                  </c:otherwise>
                </c:choose>
                </c:when>
            </c:choose>
            </td>          

            <td style='vertical-align: middle;'>${vo.rdate}</td>
            <td style='vertical-align: middle;'>${vo.good}</td>
            <td style='vertical-align: middle;'>
              <a href="./update.do?blogno=${vo.blogno}&categoryno=${vo.categoryno}&col=${searchDTO.col}&word=${searchDTO.word}&nowPage=${searchDTO.nowPage}"><img src="./images/update.png" title="수정" border='0'/></a>
              <a href="./delete.do?blogno=${vo.blogno}&categoryno=${vo.categoryno}&col=${searchDTO.col}&word=${searchDTO.word}&nowPage=${searchDTO.nowPage}"><img src="./images/delete.png" title="삭제"  border='0'/></a>
              ${vo.grpno}-${vo.indent}-${vo.ansnum}
              
            </td>
          </tr>
        </c:forEach>
        
      </tbody>
    </table>
  </div>

  <DIV class='bottom'>${paging}</DIV>

  <jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html>

