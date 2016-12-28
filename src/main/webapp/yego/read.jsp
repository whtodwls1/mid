<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% String root=request.getContextPath(); %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- <script  src="http://code.jquery.com/jquery-latest.min.js"></script> -->
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function() {
    $('#file3').load(function() { // 태그 메모리 상주후 작동
      // var width = $('#file2').width();
      //alert('file2: ' + width); 
      if ($('#file3').width() > screen.width * 0.5) {
        $('#file3').width('50%');
      }
    });
  });
</script>
</head>

<body>
  <jsp:include page="/menu/top.jsp" flush='false' />
  
  <div class="jumbotron text-center">
  <h1 style="font-size: 30px;">yego read</h1>
</div>

  <div class='content_menu'>
    <DIV style='float: left;'>
      <A href='../yego/list.do'>목록</A>
      <A href='./list.do?yegono=${vo.yegono}'></A>
    </DIV>
    <%try{
    if(session.getAttribute("id").toString().equals("admin")){ %>
    <DIV style='float: right;'>
      <A href='./update.do?yegono=${vo.yegono}'>수정</A><span class='hdiv'>ㅣ</span>
      <A href='./delete.do?yegono=${vo.yegono}'>삭제</A>
    </DIV>
    <%} }catch(Exception e){}%>
  </div>
  
  <div class="container">
    <DIV class='content' style='width: 100%;'>
      <FORM name='frm' method='POST' action='./read.do'
        enctype="multipart/form-data" class="form-horizontal">
        
        <input type="hidden" id="yegono" name="yegono" value='${vo.yegono}'>
        <div class="form-group">
          <label for="file3" class="col-xs-2 control-label"></label> <br><br>
          <span> 
              <A href='${pageContext.request.contextPath}/download?dir=/blog/storage&filename=${vo.file3}'></A>
          </span>
          <div id='file3Panel'>
            <c:set var='file3' value="${fn:toLowerCase(vo.file3)}" />
                <video controls id='file3' src='<%=root %>/blog/storage/${vo.file3}' poster='<%=root %>/blog/storage/${vo.yegothumb}' style="width:80%;"></video>
          </div><br>
          <hr></hr>
          <div>
          <label for='title' style="width: 150px;">제목 : </label> <span>${vo.yegotitle} 
          <% if(session.getAttribute("id")!=null){ %>
            <a href="<%=root %>/purchase/pur_list.do?midtitle=${vo.yegotitle}">구매하기</a>
            <%}  %>
            
            </span>
               
                                                               
          </div>
        
        </div>

      </FORM>
    </DIV>
  </div>
</body>

</html>

