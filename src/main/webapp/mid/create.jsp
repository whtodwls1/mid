<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1"> 
<title></title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

<script type="text/JavaScript">
  window.onload=function(){
    CKEDITOR.replace('midcontent');  // <TEXTAREA>태그 id 값
  };
</script>
 <!-- 메인폼 -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


</head> 

<body>
<jsp:include page="/menu/top.jsp" flush='false' />
     
<div class="jumbotron text-center">
  <h1>movie create</h1>
  <p>Resize this responsive page to see the effect!</p> 
</div>
  
<div class="container">
  <DIV class='content' style='width: 100%;'>
    <FORM name='frm' method='POST' action='./create.do'
              enctype="multipart/form-data" class="form-horizontal">
      
      <div class="form-group">   
        <label for="title" class="col-xs-2 control-label">글 제목</label>
        <div class="col-xs-10 ">
          <input type='text' class="form-control input-lg" name='midtitle' id='midtitle' value='바다건너' size='60' required="required">
        </div>
      </div>   
       <div class="form-group">   
        <label for="midtitle" class="col-xs-2 control-label">장르</label>
        <div class="col-xs-10 ">
        <select  name="genre" id="genre">
          <option value="판타지">판타지</option>
          <option value="스릴러">스릴러</option>
          <option value="로맨스">로맨스</option>
          <option value="액션">액션</option>
          </select>
          
        </div>
      </div>   
      <div class="form-group">   
        <label for="file1MF" class="col-xs-2 control-label">동영상</label>
        <div class="col-xs-10">
          <input type="file" class="form-control input-lg" name='file1MF' id='file1MF' size='40' >
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
      </div>
        <div class="form-group">   
        <label for="file2MF" class="col-xs-2 control-label">메인 이미지</label>
        <div class="col-xs-10">
          <input type="file" class="form-control input-lg" name='file2MF' id='file2MF' size='40' >
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
      </div>      
      <div class="form-group">   
        <label for="content" class="col-xs-2 control-label">내용</label>
        <div class="col-xs-10">
          <textarea class="form-control input-lg" name='midcontent' id='midcontent'  rows='10' cols='70'  >글 입력</textarea>
        </div>
      </div>
         <div class="form-group">   
        <label for="title" class="col-xs-2 control-label">가격</label>
        <div class="col-xs-10 ">
          <input type='text' class="form-control input-lg" name='price' id='price' value='1000' size='60' required="required">
        </div>
      </div> 
        <div class="form-group">   
        <label for="title" class="col-xs-2 control-label">시청일</label>
        <div class="col-xs-10 ">
          <input type='text' class="form-control input-lg" name='watch' id='watch' value='1' size='60' required="required">
        </div>
      </div> 
      
      <DIV style='text-align: right;'>
        <button type="submit">등록</button>
        <button type="button" onclick="location.href='./list.do?midnum=${MidVO.midnum}'">취소[목록]</button>
      </DIV>
    </FORM>
  </DIV>
  
</div>


     <jsp:include page="/menu/bottom.jsp" flush='false' />     
</body>

</html> 