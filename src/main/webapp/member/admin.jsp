<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%String root=request.getContextPath(); %>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="../js/jquery.cookie.js"></script>
<script type="text/javascript" src="../js/tool.js"></script>

<style type="text/css">
#rcorners {
    border-radius: 15px 50px 30px;
    background: #516669;
    
    padding: 20px; 
    width: 300px;
    height: 300px;
    top:100px;
    left:100px; 
}
#rcorners2 {
    border-radius: 15px 50px 30px;
    background: #516669;
    
    padding: 20px; 
    width: 300px;
    height: 300px;
    top:0px;
    left:100px; 
}
</style>
</head> 
<!-- ----------------------------------------- -->
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<!-- ----------------------------------------- -->

<DIV class='title'>회원 목록</DIV>
<div style="width: 41%; margin: auto;">
<div style="margin: 50px;color:#a29286;">
<a href="<%=root %>/member/list.do"><span id="rcorners"style="margin-right: 5px;">회원 관리</span></a>

<a href="<%=root %>/category/list.do"><span id="rcorners">카테고리관리</span></a>
</div>
<div style="margin: 50px;color:#a29286;">
<a href="<%=root %>/mid/list.do"><span id="rcorners2">동영상 관리</span></a>

<a href="<%=root %>/purchase/pur_list.do"><span id="rcorners2">구매내역 관리</span></a>
</div>
</div>
<!-- -------------------------------------------- -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
<!-- -------------------------------------------- -->
</html> 

