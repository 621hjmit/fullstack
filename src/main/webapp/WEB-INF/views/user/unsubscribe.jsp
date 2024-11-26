<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<!-- 로컬 CSS -->
<link rel='stylesheet' href='/static/css/style.css' />
<link rel='stylesheet' href='/static/css/login.css' />
<link rel='stylesheet' href='/static/css/user/newsletter.css' />
<!-- 로컬 js -->
<script src='/static/js/user/unsubscribe.js' defer></script>
<main id="main">
  <div class="main-container">
    <div class="login-page-container">
      <h1 class="login-page-header">뉴스레터 구독 해지</h1>
      <div class="login-page-content">
        <div class="generic-input-box" id="emailArea">
          <p class="info ta-center" id="infoText1">등록하셨던 이메일을 적어주세요.</p>
          <p class="ta-right fs-5 margin-bottom-0 d-none" id="infoRequired1">*필수 항목</p>
          <input type="email" id="unEmail" name="uiEmail" class="generic-input required-input" required>
          <label class="generic-label" for="uiEmail" id="userEmailLabel" >이메일 <span aria-hidden="true"> *</span></label>
          <div class="warning-required"><span>필수항목</span></div>
          <input type="button" class="button-base button-primary height-normal size-medium" value="뉴스레터 구독 해지" id="checkEmailBtn">
        </div>
        <div class="ta-center  d-none" id="thankyouForSubscribe">
          <h3 class="mb-25">확인했습니다!</h3>
          <p>그동안 구독해 주셔서 감사합니다.</p>
          <input type="button" class="button-base button-secondary height-normal size-medium" value="쇼핑 계속하기" onclick="goBack()">
        </div>
      </div>
    </div>
  </div>
</main>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>