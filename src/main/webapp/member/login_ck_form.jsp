<%@ page contentType="text/html; charset=UTF-8" %>

<%
String url_address = request.getParameter("url_address"); // 로그인 후 이동할 주소

Cookie[] cookies = request.getCookies();
Cookie cookie = null;
String ck_id = "";
String ck_id_save = "";
String ck_passwd = "";
String ck_passwd_save = "";

for (int i=0; i < cookies.length; i++){
  cookie = cookies[i];
  
  if (cookie.getName().equals("ck_id")){
    ck_id = cookie.getValue();         // test1
  }else if(cookie.getName().equals("ck_id_save")){
    ck_id_save = cookie.getValue();  // Y, N
  }else if (cookie.getName().equals("ck_passwd")){
    ck_passwd = cookie.getValue();         // test1@mail.com
  }else if(cookie.getName().equals("ck_passwd_save")){
    ck_passwd_save = cookie.getValue();  // Y, N
  }
}
%>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>로그인</title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

</head> 
<!-- ----------------------------------------- -->
<body leftmargin="0" topmargin="0">
<jsp:include page="/menu/top.jsp" flush='false' />
<!-- ----------------------------------------- -->

<DIV class='title' style='width: 20%;'>회원 로그인</DIV>

<DIV class='content' style='width: 40%;'>
  <FORM name='frm' method='POST' action='./login.do' class="form-horizontal">
    <input type='hidden' name='url_address' value='<%=url_address %>'>

    <div class="form-group">   
      <label for="title" class="col-xs-4 control-label">아이디</label>
      <div class="col-xs-8">
        <input type='text' name='id' id='id' value='<%-- <%=ck_id %> --%>admin' style='width: 50%;' autocomplete="off" required="required">
        <label>
          <%
          if (ck_id_save.equals("Y")){
          %>
            <input type='checkbox' name='id_save' value='Y' checked="checked"> 저장
          <%
          }else{
          %>
            <input type='checkbox' name='id_save' value='Y'> 저장
          <%  
          }
          %>
        
        </label>
      </div>
    </div> 
    
    <div class="form-group">   
      <label for="passwd" class="col-xs-4 control-label">패스워드</label>
      <div class="col-xs-8">
        <input type='password' name='passwd' id='passwd' value='<%-- <%=ck_passwd %> --%>1234' style='width: 50%;' autocomplete="off" required="required">
        <label>
          <%
          if (ck_passwd_save.equals("Y")){
          %>
            <input type='checkbox' name='passwd_save' value='Y' checked="checked"> 저장
          <%
          }else{
          %>
            <input type='checkbox' name='passwd_save' value='Y'> 저장
          <%  
          }
          %>
        
        </label>
      </div>
    </div> 
    
    <div class="form-group" style='text-align: center;'>   
      <div class="col-xs-12">
        <button type='submit'>로그인</button>
        <button type='button' onclick="location.href='./create.do'">회원가입</button> 
      </div>
    </div> 

  </FORM>
</DIV>

<!-- -------------------------------------------- -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
<!-- -------------------------------------------- -->
</html> 

