<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
  String root = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- <script
  src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
.img {
  width: 100%;
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
}
</style>

</head>

<body>
  <jsp:include page="/menu/top.jsp" flush='false' />

  <div class="jumbotron text-center">
    <h1 style="font-size: 30px;">장바구니</h1>
    <!-- <p><a href="./create.do">등록 버튼 </a></p>  -->
  </div>

  <div class="container">
    <TABLE class="tablelist">
      <%--    <colgroup>
        <col style="width: 30%;"></col>
        <col style="width: 30%;"></col>
        <col style="width: 5%;"></col>
        <col style="width: 0%;"></col>
        <col style="width: 0%;"></col>
        <col style="width: 0%;"></col>
        <col style="width: 0%;"></col>
      </colgroup> --%>
      <thead>
        <TR>
          <th style="width: 100px;" text-align:center;="">번호</th>
          <th style="width: 100px;" text-align:center;="">제목</th>
          <th style="width: 300px;" text-align:center;="">포스터</th>
          <th style="width: 200px;" text-align:center;="">가격</th>
          <th style="width: 200px;" text-align:center;="">시작일</th>
          <!-- <th style="width: 200px;" text-align:center;="">종료일</th> -->
          <th style="width: 200px;" text-align:center;="">사용일수</th>
          <TH></TH>

        </TR>
      </thead>

     <%-- <c:forEach var="pur_vo" items="${pur_list}">
        <TR>
          <TD>${pur_vo.midnum}</TD>
          <TD>${pur_vo.midtitle}</TD>
          <TD><img src='<%=root %>/blog/storage/${pur_vo.thumb1}'
            style="width: 60%;"></img></TD>
          <TD>${pur_vo.price}</TD>
          <TD>${pur_vo.purreg}</TD>
          <TD>${pur_vo.purreg1}</TD>
          <TD>${pur_vo.watch }</TD>
          <td><input type="button" value="구매"
            onclick="window.open( 'http://localhost:9090/blog/purchase/purchase.do?midnum=${pur_vo.midnum}','결제하기','left=500, top=200, width=600, height=400, toolbar=no, location=yes, directories=no, status=no, menubar=no, scrollbars=yes, copyhistory=yes')"></td>

        </TR>

      </c:forEach> --%>
      
        <c:forEach var="pur_vo" items="${pur_list}">
        <TR>
          <TD>${pur_vo.midnum}</TD>
          <TD>${pur_vo.midtitle}</TD>
         <TD><img src='<%=root%>/blog/storage/${pur_vo.thumb1}'
            style="width: 60%;"></img></TD>
          <TD>${pur_vo.price}</TD>
          <TD>${pur_vo.regdate }</TD>
  <%--         <TD>${pur_vo.purreg1}</TD> --%>
          <TD>${pur_vo.watch }</TD>
          <td><input type="button" value="구매"
            onclick="window.open( 'http://localhost:9090/blog/purchase/purchase.do?midnum=${pur_vo.midnum}','결제하기','left=500, top=200, width=600, height=400, toolbar=no, location=yes, directories=no, status=no, menubar=no, scrollbars=yes, copyhistory=yes')"></td> 

        </TR>

      </c:forEach>
      
    </TABLE>
  </div>



  <jsp:include page="/menu/bottom.jsp" flush='false' />

</body>

</html>
