<%@ page contentType="text/html; charset=UTF-8"%>
<%
  String root = request.getContextPath();
%>


<!-- 버튼 -->
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script>
  
</script>
<style>
.background {
  background-image: url('<%=root%>/menu/images/main.jpg');
}

#login {
  color: #0cec1f;
}
</style>
<!-- <DIV class='container'> -->
<div class="background">


  <div id="jumbotron text-center">
    <div style="text-align: right; font-size: 25px; color: #0cec1f;">
      
      <%
        if (session.getAttribute("id") == null) { // 회원 로그인 여부 검사
      %>

       <span class='hdiv'>ㅣ </span>
      <span><a id="login" href='<%=root%>/member/login.do'>로그인</a></span>
      <span class='hdiv'>ㅣ</span>
      <%
        } else {
          if (session.getAttribute("id").equals("admin")) {
      %>
      <span class='hdiv'>ㅣ </span>
      <span><a id="login" href='<%=root%>/member/admin.do'>관리자</a></span>
      <%
        }
      %>
      <span class='hdiv'>ㅣ </span> <span><a id="login"
        href='<%=root%>/member/logout.do'>${id } 로그 아웃</a></span> <span
        class='hdiv'>ㅣ</span>
      <%
        }
      %>
    </div>
    <h1 style="text-align: center; padding-bottom: 100px;">
      <span style="margin-right: 25%;">
      <span><a style="margin-right: 10%;font-size: 30px;" href="<%=root%>/mid/review.do">Preview</a>
        <a style="font-size: 30px;" href="<%=root%>/mid/list.do">American drama</a></span>
         <a style="font-size: 50px; margin: 10%" href="<%=root%>/yego/list.do">Home</a>
          <span><a style="font-size: 30px;" href='<%=root%>/blog/list_total.do?categoryno=1'>Board</a></span>
          </span>
    </h1>

  </div>
</div>


<DIV class='container_body'>
  <!-- 화면을 2개로 분할하여 좌측은 메뉴, 우측은 내용으로 구성 -->

  <jsp:include page="/menu/left.jsp" flush='false' />