<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String root=request.getContextPath(); %>
<!-- 선언부 -->

<link href="./css/main.css" rel="Stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script> 
$(document).ready(function(){
    $("#flip").click(function(){
        $("#panel").slideToggle("slow");
        $("#panel2").slideToggle("slow");
        $("#panel3").slideToggle("slow");
        $("#panel4").slideToggle("slow");
    });
});

</script>

<style> 
#panel,#panel2,#panel3,#panel4, #flip {
    padding: 5px;
    text-align: center;
    background-color: #eeeeee;
    border: solid 1px #c3c3c3;
}

#panel,#panel2,#panel3,#panel4 {
    padding: 5px;
    display: none;
}


</style>
<!-- 선언끝 -->

    <div class="row">
      <div class="col-md-2">
        <div class="img" style="width:100%;">
   <video controls src='<%=root %>/menu/images/mp.mp4' poster='<%=root %>/menu/images/main.jpg'  autoplay preload="none"  muted  style="width:100%;"></video>
  <div class="desc">
  <div id="flip">장르 선택</div>
         <div id="panel"> <a href="/blog/mid/listgenre.do?genre=액션">액션</a></div>
          <div id="panel2"><a href="/blog/mid/listgenre.do?genre=판타지">판타지</a></div>
          <div id="panel3"><a href="/blog/mid/listgenre.do?genre=로맨스">로맨스</a></div>
          <div id="panel4"><a href="/blog/mid/listgenre.do?genre=스릴러">스릴러</a></div>
          </div>
</div>

         
      </div> <!-- <div class="col-md-2"> END -->
      
      <div class="col-md-10 cont">
      