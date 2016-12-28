<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 
<script type="text/javascript">
$(function(){
 
});
</script>
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
 
 
<DIV class='title'>동영상 삭제</DIV>
 
<DIV class='message' style='width: 60%;'>
<FORM name='frm' method='POST' action='./delete.do'>
  <input type='hidden' name='purnum' id='purnum' value='${purnum}'>
  동영상을 삭제 하시겠습니까?<br>
  삭제하면 복구 할 수 없습니다.
  <br><br>
  <button type="submit">삭제</button>
  <button type="button" onclick="history.back()">취소[목록]</button>
</FORM>
</DIV>
 
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html> 