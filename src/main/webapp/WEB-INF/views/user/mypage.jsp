<%@page import="com.shop.fullstack.UserInfoVO"%>
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
        <div class="bright-back-color   w-80p m-mt-15">
          <div class="title flex space-between">
            <h1 class="boxed-title">프로필 정보</h1>
            <div class="relative">
              <a href="/views/user/mypage-edit" class="absolute btn-circle back-color btn-icon btn-50px"><i class="icon-pen"></i><span>내 정보 수정</span></a>
            </div>
          </div>
          <div class="flex">
	          <div class="m-large w-50p left-border">
	            <dt>이름</dt>
	            <dd id="uName"><span id="uiLastName"></span><span id="uiFirstName"></span></dd>
	            <dt>이메일</dt>
	            <dd id="uiEmail"></dd>
	            <dt>비밀번호</dt>
	            <dd>********</dd>
	            <dt>전화</dt>
	            <dd id="uPhone"><span id="uiCountryCode"></span>&nbsp;<span id="uiPhone"></span></dd>
	            <dt>성별</dt>
	            <dd id="uiGender"></dd>
	            <dt>생년월일</dt>
	            <dd id="uiBirth"></dd>
	            <dt>뉴스레터 구독 여부</dt>
              <dd id="uiNews"></dd>
	          </div>
	          <div class="m-large w-50p">
	            <dt>청구지 주소</dt>
	            <dd>
		            <p id="aName"></p>
		            <p><span id="aiAddress1"></span><span id="aiAddress2"></span></p>
		            <p id="aPhone"></p>
	            </dd>
	            *고객정보에 등록된 주문자의 주소와 연락처 입니다.
	          </div>
          </div>
        </div>
      </div>
    </div><!-- .main-container -->
</main>
<script>
let user = '<c:out value="${user}"/>'
</script>
<!-- 로컬 js -->
<script src='/static/js/script.js' defer></script>
<script src='/static/js/user/mypage.js' defer></script>
<!-- 헤더 끝 기분좋아서 주석 쿠헤헤 -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>