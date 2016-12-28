<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% String root=request.getContextPath(); %>

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


 <!-- 메인폼 -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


</head> 

<body>
<jsp:include page="/menu/top.jsp" flush='false' />
     
<div class="jumbotron text-center">
  <h1>yego update</h1> 
</div>
  
<div class="container">
  <DIV class='content' style='width: 100%;'>
    <FORM name='frm' method='POST'  action='./update.do'
              enctype="multipart/form-data" class="form-horizontal">
      <input type="hidden" id="yegono" name="yegono" value="${vo.yegono}" >
      <div class="form-group">   
        <label for="title" class="col-xs-2 control-label">예고 제목</label>
        <div class="col-xs-10 ">
          <input type='text' class="form-control input-lg" name='yegotitle' id='yegotitle' value='${vo.yegotitle}' size='60' required="required">
        </div>
      </div>    
     <div class="form-group">   
        <label for="file3MF" class="col-xs-2 control-label">동영상</label>
        <div class="col-xs-10">
          <input type="file" class="form-control input-lg" name='file3MF' id='file3MF' size='40' >
          <br>
          동영상 미 변경시 (이전 동영상 적용)  
        </div>
      </div>
        <div class="form-group">   
        <label for="file4MF" class="col-xs-2 control-label">예고 이미지</label>
        <div class="col-xs-10">
          <input type="file" class="form-control input-lg" name='file4MF' id='file4MF' size='40' >
          <br>
          이미지 미 변경시 (이전 이미지 적용)
        </div>
      </div>      
  
      <DIV style='text-align: right;'>
        <button type="submit">등록</button>
        <button type="button" onclick="location.href='./list.do?yegono=${vo.yegono}'">취소[목록]</button>
      </DIV>
    </FORM>
  </DIV>
  
</div>


     <jsp:include page="/menu/bottom.jsp" flush='false' />     
  
</body>

</html> 