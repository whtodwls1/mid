<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

<script type="text/JavaScript">
  
</script>
<!-- 메인폼 -->
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


</head>

<body>
  <jsp:include page="/menu/top.jsp" flush='false' />

  <div class="jumbotron text-center">
    <h1>yego create</h1>

  </div>

  <div class="container">
    <DIV class='content' style='width: 100%;'>
      <FORM name='frm' method='POST' action='./create.do'
        enctype="multipart/form-data" class="form-horizontal">
        <div class="form-group">
          <label for="title" class="col-xs-2 control-label">제목</label>
          <div class="col-xs-10 ">
            <input type='text' class="form-control input-lg"
              name='yegotitle' id='yegotitle' value='제목을 입력하세요' size='60'
              required="required">
          </div>
        </div>


        <div class="form-group">
          <label for="file3MF" class="col-xs-2 control-label">예고
            동영상</label>
          <div class="col-xs-10">
            <input type="file" class="form-control input-lg"
              name='file3MF' id='file3MF' size='40'> <br>
            Preview(미리보기) 이미지는 자동 생성됩니다.
          </div>
        </div>
        <div class="form-group">
          <label for="file4MF" class="col-xs-2 control-label">예고
            이미지</label>
          <div class="col-xs-10">
            <input type="file" class="form-control input-lg"
              name='file4MF' id='file4MF' size='40'> <br>
            Preview(미리보기) 이미지는 자동 생성됩니다.
          </div>
        </div>

        <DIV style='text-align: right;'>
          <button type="submit">등록</button>
          <button type="button"
            onclick="location.href='./list.do?yegono=${YegoVO.yegono}'">취소[목록]</button>
        </DIV>
      </FORM>
    </div>
  </div>


  <jsp:include page="/menu/bottom.jsp" flush='false' />

</body>

</html>
