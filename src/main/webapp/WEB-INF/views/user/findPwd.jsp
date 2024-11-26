<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

   <!-- 로컬 CSS -->
   <link rel='stylesheet' href='/static/css/style.css' />
   <link rel='stylesheet' href='/static/css/login.css' />

   <!-- 로컬 js -->
   <script src='/static/js/script.js' defer></script>
   <script src='/static/js/login.js' defer></script>
   <main id="main">
      <div class="main-container">
         <div class="login-page-container">
            <h1 class="login-page-header">계정</h1>
            <div class="login-page-content">
               
               <form action="post">
                  <p class="fw-bold">비밀번호를 잊으셨나요?</p>
                  <hr>
               	  <p class="info margin-bottom-10">회원 가입 할 때 사용하신 이메일 주소를 입력해 주세요.</p>
                  <p class="ta-right fs-5 margin-bottom-0">*필수 항목</p>
                  <div class="generic-input-box">
                     <input type="text" id="userEmail" name="userEmail" class="generic-input required-input" required>
                     <label class="generic-label" for="userEmail">이메일 <span aria-hidden="true"> *</span></label>
                     <div class="warning-required"><span>필수항목</span></div>
                  </div>
                  <input type="submit" class="button-base button-primary height-normal size-medium" value="계속">
               </form>

            </div>
         </div>
      </div>
   </main>
	<script>
      var pwdFlag = false;
      function showPwd(){
         if(pwdFlag){
            $('#userPassword').attr('type','password');
            pwdFlag = false;
         }else{
            $('#userPassword').attr('type','text');
            pwdFlag = true;
         }
      }
   </script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>