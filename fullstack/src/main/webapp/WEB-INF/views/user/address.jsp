<%@page import="com.shop.hermesplus.user.vo.UserInfoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- 로컬 CSS -->
<link rel='stylesheet' href='/static/css/terms.css' />
<link rel='stylesheet' href='/static/css/user/user.css' />
<main id="main" class="margin-top-60 margin-bottom-60 mobile-padding-rl-15 user">
	<div class="main-container">
	<div class="flex flex-center">
	  <div class=" w-20p">
	  <%@ include file="/WEB-INF/views/common/mypage-nav.jsp" %>
	  </div>
	  <div class="bright-back-color w-80p">
	    <div class="title flex space-between">
	      <h1 class="boxed-title">주소록</h1>
	    </div>
	    <div class="p-20px" id="">
	      <p class="pb-20px">여기서 주소를 추가, 삭제 또는 변경하시기 바랍니다.</p>
	      <div id="addressList">
	      </div>
	      <div class="flex f-center">
	        <button type="button" class="btn btn-200 button-primary m-auto" onclick="add()">주소 추가하기</button>
	        </div>
	      </div>
	    </div>
	  </div>
	</div><!-- .main-container -->
</main>
<script>var user = '<c:out value="${user}"/>'</script>
<!-- 로컬 js -->
<script src='/static/js/script.js' defer></script>
<script src='/static/js/user/address.js' defer></script>
<!-- 헤더 끝 기분좋아서 주석 쿠헤헤 -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>