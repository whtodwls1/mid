<%@ page contentType="text/html; charset=UTF-8" %>

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
    CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  };
</script>

</head> 

<body>
<jsp:include page="/menu/top.jsp" flush='false' />
     

  <div class='content_menu'>
    <DIV style='float: left;'>
      <A href='../category/list.do'>게시판 목록</A> > 
      <A href='./list2.do?categoryno=${categoryVO.categoryno }'>${categoryVO.title }</A>
    </DIV>
    
    <DIV style='float: right;'>
      <A href='./create.do?categoryno=${categoryVO.categoryno }'>등록</A><span class='hdiv'>ㅣ</span>
      <A href="javascript:location.reload();">새로고침</A>
    </DIV>  
  </div>
  <div class='menu_line'></div>
  <DIV class='content' style='width: 100%;'>
    <FORM name='frm' method='POST' action='./create.do'
              enctype="multipart/form-data" class="form-horizontal">
      <input type='hidden' name='categoryno' id='categoryno' value='${categoryVO.categoryno }'>
      <div class="form-group">   
        <label for="title" class="col-xs-2 control-label">글 제목</label>
        <div class="col-xs-10 ">
          <input type='text' class="form-control input-lg" name='title' id='title' value='바다건너' size='60' required="required">
        </div>
      </div>   
      <div class="form-group">   
        <label for="content" class="col-xs-2 control-label">내용</label>
        <div class="col-xs-10">
          <textarea class="form-control input-lg" name='content' id='content'  rows='10' cols='70'>크리스마스에 갔던곳</textarea>
        </div>
      </div>   
      <div class="form-group">   
        <label for="file2MF" class="col-xs-2 control-label">업로드 파일</label>
        <div class="col-xs-10">
          <input type="file" class="form-control input-lg" name='file1MF' id='file1MF' size='40' >
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
      </div>   

      <DIV style='text-align: right;'>
        <button type="submit">등록</button>
        <button type="button" onclick="location.href='./list.do?categoryno=${categoryVO.categoryno}'">취소[목록]</button>
      </DIV>
    </FORM>
  </DIV>


     <jsp:include page="/menu/bottom.jsp" flush='false' />     
  </div>
</body>

</html> 
