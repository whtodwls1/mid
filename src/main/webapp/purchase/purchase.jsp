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
<script langauge="Javascript">
  function test1() {
    var retVal = confirm("결제하시겠습니까");
    if (retVal == true) {
      alert("결제가 완료되었습니다.");
    } else {
      alert("취소되었습니다!");
    }
  }
</script>


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
  <%-- <jsp:include page="/menu/top.jsp" flush='false' /> --%>

  <div class="jumbotron text-center">
    <h1 style="font-size: 30px;">영상 결제</h1>
    <p>
      선택하신 상품 </a>
    </p>
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
          <th style="width: 300px; text-align: center;">포스터</th>
          <th style="width: 200px; text-align: center;">제목</th>
          <th style="width: 200px; text-align: center;">가격</th>
          <th style="width: 300px; text-align: center;">사용일수</th>
          <TH></TH>
          <td><img src="/blog/blog/storage/(0)maxresdefault_t.jpg"
            style="width: 60%;"></td>
        </TR>
      </thead>

      <c:forEach var="purchase" items="${purchase}">
        <TR>

          <TD style="text-align: center;"><img
            src='<%=root %>/blog/storage/${purchase.thumb1}'
            style="width: 60%;"></img></TD>
          <TD style="text-align: center;">${purchase.midtitle}</TD>
          <TD style="text-align: center;">${purchase.price}</TD>
          <TD style="text-align: center;">${purchase.watch }</TD>
        </TR>

      </c:forEach>
    </TABLE>
  </div>



  <%--   <jsp:include page="/menu/bottom.jsp" flush='false' />  --%>
  <div style="text-align: center;">
    <button type="button" onclick="test1()">결제하기</button>

    <button type="button" onclick="window.close()">취소</button>
  </div>
</body>

</html>
