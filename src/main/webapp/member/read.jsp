<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">

</script>

</head> 
<!-- ----------------------------------------- -->
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<!-- ----------------------------------------- -->

<DIV class='title'>회원 정보 수정</DIV>

<DIV class='content'>
<FORM name='frm' method='POST' action='./update.do' class="form-horizontal">
  <input type='hidden' name='mno' value='${memberVO.mno}'>         

    <div class="form-group">   
      <label for="title" class="col-xs-3 control-label">아이디</label>
      <div class="col-xs-9">
        ${memberVO.id} 
        <SPAN id='panel_id'>(ID는 변경할 수 없습니다.)</SPAN>
      </div>
    </div> 
    
    <div class="form-group">   
      <label for="title" class="col-xs-3 control-label">성명</label>
      <div class="col-xs-9">
        <input type='text' name='mname' id='mname' value='${memberVO.mname}' required="required">
      </div>
    </div> 
    
    <div class="form-group">   
      <label for="title" class="col-xs-3 control-label">전화번호</label>
      <div class="col-xs-9">
        <input type="tel" name='tel' id='tel' value='${memberVO.tel}'> 예) 010-0000-0000      </div>
    </div> 
    
    <div class="form-group">   
      <label for="title" class="col-xs-3 control-label">우편번호</label>
      <div class="col-xs-9">
       <input type='text' name='zipcode' id='zipcode' value='${memberVO.zipcode}' placeholder="우편번호">
        <input type="button" onclick="DaumPostcode()" value="우편번호 찾기"><br>        
      </div>
    </div> 
    
    <div class="form-group">   
      <label for="title" class="col-xs-3 control-label">주소</label>
      <div class="col-xs-9">
        <input type='text' name='address1' id='address1' value='${memberVO.address1}' size='50' placeholder="주소">
        <br>  
        <input type='text' name='address2' id='address2' value='${memberVO.address2}' size='40' placeholder="상세 주소">      
      </div>
    </div> 
    
    <div class="form-group">   
      <label for="title" class="col-xs-1 control-label"></label>
      <div class="col-xs-11">
<!-- ----- DAUM 우편번호 API 시작 ----- -->

<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 110px;position:relative">
  <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('address1').value = fullAddr;

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
                
                $('#address2').focus();
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>
<!-- ----- DAUM 우편번호 API 종료----- -->
      </div>
    </div> 
            
    <div class="form-group" style='text-align: center;'>   
      <div class="col-xs-12">
        <button type="submit">저장</button>
        <button type="button" onclick="location.href='./list.do'">목록</button>  
      </div>
    </div> 

</FORM>
</DIV>

<!-- -------------------------------------------- -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
<!-- -------------------------------------------- -->
</html> 

