<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
function send(){
  // 패스워드 동일한지 검사
  if ($('#passwd').val() == $('#passwd2').val()){ 
    return true; // 변경 계속 진행
  }else{
    $('#panel_passwd').css('color', '#FF0000');
    $('#panel_passwd').html('패스워드가 일치하지 않습니다.');
    $('#passwd').focus();
    return false;      
  }
}
</script>

</head> 
<!-- ----------------------------------------- -->
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<!-- ----------------------------------------- -->

<DIV class='title'>페스워드 변경</DIV>

<DIV class='content' style='width: 60%;'>
  <FORM name='frm' method='POST' action='./passwd.do'
           onsubmit = 'return send();' class="form-horizontal">
    <input type='hidden' name='mno' value='${mno}'>         

    <div class="form-group">   
      <label for="title" class="col-xs-4 control-label">현재 패스워드</label>
      <div class="col-xs-8">
        <input type='password' name='old_passwd' id='old_passwd' value='1234' required="required">
      </div>
    </div> 
    
    <div class="form-group">   
      <label for="title" class="col-xs-4 control-label">새로운 패스워드</label>
      <div class="col-xs-8">
        <input type='password' name='passwd' id='passwd' value='1234' required="required">
        <br>
        <span id='panel_passwd'></span>
      </div>
    </div> 

    <div class="form-group">   
      <label for="title" class="col-xs-4 control-label">새로운 패스워드 확인</label>
      <div class="col-xs-8">
         <input type='password' name='passwd2' id='passwd2' value='1234' required="required">
        <br>
        <span id='panel_passwd'></span>
      </div>
    </div> 

    <div class="form-group" style='text-align: center;'>   
      <div class="col-xs-12">
        <button type="submit">저장</button>
        <button type="button" onclick="location.href='./list.do'">목록</button>  
      </div>
    </div> 
  </FORM>
</DIV>

<!-- -------------------------------------------- -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
<!-- -------------------------------------------- -->
</html> 

