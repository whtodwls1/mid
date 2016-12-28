<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% String root=request.getContextPath(); %>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link href="./css/style.css" rel="Stylesheet" type="text/css">
<style type="text/css">

</style>

</head> 

<body>
<jsp:include page="/menu/top.jsp" flush='false' />

<div class="jumbotron text-center">
  <h1>american drama list </h1>
  <p><a href="./yego/create.do"> 등록 버튼 </a></p> 
</div>
  
<div class="container">
  <div class="row">
  
  <c:forEach var='vo' items='${list}'>

      <div class="col-sm-4" style="magin:2px auto">
      <div class="img"style="width:100%">
   <div Style="width:100%"><video controls src='<%=root %>/blog/storage/${vo.file2}' poster='<%=root %>/blog/storage/${vo.thumb1}'style="width:100%;"></video></div>
  <div class="desc"style="text-align: center"><a href="./mid/review.do?midnum=${vo.midnum}">${vo.midtitle}</a>
 
  </div>
</div>
    </div>

    </c:forEach>
  
  </div>
</div>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html> 
