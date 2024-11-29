<%@page import="com.shop.fullstack.UserInfoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- 로컬 CSS -->
<link rel='stylesheet' href='/static/css/user/mypage-edit.css' />
<link rel='stylesheet' href='/static/css/terms.css' />

<!-- 헤더 끝 기분좋아서 주석 쿠헤헤 -->

<main id="main" class="margin-top-60 margin-bottom-60 mobile-margin-rl-15 user">
  <div class="main-container">
    <div class="flex flex-center">
      <div class=" w-20p">
        <%@ include file="/WEB-INF/views/common/mypage-nav.jsp" %>
      </div>
      <div class="bright-back-color w-80p">
        <div class="title flex space-between">
          <h1 class="boxed-title">1:1 문의내역</h1>
        </div>
        <div class="mb-40 p-20" id="">
	        <div class="row gap20">
	          <div class="col-md-5 generic-input-box">
	            <input type="text" id="ubLastName" name="ubLastName" class="generic-input required-input" required>
	            <label class="generic-label" for="ubLastName">성 <span aria-hidden="true"> *</span></label>
	            <div class="warning-required"><span>필수항목</span></div>
	          </div>
	          <div class="col-md-5 generic-input-box">
	            <input type="text" id="ubFirstName" name="ubFirstName" class="generic-input required-input" required>
	            <label class="generic-label" for="ubFirstName">이름 <span aria-hidden="true"> *</span></label>
	            <div class="warning-required"><span>필수항목</span></div>
	          </div>
	        </div>
	        <div class="generic-input-box">
	          <input type="text" id="ubEmail" name="ubEmail" class="generic-input required-input" required>
	          <label class="generic-label" for="ubEmail">이메일 <span aria-hidden="true"> *</span></label>
	          <div class="warning-required"><span>필수항목</span></div>
	        </div>
	        <div class="row m-row">
	          <div class="col generic-input-box width90">
	            <input type="text" id="ubCountryCode" name="ubCountryCode" class="generic-input required-input" required value="+82" maxlength="5">
	            <label class="generic-label" for="ubCountryCode">국가 코드 <span aria-hidden="true"> *</span></label>
	            <div class="warning-required"><span>필수항목</span></div>
	          </div>
	          <div class="col generic-input-box">
	            <input type="text" id="ubPhone" name="ubPhone" class="generic-input required-input" required>
	            <label class="generic-label" for="ubPhone">전화 <span aria-hidden="true"> *</span></label>
	            <div class="warning-required"><span>필수항목</span></div>
	          </div>
	        </div>
	        <div class="generic-input-box custom-select">
	          <select id="ucNum" name="ucNum" class="generic-select required-select">
	            <option value="0" disabled selected value class="hidden"></option>
	          </select>
	          <label for="ucNum" class="generic-label selected">주제를 선택해주세요. *</label>
	          <div class="warning-required"><span>필수항목</span></div>
	        </div>
	        
	        <div class="generic-input-box custom-select">
	          <input id="ubTitle" name="ubTitle" class="generic-input required-input" required/>
	          <label for="ubTitle" class="generic-label">제목 *</label>
	          <div class="warning-required"><span>필수항목</span></div>
	        </div>
	        <div class="generic-input-box textarea">
	          <textarea type="text" id="ubMessage" name="ubMessage" class="required-input generic-textarea" requiredrows="5" cols="200"></textarea>
	          <label class="generic-label" for="ubMessage">메시지 <span aria-hidden="true"> *</span></label>
	          <div class="warning-required"><span>필수항목</span></div>
	        </div>
	        
	        <div class="row gap20 flex-space-between">
	          <div class="col-md-5">
	            <p>메시지를 발송함으로써 <a href="/views/pages/legal_terms" class="text-decoration-underline">이용약관</a>에 동의하게 되고. 개인정보는 에르메스의 <a href="/views/pages/legal-privacy" class="text-decoration-underline">개인정보처리방침</a>에 따라 처리됩니다.</p>
	          </div>
	          <div class="col-md-5 text-right m-text-center">
	            <input type="button" class="button-base button-primary height-normal size-200" value="수정" onclick="save()">
	          </div>
	        </div>
        </div>
      </div>
    </div>
  </div><!-- .main-container -->
</main>
<!-- 로컬 js -->
<script>
const user = '<c:out value="${user}"/>';
</script>
<script src='/static/js/script.js' defer></script>
<script src='/static/js/user/board-contact-modify.js' defer></script>
<!-- 로컬 js end -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>