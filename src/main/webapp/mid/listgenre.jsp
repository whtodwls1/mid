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

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
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
  text-align: center;
}
</style>

</head>

<body>
	<jsp:include page="/menu/top.jsp" flush='false' />

	<div class="jumbotron text-center">
		<h1>${genre} 미드</h1>
		<p>
			<a href="./create.do"> 등록 버튼 </a>
		</p>
	</div>

	<div class="container">
		<div class="row">

			<c:forEach var='vo' items='${listgenre}'>
				<%-- <c:set var='next' value=0/> --%>
				<div class="col-sm-4" style="magin: 2px auto">
					<div class="img" style="width: 100%">
						<div Style="width: 100%">
							<video controls src='<%=root %>/blog/storage/${vo.file2}'
								poster='<%=root %>/blog/storage/${vo.thumb1}'
								style="width: 100%;"></video>
						</div>
						<div class="desc" style="text-align: center">
							<a href="./read.do?midnum=${vo.midnum}">${vo.midtitle}</a>
													</div>
					</div>
				</div>

			</c:forEach>

		</div>
	</div>

</body>

</html>
