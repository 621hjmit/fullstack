/**
 * 
 */

window.onload = init;
let userObject = null;
let userObjectFromDB = null;
let aiNum;
let userForMypage = null;
function init(){
  if(!user){
    //세션에 유저 없으면 로긴 페이지로 던진다.
    location.href='/views/user/login';
  }else{
    userObject = Object.fromEntries(
      user.match(/(\w+)=([^,]+)/g).map(pair => pair.split('='))
    );
    aiNum = userObject.uiNum;
    getUserData(userObject.uiNum);
  } 
}
const gender = $('#gender');
const userAddress = $('#userAddress');
gender.change(function(){
  $('#genderLable').addClass('selected');
});
$('#userPassword2').blur(function(){
  const $this = $(this);
  const $pwd = $('#userPassword');
  if(!($this.val() ===$pwd.val())){
    $('#pwdWarning').toggleClass('show');
  }
});

function save(){
  const uiEmail     =   document.querySelector('#uiEmail').value        ;
  const uiCountryCode = document.querySelector('#uiCountryCode').value  ;
  const uiPhone     =   document.querySelector('#uiPhone').value        ;
  const uiPwd       =   document.querySelector('#uiPwd').value          ;
  const uiGender    =   document.querySelector('#uiGender').value       ;
  const uiFirstName =   document.querySelector('#uiFirstName').value    ;
  const uiLastName  =   document.querySelector('#uiLastName').value     ;
  const uiBirth     =   document.querySelector('#uiBirth').value.replaceAll('-','');
  //const uiNews      =   $('#uiNews').prop('checked')==true ? '1' : '0';
  
  
  let   test        =   uiEmail.length>0 && uiPhone.length>0 && uiGender.length>0 &&
                        uiFirstName.length>0 && uiLastName.length>0 && uiBirth.length>0;

  if(test){
    const param = {
      uiEmail     :   uiEmail,
      uiCountryCode:  uiCountryCode,
      uiPhone     :   uiPhone,
      uiPwd       :   uiPwd,
      uiGender    :   uiGender,
      uiFirstName :   uiFirstName,
      uiLastName  :   uiLastName,
      uiBirth     :   uiBirth,
      uiNum       :   userObject.uiNum,
      aiZipcode   :    document.querySelector('#aiZipcode').value  ,
      aiAddress1  :    document.querySelector('#aiAddress1').value ,
      aiAddress2  :    document.querySelector('#aiAddress2').value ,
    }
    
    const changedKeys = Object.keys(param).filter(key => {
      let paramValue = param[key];
      let dbValue = userObjectFromDB[key];
      
      if (key === 'uiPwd' && paramValue === '') {
        return false;
      }
      if (typeof dbValue === 'string' && dbValue.includes('-')) {
        dbValue = dbValue.replace(/-/g, ''); // '1990-01-01' -> '19900101'
      }
      // 강제로 문자열로 변환하여 비교
      return String(paramValue) !== String(dbValue);
    });

    let param1 = changedKeys.reduce((acc, key) => {
        acc[key] = param[key]; // 변경된 키에 대한 값을 param에서 가져와서 param1에 추가
        return acc;
    }, {});
    
    param1['uiNum'] = userObjectFromDB.uiNum;
    param1['uiNews'] = $('#uiNews').prop('checked')==true ? '1' : '0';
    //param1['uiNews'] = userObjectFromDB.uiNews; 
    console.log(param1);
    // param1이 비어있다면 null로 설정
    if (Object.keys(param1).length == 0) {
        param1 = null;
    }
    
    if(param1 == null){
      alert("수정된 내용이 없어서 저장하지 않았습니다.");
      location.href='/views/user/mypage';
    }else{
      sendToDBForSave(param1);
    }
  }
}
function sendToDBForSave(param1){
  axios.put('/user', param1  , {
      headers: {
        'Content-Type': 'application/json'
      }
  })
  .then(res => {
    console.log("res.data: "+res.data);
    if(res.data=='3'){
      alert('회원정보가 수정되었습니다.');
      location.href='/views/user/mypage';
    }else{
      alert('고객정보 수정에 실패하였습니다. 관리자에게 문의 하세요.');
    }
  })
  .catch(error => {
    console.error('There was an error!', error);
  });
}
function getAddress() {
  new daum.Postcode({
    oncomplete: function(data) {
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
  
      // 각 주소의 노출 규칙에 따라 주소를 조합한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      var addr = ''; // 주소 변수
      var extraAddr = ''; // 참고항목 변수
      let type = 'R';
  
      //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
      if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
        addr = data.roadAddress;
      } else { // 사용자가 지번 주소를 선택했을 경우(J)
        addr = data.jibunAddress;
      }
  
      // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
      if(data.userSelectedType === 'R'){
        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
        // 법정동의 경우 마지막 문자가 '동/로/가'로 끝난다.
        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
          extraAddr += data.bname;
        }
        console.log(data.buildingName);
        // 건물명이 있으면 넣는다.
        if(data.buildingName !== ''){
          extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
        }
        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
        if(extraAddr !== ''){
          extraAddr = ' (' + extraAddr + ')';
          addr += extraAddr;
        }
        // 조합된 참고항목을 해당 필드에 넣는다.
      
      }
  
      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.querySelector('#aiZipcode').value = data.zonecode;
      document.querySelector('#aiAddress1').value = addr;
      // 커서를 상세주소 필드로 이동한다.
      document.querySelector('#aiAddress2').value = '';
      document.querySelector('#aiAddress2').focus();
    }
  }).open();
}
function out(){
  const param = {
    uiNum       :   userObject.uiNum
  }
  const cof = {
    method    : 'put',
    url       : '/user2',
    json      : true,
    callback  : function(res){
      if(res==='1'){
        alert('계정이 삭제되었습니다.');
        location.href='/';
      }else{
        alert('계정을 삭제 하지 못하였습니다. 관리자에게 문의해주세요.');
      }
    },
    param   : JSON.stringify(param)
  }
  ajax(cof);
}
function getUserData(number){
  const param = {
    uiNum : number
  }
  const cof = {
    method    : 'post',
    url       : '/user1',
    json      : true,
    callback  : function(res){
      res=JSON.parse(res);
      fillData(res);
      userObjectFromDB = res;
      /*
      for (let key in userObjectFromDB) {
          console.log(key, userObjectFromDB[key]);
      }
      */
    },
    param     : JSON.stringify(param)
  }
  ajax(cof);
}
function fillData(object){
  for (let key in object) {
    // user 객체의 각 key에 해당하는 id를 가진 요소가 있을 경우
    let element = document.getElementById(key); // key에 해당하는 id를 가진 요소를 찾음
    if (element && object[key]) { // 요소가 존재한다면
        element.value = object[key]; // 요소에 값을 넣어줌
    }
  }
  fixData();
}
function fixData(){
  
  const genderSelect = document.querySelector('#uiGender');
  // 조건 확인 후 값 설정
  if (genderSelect.value === '1') {
      genderSelect.value = '1'; // value가 1이면 옵션 value 1을 선택
  }
  const newsletterCheckbox = document.querySelector('#uiNews');
  // 체크박스의 값이 1이면 체크 상태로 설정
  if (newsletterCheckbox.value === '1') {
      newsletterCheckbox.checked = true;
  }
}
