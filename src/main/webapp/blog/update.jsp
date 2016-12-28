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

<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

<script type="text/JavaScript">
  window.onload=function(){
   CKEDITOR.replace('content');
  };
</script>

</head> 

<body>
<jsp:include page="/menu/top.jsp" flush='false' />
     
  <div class='content_menu' style='width: 100%;'>
    <DIV style='float: left;'>
      <A href='../category/list.do'>게시판 목록</A> > 
      <A href='./list.do?categoryno=${categoryVO.categoryno }'>${categoryVO.title }</A>
     </DIV>
    
    <DIV style='float: right;'>  
      <A href="javascript:history.back();">취소</A><span class='hdiv'>ㅣ</span>
      <A href='./list.do?categoryno=${categoryVO.categoryno }'>목록</A>
    </DIV>  
  </div>
  <div class='menu_line'></div>
  <DIV class='content' style='width: 90%;'>
    <FORM name='frm' method='POST' action='./update.do'
                enctype="multipart/form-data" class="form-horizontal">
      <input type='hidden' name='blogno' id='blogno' value='${blogVO.blogno}'>
      <input type="hidden" name="categoryno" value="${blogVO.categoryno}">

      <div class="form-group">
        <label for="title" class="col-xs-2 control-label">글 제목</label>
        <div class="col-xs-10">
          <input type='text' class="form-control input-lg" name='title' size='70' id='title' value='${blogVO.title}' required="required">
        </div>
      </div>   
      <div class="form-group">   
        <label for="content" class="col-xs-2 control-label">내용</label>
        <div class="col-xs-10">
          <textarea class="form-control input-lg" name='content' id='content'  rows='10' style='width: 100%;'>${blogVO.content}</textarea>
        </div>
      </div>   
      <div id='file2Panel' class="form-group">
        <div class="col-xs-12">
          <c:set var='file1' value="${fn:toLowerCase(blogVO.file1)}" />
          <c:choose>
            <c:when test="${fn:endsWith(file1, '.jpg')}">
              <IMG src='./storage/${blogVO.file1}'>
            </c:when>
            <c:when test="${fn:endsWith(file1, '.gif')}">
              <IMG id='file1'  src='./storage/${blogVO.file1}'>
            </c:when>
            <c:when test="${fn:endsWith(file1, '.png')}">
              <IMG id='file1'  src='./storage/${blogVO.file1}'>
            </c:when>
            <c:when test="${blogVO.file1.length() > 0}">
              ${blogVO.file1 }  <!-- 이미지가 아니면서 파일이 존재하는 경우 파일명 출력 -->
            </c:when>
          </c:choose>
        </div>
      </div>
      <div class="form-group">   
        <label for="file2MF" class="col-xs-2 control-label">업로드 파일</label>
        <div class="col-xs-10">
          <input type="file" class="form-control input-lg" name='file1MF' id='file1MF' size='40' >
          <br>
          Preview(미리보기) 이미지 자동 생성됩니다.
        </div>
      </div>  
      <DIV style='text-align: right;'>
        <button type="submit">수정</button>
        <button type="button" onclick="location.href='./list.do?categoryno=${blogVO.categoryno}'">목록[취소]</button>
      </DIV>         
    </FORM>
  </DIV>

  <jsp:include page="/menu/bottom.jsp" flush='false' />     

</body>

</html> 
