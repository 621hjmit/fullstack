<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">


<!-- 로컬 CSS -->
<link rel='stylesheet' href='/static/css/style.css' />
<link rel='stylesheet' href='/static/css/login.css' />

<!-- 로컬 js -->
<script src='/static/js/script.js' defer></script>
<script src='/static/js/user/login.js' defer></script>

<main id="main">
  <div class="main-container">
    <div class="login-page-container ta-center">
      <div class="login-page-content welcome">
        <p class="welcome-message">계정을 생성해 주셔서 감사합니다.</p>
        <a href="/views/user/login" class="button-base button-primary height-normal btn-100">로그인</a>
      </div>
    </div>
  </div>
</main>
<script>

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>