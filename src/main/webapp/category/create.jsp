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

<script type="text/javascript">
$(function(){

});
</script>

</head> 

<body>
<jsp:include page="/menu/top.jsp" flush='false' />


<DIV class='title'>게시판 등록</DIV>

<DIV class='content'>
  <FORM name='frm' method='POST' action='./create.do' class="form-horizontal">
    <div class="form-group">   
      <label for="title" class="col-xs-3 control-label">카테고리 제목</label>
      <div class="col-xs-9">
        <input type='text' class="form-control" name='title' id='title' value='경기도' required="required">
      </div>
    </div>  
    <div class="form-group">   
      <label for="seqno" class="col-xs-3 control-label">출력 순서</label>
      <div class="col-xs-9">
        <input type="number" name='seqno' id='seqno' value='1' step="1" min="1">
      </div>
    </div>  
    <div class="form-group">   
      <label for="visible" class="col-xs-3 control-label">출력 모드</label>
      <div class="col-xs-9">
        <input type='text' name='visible' id='visible' value='Y' placeholder="Y or N">
      </div>
    </div>  
    <div class="form-group">   
      <label for="ids" class="col-xs-3 control-label">접근 계정</label>
      <div class="col-xs-9">
        <input type='text' name='ids' id='ids' value='admin' size='40' placeholder="admin/user1/guest...">  
      </div>
    </div>  
    <div class="form-group">   
      <div class="col-xs-offset-3 col-xs-9">
        <button type="submit">등록</button>
        <button type="button" onclick="location.href='./list.do'">목록</button>
      </div>
    </div>  
  </FORM>
</DIV>


<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html> 

