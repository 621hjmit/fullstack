document.addEventListener('DOMContentLoaded', function () {
  init();
});

function init(){
  setLogin();
}

function setLogin(){
  fetch('/api/user')
  .then(response => response.json())
  .then(data => {
      if (data) {
          location.href="/views/user/mypage";
          //console.table(data);
      } else {
          console.log('No user session found.');
      }
  })
  .catch(error => console.log('아직 로그인되지 않았습니다. :', error));
}

let $userEmail=$('#uiEmail');
let regEmail=/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
$userEmail.on('blur', function(){
  checkEmailValidation();
});
function checkEmailValidation(){
  if(!regEmail.test($userEmail.val())){
    $userEmail.popWarning("name@domain.com과 같은 형식의 유효한 이메일을 입력해 주세요.");
  }else{
    checkEmail();
  }
}

$.fn.popWarning = function(str){
    var $this = $(this);
    $this.addClass('generic-input-error');
    $this.siblings('.warning-required').addClass('show');
    $this.siblings('.warning-required').children('span').html(str);
}

$.fn.warningRequired = function(){
    var $this = $(this);
    value = $this.val();
    if(!value){
        $this.addClass('generic-input-error');
        $this.siblings('.warning-required').addClass('show');
    }else{
        $this.removeClass('generic-input-error');
        $this.siblings('.warning-required').removeClass('show');
    }

}
//.warning-required
$('.required-input').on( "focusout", function(){
    $(this).warningRequired();
});

function sendCode(){
  
}

//윈도우 리사이즈시 실행 영역 ---------------------

$( window ).on( "resize", function() {
    checkDevice();
    mobileClass();
});

//-------------------------------------------------
function mobileClass(){
    if(!pcFlag){ //모바일이면
        $('main').addClass('mobile');
    }else{
        $('main').removeClass('mobile');
    }
}
function checkDevice(){
    if($(window).width()>751){
        pcFlag= true;
    }else{
        pcFlag=false;
    }
}

function redirectToProductPage () {
		const previousUrl = document.referrer; // 이전 페이지 URL 가져오기
    if (previousUrl) {
      location.href = previousUrl; // 이전 URL로 이동
    } else {
      history.back();
    }
}


//-----------------------로그인페이지에서 실행영역
const infoText1   		= document.querySelector('#infoText1');
const infoRequired1   = document.querySelector('#infoRequired1');
const checkEmailBtn   = document.querySelector('#checkEmail');
const uiEmail   			= document.querySelector('#uiEmail');
const pwdArea   			= document.querySelector('#pwdArea');
const userEmailLabel  = document.querySelector('#userEmailLabel');
const uiPwd   				= document.querySelector('#uiPwd');
let pwdFlag = false;



function showPwd(){
  if(pwdFlag){
	  uiPwd.type = 'password';
    pwdFlag = false;
  }else{
	  uiPwd.type = 'text';
    pwdFlag = true;
  }
}//비밀번호 보기에 관한 

function checkEmail(){
  console.log('눌렀음');
  let param = {
		  uiEmail : uiEmail.value
  }
  param = JSON.stringify(param);
  const xhr = new XMLHttpRequest();
  xhr.open('POST','/user/checkEmail');
  xhr.setRequestHeader('Content-Type', 'application/json');
  xhr.onreadystatechange = function(){
    if(xhr.readyState === xhr.DONE){
      if(xhr.status === 200){
        if(xhr.responseText==1){
        	toggleEmailPwd(); //로그인 가능 비번치삼.
        }else if(xhr.responseText==2){
          //2이면 다른 아이디 중복검사하자.
					const message = '계정이 삭제된 동일한 이메일이 존재합니다. 해당 계정은 30일 동안 보관되므로, 이 이메일로는 다시 가입할 수 없습니다. 다른 이메일로 시도해 주시기 바랍니다.';
					alert(message);
					document.querySelector('#uiEmail').value = '';
					document.querySelector('#uiEmail').focus();
					
				}else{ //0이면 회원가입하러가삼.
          const email = document.querySelector('#uiEmail').value;
          sessionStorage.setItem('userEmail', email);
        	//no account then create account
        	location.href='/views/user/create-account'
        }
      }
    }
  }
  xhr.send(param);
}

function login(){
	let param = {
      uiEmail : uiEmail.value,
      uiPwd : uiPwd.value
  }
  param = JSON.stringify(param);
  const xhr = new XMLHttpRequest();
  xhr.open('POST','/user');
  xhr.setRequestHeader("Content-Type", "application/json");
  xhr.onreadystatechange = function(){
    if(xhr.readyState === xhr.DONE){
      if(xhr.status === 200){
        if(xhr.responseText!=''){
          const user = JSON.parse(xhr.responseText);
          //로그인 성공하면 페이지 이동합니다.
          redirectToProductPage();
        }else{
          alert("비밀번호가 맞지 않습니다.");
        }
      }
    }
  }
  xhr.send(param);
}
function toggleEmailPwd(flag){
	if(flag!=null){
		uiEmail.value = '';
  }//펑션의 인자값이 있으면 밸류 지워버림. 
	toggleDisabled(uiEmail);
	uiEmail.classList.toggle("shorten-margin");
	uiEmail.classList.toggle("disabled");
	userEmailLabel.classList.toggle("selected");
	infoText1.classList.toggle("d-none");
	checkEmailBtn.classList.toggle("d-none");
	infoRequired1.classList.toggle("d-none");
	pwdArea.classList.toggle("d-none");
}
function toggleDisabled(Obj){
	if(Obj.disabled){
		Obj.disabled = false;
	}else{
		Obj.disabled = true;
	}
}