/**
 * newsletter.js
 */

//-----------------------로그인페이지에서 실행영역
const unEmail = document.querySelector('#unEmail');
const emailArea = document.querySelector('#emailArea');
const thankyouForSubscribe = document.querySelector('#thankyouForSubscribe');
let $userEmail=$('#unEmail');
let regEmail=/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

document.getElementById('checkEmailBtn').addEventListener('click', checkEmailValidation);

document.addEventListener('DOMContentLoaded', function () {
  init();
});

function init(){
  setLogin();
}

function setLogin(){
  axios.get('/api/user')
  .then(response => {
    const data = response.data;
    if (data && Object.keys(data).length > 0) { // data 유효성 검사
      location.href = "/views/user/mypage-edit";
    } else {
      console.log('No user data found.');
    }
  })
  .catch(error => {
    if (error.response) {
      // 서버 응답이 있는 경우 (HTTP 에러 상태)
      console.error(`Error: ${error.response.status} - ${error.response.statusText}`);
    } else if (error.request) {
      // 요청이 전송되었으나 응답을 받지 못한 경우
      console.error('No response received:', error.request);
    } else {
      // 요청을 설정하는 도중 발생한 에러
      console.error('Error setting up request:', error.message);
    }
    console.log('아직 로그인되지 않았습니다.');
  });
}

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

function checkEmail(){
  let param = {
      unEmail : unEmail.value
  }
  param = JSON.stringify(param);
  const xhr = new XMLHttpRequest();
  xhr.open('POST','/newsletter2');
  xhr.setRequestHeader('Content-Type', 'application/json');
  xhr.onreadystatechange = function(){
    if(xhr.readyState === xhr.DONE){
      if(xhr.status === 200){
        if(xhr.responseText>0){
          alert("사용 중인 이메일입니다. 해당 이메일로 곧 뉴스레터를 보내드릴 예정입니다.");
        }else{
          insertNewletter();
        }
      }
    }
  }
  xhr.send(param);
}

function insertNewletter(){
  const param = {
    unEmail: unEmail.value
  };

  // Axios로 PUT 요청 보내기
  axios.post('/newsletter3', param, {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(response => {
    if(response.data>0){
      emailArea.classList.add("d-none");
      thankyouForSubscribe.classList.remove("d-none");
    }
  })
  .catch(error => {
    console.error('Error fetching statistics:', error);
  });
}

function goBack(){
  const previousUrl = document.referrer; // 이전 페이지 URL 가져오기
  if (previousUrl) {
    location.href = previousUrl; // 이전 URL로 이동
  } else {
    history.back();
  }
}