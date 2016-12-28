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

 <!-- 메인폼 -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


</head> 

<body>
<jsp:include page="/menu/top.jsp" flush='false' />
     
<div class="jumbotron text-center">
  <h1>글 삭제 하시겠습니까?</h1>
  <p style="text-align:center;">진짜로 삭제?</p> 
</div>
  
<div class="container">
  <DIV class='content' style='width: 100%;'>
    <FORM name='frm' method='POST' action='./delete.do'
              enctype="multipart/form-data" class="form-horizontal">
      <input type="hidden" id="yegono" name="yegono" value="${yegono}">
      <div class="form-group">   
         <DIV style='text-align: center;'>
        <button type="submit" style="width:30%">삭제</button>
        <button type="button" style="width:30%" onclick="location.href='./list.do?yegono=${yegono}'">취소[목록]</button>
      </DIV>
      </div>   
     
     
    </FORM>
  </DIV>
  
</div>
     <jsp:include page="/menu/bottom.jsp" flush='false' />     

</body>
</html> 