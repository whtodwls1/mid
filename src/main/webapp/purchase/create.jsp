<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1"> 
<title></title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->
<script type="text/javascri
t" src="../ckeditor/ckeditor.js"></script>

<script type="text/JavaScript">

</script>
 <!-- 메인폼 -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


</head> 

<body>
<jsp:include page="/menu/top.jsp" flush='false' />
     
<div class="jumbotron text-center">
  <h1>purchase create</h1>
  <p>Resize this responsive page to see the effect!</p> 
</div>
  
<div class="container">
  <DIV class='content' style='width: 100%;'>
    <FORM name='frm' method='POST' action='./create.do' class="form-horizontal">
      <div class="form-group">   
        <label for="midnum" class="col-xs-2 control-label">영화 번호</label>
        <div class="col-xs-10 ">
          <input type='number' class="form-control input-lg" name='midnum' id='midnum' >
        </div>
      </div>   
      <div class="form-group">   
        <label for="mno" class="col-xs-2 control-label">회원 번호</label>
        <div class="col-xs-10">
          <input type="number" class="form-control input-lg" name='mno' id='mno' >
          <br>
        </div>
      </div>   
      <DIV style='text-align: right;'>
        <button type="submit">등록</button>
        <button type="button" onclick="location.href='./list.do?purnum=${purchaseVO.purnum}'">취소[목록]</button>
      </DIV>
    </FORM>
  </DIV>
  
</div>


     <jsp:include page="/menu/bottom.jsp" flush='false' />     
  </div>
</body>

</html> 