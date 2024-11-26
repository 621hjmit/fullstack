<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!-- bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

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
			  <p class="ta-right fs-5 margin-bottom-0">*필수 항목</p>
				<div class="generic-input-box">
					<input type="text" id="userEmail" name="userEmail" class="generic-input shorten-margin required-input disabled" required value="superant621@gmail.com" disabled>
					<label class="generic-label selected" for="userEmail" id="userEmailLabel" >이메일 <span aria-hidden="true"> *</span></label>
					<div class="warning-required"><span>필수항목</span></div>
				</div>
				<input type="checkbox" class="hidden" id="showPwdInput" onclick="showPwd()">
         <label for="showPwdInput" class="ta-right fs-5 margin-bottom-0 text-decoration-underline block" id="showPwdLabel">보기</label>
				<div class="generic-input-box">
					<input type="text" id="userPassword" name="userPassword" class="generic-input zero-margin required-input" required>
					<label class="generic-label" for="userPassword">비밀번호 <span aria-hidden="true"> *</span></label>
					<div class="warning-required"><span>필수항목</span></div>
				</div>
				<a href="/views/user/findPwd.html" class="d-block ta-right fs-5 margin-bottom-0 text-decoration-underline block" id="forgotPassword">비밀번호를 잊으셨나요?</a>
        <input type="button" class="button-base button-primary height-normal size-medium" value="계속" onclick="login()">
        <a href="/views/user/login.html" class="mt-3 d-block text-center fs-5 margin-bottom-0 block text-decoration-underline" id="forgotPassword">다른 이메일 주소를 사용하겠습니다.</a>
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
}//비밀번호 보기에 관한 
 
function login(){
  const uiEmail =   document.querySelector('#uiEmail').value;
  const uiPwd =   document.querySelector('#uiEmail').value;
  let param = {
      uiEmail : uiEmail
  }
  param = JSON.stringify(param);
  const xhr = new XMLHttpRequest();
  xhr.open('POST','/user/checkEmail');
  xhr.setRequestHeader("Content-Type", "application/json");
  xhr.onreadystatechange = function(){
    if(xhr.readyState === xhr.DONE){
      if(xhr.status === 200){
        console.log(xhr.responseText);
        if(xhr.responseText){
          location.href="/views/user/login2"
        }else{
          //no account then create account
          location.href="/views/user/create-account"
        }
      }
    }
  }
  xhr.send(param);
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>