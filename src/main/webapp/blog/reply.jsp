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


  <div class='content_menu'>
    <DIV style='float: left;'>
      <A href='../category/list.do'>게시판 목록</A> > 
      <A href='./list.do?categoryno=${categoryVO.categoryno }'>${categoryVO.title }</A>
    </DIV>

    <DIV style='float: right;'>  
      <A href='./list.do?categoryno=${categoryVO.categoryno }'>취소</A><span class='hdiv'>ㅣ</span>
      <A href='./list.do?categoryno=${categoryVO.categoryno }'>목록</A><span class='hdiv'>ㅣ</span>
    </DIV>
  </div>
  <div class='menu_line'></div>
  <DIV class='content'>
    <FORM name='frm' method='POST' action='./reply.do'
              enctype="multipart/form-data"class="form-horizontal">
      <input type='hidden' name='categoryno' id='categoryno' value='${blogVO.categoryno }'>
      <input type='hidden' name='blogno' id='blogno' value='${blogVO.blogno }'>
      
      <div class="form-group">   
        <label for="title" class="col-xs-2 control-label">글 제목</label>
        <div class="col-xs-10">
          <input type='text' class="form-control input-lg" name='title' id='title' value='봄' size='60' required="required">
        </div>  
      </div>
      <div class="form-group">   
        <label for="content" class="col-xs-2 control-label">내용</label>
        <div class="col-xs-10">
          <textarea class="form-control input-lg" name='content' id='content'  rows='10' cols='70'>미시령 단풍</textarea>
        </div>
      </div>   
      <div class="form-group">   
        <label for="file1MF" class="col-xs-2 control-label">업로드 파일</label>
        <div class="col-xs-10">
          <input type="file" class="form-control input-lg" name='file1MF' id='file1MF' size='40' >
          <br>
          Preview(미리보기) 이미지 자동 생성됩니다.
        </div>
      </div>
      <DIV style='text-align: right;'>
        <button type="submit">답변 등록</button>
        <button type="button" onclick="location.href='./list.do?categoryno=${categoryVO.categoryno}'">취소[목록]</button>
      </DIV>
    </FORM>
  </DIV>

  <jsp:include page="/menu/bottom.jsp" flush='false' />     
</body>

</html> 

