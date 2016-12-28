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
		$('#file2').load(function() { // 태그 메모리 상주후 작동
			// var width = $('#file2').width();
			//alert('file2: ' + width); 
			if ($('#file2').width() > screen.width * 0.5) {
				$('#file2').width('50%');
			}
		});
	});
	function send_up() {
		var params ='midnum='+${vo.midnum} +'&cnt=' + $('#up').html();
		$.post('./uplike.do', params, send_up_res, 'json');
	}
	function send_up_res(data) {
		$('#up').html(data.cnt);
	}
</script>
</head>

<body>
	<jsp:include page="/menu/top.jsp" flush='false' />

	<div class="jumbotron text-center">
		<h1 style="font-size: 30px;">movie read</h1>
	</div>

	<div class='content_menu'>
		<DIV style='float: left;'>
			<A href='../mid/list.do'>목록</A> <A
				href='./list.do?midnum=${vo.midnum}'></A>
		</DIV>
		<!-- 관리자 구현 -->
		<%
		  try {
		    if (session.getAttribute("id").toString().equals("admin")) {
		%>
		<DIV style='float: right;'>
			<A href='./update.do?midnum=${vo.midnum}'>수정</A><span class='hdiv'>ㅣ</span>
			<A href='./delete.do?midnum=${vo.midnum}'>삭제</A>
		</DIV>
		<%
		  }
		  } catch (Exception e) {
		  }
		%>
		<!-- 관리자 구현 -->
	</div>

	<div class="container">
		<DIV class='content' style='width: 100%;'>
			<FORM name='frm' method='POST' action='./read.do'
				enctype="multipart/form-data" class="form-horizontal">

				<input type="hidden" id="midnum" name="midnum" value='${vo.midnum}'>
				<div class="form-group">
					<label for="file2" class="col-xs-2 control-label"></label> <br>
					<br> <span> <A
						href='${pageContext.request.contextPath}/download?dir=/blog/storage&filename=${vo.file2}'></A>
					</span>
					<div id='file2Panel'>
						<c:set var='file2' value="${fn:toLowerCase(vo.file2)}" />
						<video controls id='file2'
							src='<%=root %>/blog/storage/${vo.file2}'
							poster='<%=root %>/blog/storage/${vo.thumb1}' style="width:80%;"></video>
					</div>
					<br>
					<hr></hr>
					<div>
						<label for='title' style="width: 150px;">제목 : </label> <span>${vo.midtitle}</span>
						<div style="float: right;">
							<span>조회수 : ${vo.viewcnt}</span> <a href="javascript:send_up();"><img
								src="<%=request.getContextPath()%>/menu/images/thumb.png"
								style="width: 49px; margin-left: 10px; margin-bottom: 30px;"></a>
							<span id="up">${vo.midlike}</span>
						</div>
					</div>

				</div>
			</FORM>
		</DIV>
	</div>
</body>

</html>

