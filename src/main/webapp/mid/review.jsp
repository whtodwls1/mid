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

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
	function send_up() {
		var params = 'cnt=' + $('#up').html();
		$.post('./readlike.jsp', params, send_up_res, 'json');
	}
	function send_up_res(data) {
		$('#up').html(data.cnt);
	}
</script>
</head>

<body>
	<jsp:include page="/menu/top.jsp" flush='false' />

	<div class="jumbotron text-center">
		<h1 style="font-size: 30px;">Movie Review</h1>
	</div>

	<!-- 로그인시 -->
	<c:forEach var='list' items="${list}">

		<div class="container" style="border: solid 1px;'">
			<DIV class='content'
				style='width: 90%; margin: 20px auto; border: solid 1px;'>
				<div class="form-group" style="margin: auto">
					<div style="margin-bottom: 10px; border: solid 1px;">
						<span style="float: left; width: 150px; margin-left: 5px;">제목
							: ${list.midtitle}</span>
						<!-- 관리자 구현 -->
						<%
						  try {
						      if (session.getAttribute("id").toString().equals("admin")) {
						%>
						<span style="float: right;"><A
							href='./update.do?midnum=${list.midnum}'>수정</A><span
							class='hdiv'>ㅣ</span> <A href='./delete.do?midnum=${list.midnum}'>삭제</A></span>
						<%
						  }
						    } catch (Exception e) {
						    }
						%>
						<!-- 관리자 구현 -->
					</div>
<hr style="width: 85%; '">

					<div style="float: right;">
						<div>조회수 : ${list.viewcnt}</div>
						<a href="javascript:send_up();"><img
							src="<%=request.getContextPath()%>/menu/images/thumb.png"
							style="width: 49px; margin-left: 10px; margin-bottom: 30px;"></a>
						<span id="up">0</span>
					</div>
					
					<div>
						<div style="margin-top: 75px; margin-left: 25px;">${list.midcontent}</div>

					</div>

				</div>
			</DIV>
		</div>

	</c:forEach>
</body>

</html>

