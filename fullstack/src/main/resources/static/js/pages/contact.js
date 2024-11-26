/**
 * 
 */let userObject;
let uiNum;
let $userFirstName=$('#ubFirstName');
let $userLastName=$('#ubLastName');
let $userEmail=$('#ubEmail');
let $userPhone=$('#ubPhone');
let $userTitle=$('#ubTitle');
let regName=/^[a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣]{2,20}$/
let regEmail=/^[a-zA-Z0-9]([-_.]?\w+)*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*\.[a-zA-Z]{2,3}$/g;
let regPhone=/^[0-9]{8,}$/;

document.addEventListener('DOMContentLoaded', function () {
  init();
});

function init(){
  if(user){
    //유저를 오브젝트화 하여 저장함.
    userObject = Object.fromEntries(
      user.match(/(\w+)=([^,]+)/g).map(pair => pair.split('='))
    );
    uiNum = userObject.uiNum;
    getUserData();
  }
}


$userFirstName.on('blur', function(){
    if(!regName.test($userFirstName.val())){
        $userFirstName.popWarning("이름을 입력해 주세요.");
    }
});

$userLastName.on('blur', function(){
    if(!regName.test($userLastName.val())){
        $userLastName.popWarning("성을 입력해 주세요.");
    }
});

$userEmail.on('blur', function(){
    if(!regEmail.test($userEmail.val())){
        $userEmail.popWarning("name@domain.com과 같은 형식의 유효한 이메일을 입력해 주세요.");
    }
});

$userPhone.on('blur', function(){
    if(!regPhone.test($userPhone.val())){
        $userPhone.popWarning('최소 8글자 이상');
    }
});

$userTitle.on('blur', function(){
  if($userTitle.value == '' ){
    $userTitle.popWarning('제목을 입력해 주세요.');
  }
});

// $userPhone최소 8글자 이상.

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

$('.required-select').on( "focusout", function(){
    $(this).warningRequired();
});

$('.required-textarea').on( "focusout", function(){
    $(this).warningRequired();
});

$('#ubCountryCode').on('keydown',function(e){
    var value = $(this).val();
    if(value =='+'&&e.keyCode == 8){
        e.preventDefault(); //국가코드 못지우게
    }
});

$('#csSubject').change(function () {
    var $this = $(this);
    if ($this.val() != '0') {
        $('.generic-select + label').addClass('selected');
    }
});

$('#ubMessage').on('focus',function(e){
    console.log($(this).next().length);
    $('.generic-textarea + label').addClass('selected');
});

$('#ubMessage').on('focusout',function(e){
    if ($(this).val()=='') {
        $('.generic-textarea + label').removeClass('selected');
    }
});

function getUserData(){
  const param = {
    uiNum : uiNum
  }
  const cof = {
    method    : 'post',
    url       : '/user1',
    json      : true,
    callback  : function(res){
      res=JSON.parse(res);
      fillData(res);
    },
    param     : JSON.stringify(param)
  }
  ajax(cof);  
}

function fillData(user){
  for (let key in user) {
    //console.log(key+' '+user[key]);
    // user 객체의 각 key에 해당하는 id를 가진 요소가 있을 경우
    let element = document.getElementById(key); // key에 해당하는 id를 가진 요소를 찾음
    if (element) { // 요소가 존재한다면
      element.value = user[key]; // 요소에 값을 넣어줌
      element.disabled = true;
      element.classList.add("disabled");
    }
  }
}
function save(){
  const uiLastName    = document.querySelector('#uiLastName').value   ;
  const uiFirstName   = document.querySelector('#uiFirstName').value  ;
  const uiEmail       = document.querySelector('#uiEmail').value      ;
  const uiCountryCode = document.querySelector('#uiCountryCode').value;
  const uiPhone       = document.querySelector('#uiPhone').value      ;
  const ubMessage   = document.querySelector('#ubMessage').value  ;
  const ubTitle   = document.querySelector('#ubTitle').value  ;
  
  // 셀렉트박스 접근
  const selectBox = document.querySelector("#csSubject");
  // 선택된 옵션 접근
  const csSubject = selectBox.options[selectBox.selectedIndex].value;
  
  check(uiLastName,50);
  check(uiFirstName,50);
  check(uiEmail,255);
  check(uiCountryCode,5);
  check(uiPhone,50);
  check(csSubject,255);
  check(ubMessage,1000);
  
  const param1 = {
    ubLastName    :uiLastName,
    ubFirstName   :uiFirstName,
    ubEmail       :uiEmail,
    ubCountryCode :uiCountryCode,
    ubPhone       :uiPhone,
    ucNum         :csSubject,
    ubMessage     :ubMessage,
    ubTitle       :ubTitle,
    uiNum         :uiNum
  }
  sendToDBForSave(param1);
}
function check(object, num){
  if(object==''){
    alert("입력란에 내용을 넣어주세요.");
    object.focus();
    return;
  }else if(object.length >= num){
    alert("내용의 길이가 너무 깁니다.");
    object.focus();
    return;
  }
}

function sendToDBForSave(param1){
  axios.post('/contact', param1  , {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(res => {
    console.log("res.data: "+res.data);
    if(res.data=='1'){
      alert('문의하신 내용은 확인후 해당 휴대폰 번호와 이메일로 답문을 드리겠습니다. 회원은 마이페이지에서 열람 가능합니다.');
      location.href='/views/pages/contact';
    }else{
      alert('1:1 문의에 실패하였습니다. 관리자에게 문의 하세요.');
    }
  })
  .catch(error => {
    console.error('There was an error!', error);
  });
}