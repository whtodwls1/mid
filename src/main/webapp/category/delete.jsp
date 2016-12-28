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
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<script type="text/javascript">
$(function(){

});
</script>

</head> 

<body>
<jsp:include page="/menu/top.jsp" flush='false' />


<DIV class='title'>게시판 삭제</DIV>

<DIV class='message' style='width: 60%;'>
  <FORM name='frm' method='POST' action='./delete.do' class="form-horizontal">
    <input type='hidden' name='categoryno' id='categoryno' value='${categoryno}'>
  
    <div class="form-group">   
      <div class="col-xs-12">
        게시판을 삭제 하시겠습니까?<br>
        삭제하면 복구 할 수 없습니다.
        <br><br>
      </div>
    </div>
    <div class="form-group">   
      <div class="col-xs-12">
        <button type="submit">삭제</button>
        <button type="button" onclick="history.back()">취소[목록]</button>
      </div>  
    </div> 
</FORM>
</DIV>


<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html> 
