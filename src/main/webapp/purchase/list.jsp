<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% String root=request.getContextPath(); %>
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
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
 
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
.img{
width:100%;
}
div.img {
    margin: 5px;
    border: 1px solid #ccc;
    float: left;
    width: 180px;
}
div.img:hover {
    border: 1px solid #777;
}

div.img img {
    width: 100%;
    height: auto;
}

div.desc {
    padding: 15px;
    text-align: center;
}
</style>

</head> 

<body>
<jsp:include page="/menu/top.jsp" flush='false' />
     
<div class="jumbotron text-center">
  <h1 style="font-size: 30px;">구매 리스트</h1>
  <p><a href="./create.do">등록 버튼 </a></p> 
</div>
  
<div class="container">
<TABLE class='table table-hover'>
   <thead>
  <TR>
    <TH>구매 번호</TH>
    <TH>회원 번호</TH>
    <TH>아이디</TH>
    <TH>미드 번호</TH>
    <TH>장르</TH>
    <TH>썸네일</TH>
    <TH>제목</TH>
    <TH>금액</TH>
    <TH>시작일</TH>
    <TH>종료일</TH>
    <TH>(사용일수)</TH>
    
  </TR>
  </thead>

 <c:forEach var="vo" items="${list}"> 
  <TR>
  
    <TD><a href="./list.do?purnum=${vo.purnum}">${vo.purnum}</a></TD>
    <TD>${vo.mno}</TD>
    <TD>${vo.id}</TD>
    <TD>${vo.midnum}</TD>
    <TD>${vo.genre}</TD>
    <TD><img src='<%=root %>/blog/storage/${vo.thumb1}'style="width:100%;"></img></TD>
    <TD>${vo.midtitle}</TD>
    <TD>${vo.price}</TD>
    <TD>${vo.regdate}</TD>
    <TD>${vo.watch }</TD>
    
    
    </TR>
    
  </c:forEach>
    </TABLE>
     </div> 
<DIV class='bottom'>
  <button type='button' onclick="location.href='./create.do'">등록</button>
  <button type='button' onclick="location.reload();">새로 고침</button>
</DIV>
 


     <jsp:include page="/menu/bottom.jsp" flush='false' />     

</body>

</html> 