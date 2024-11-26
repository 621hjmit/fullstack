/**
 * createAccount 
 */
window.onload = init;
function init(){
  const email = sessionStorage.getItem('userEmail');
  if (email) {
      document.querySelector('#userEmail').value = email; // 이메일 입력 필드에 채우기
  }else{
    location.href="/views/user/login";
  }
}
let result2 = false;
// "모두 동의합니다" 체크박스 클릭 시
$('#agreeAll').on('change', function() {
  const isChecked = $(this).is(':checked');
  $('#agree1, #agree2, #agree3').prop('checked', isChecked); // 다른 체크박스 동기화
  result2 = isChecked; // result2에 체크 상태 저장
});
// 개별 체크박스가 변경될 때 "모두 동의합니다" 체크박스 상태 업데이트
$('#agree1, #agree2, #agree3').on('change', function() {
  const allChecked = $('#agree1').is(':checked') && $('#agree2').is(':checked') && $('#agree3').is(':checked');
  $('#agreeAll').prop('checked', allChecked); // 모두 체크 시에만 "모두 동의" 체크
  result2 = allChecked; // result2에 체크 상태 저장
});

const gender = $('#gender');
const userAddress = $('#userAddress');
gender.change(function(){
  $('#genderLable').addClass('selected');
});
userAddress.focus(function(){
  $('#userAddressLabel').addClass('selected');
});
userAddress.blur(function(){
  if(userAddress.val().length > 0){
    $('#userAddressLabel').addClass('selected');
  }else{
    $('#userAddressLabel').removeClass('selected');
  }
});
$('#userPassword2').blur(function(){
  const $this = $(this);
  const $pwd = $('#userPassword');
  if(!($this.val() ===$pwd.val())){
    $('#pwdWarning').toggleClass('show');
  }
})
$('#userPhone').on('focus', function(event){
  $('#phoneInfo').removeClass('hide');
});

$('#userEmail').blur(function(event){
  const email = $(this).val();
  const emailCheck = RegExp('^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
  if(emailCheck.test(email) == false && email.length>0) {
    $('#userEmail').focus();
  }else{
    $('#emailInfo').addClass('hide');
  }
});
$('#userEmail').on('focus',function(event){
  $('#emailInfo').removeClass('hide');
});
$('#userPhone').blur(function(event){
  const $this = $(this);
  let str = $this.val();
  if(str.indexOf(0)=='0'){
    str = str.substring(1);
    $this.val(str);
  }
  $('#phoneInfo').addClass('hide');
});
/*
$('#userPhone').on( "keydown", function( event ) {
  const $this = $(this);
  let str = $this.val();
  if ( event.which == 96 && str.length < 1 ) {
    event.preventDefault();
  }
});
*/
$('#userPhone').on('input', function() {
    // 현재 입력값을 가져옴
    let value = $(this).val();

    // 첫 글자가 0인 경우 제거
    if (value.startsWith('0')) {
        value = value.slice(1);
    }

    // '-' 문자를 제거
    value = value.replace(/-/g, '');

    // 수정된 값을 다시 설정
    $(this).val(value);
});
$('#uiCountryCode').on('input', function() {
  // 기본값이거나 첫 번째 글자가 +인지 확인
  if (!this.value.startsWith('+')) {
    this.value = '+' + this.value.replace(/[^0-9]/g, ''); // + 기호가 없으면 추가
  } else {
    // 숫자만 입력되도록 + 뒤의 문자 중 숫자가 아닌 것은 제거
    this.value = '+' + this.value.slice(1).replace(/[^0-9]/g, '');
  }
});
function checkCheckbox(){
  if(!result2){
    $('#agreeAll').on("focus");
    alert("필수 동의 항목에 모두 동의하셔야 회원가입이 완료됩니다. 뉴스레터 동의는 선택 사항입니다.");
  }else{
    join();
  }
}
function join(){
  
  const uiEmail     =   document.querySelector('#userEmail').value    ;
  const uiCountryCode=  document.querySelector('#uiCountryCode').value;
  const uiPhone     =   document.querySelector('#userPhone').value    ;
  const uiPwd       =   document.querySelector('#userPassword').value ;
  const uiGender    =   document.querySelector('#gender').value       ;
  const uiFirstName =   document.querySelector('#userFirstName').value;
  const uiLastName  =   document.querySelector('#userLastName').value ;
  const uiBirth     =   document.querySelector('#userBirth').value.replaceAll('-','');
  let   uiNews      =   document.querySelector('#news')               ;
  const aiZipcode   =   document.querySelector('#aiZipcode').value    ;
  const aiAddress1  =   document.querySelector('#aiAddress1').value   ;
  const aiAddress2  =   document.querySelector('#aiAddress2').value   ;
  
  let   test        =   uiEmail.length>0 && uiCountryCode>0 &&
                        uiPhone.length>0 && uiGender.length>0 &&
                        uiPwd.length>0 && uiFirstName.length>0 &&
                        uiLastName.length>0 && uiBirth.length>0 &&
                        aiZipcode.length>0 && aiAddress1.length>0 &&
                        aiAddress2.length>0;
                        
  if (!uiNews.checked) {
      uiNews = '0';  // 체크가 안 되면 'unsubscribed' 값 설정
  } else {
      uiNews = '1';  // 체크되면 'subscribed' 값 설정 (예시로 설정)
  }
                                               
  if(test){
    const param = {
      uiFirstName  :   uiFirstName,
      uiLastName   :   uiLastName,
      uiEmail      :   uiEmail,
      uiCountryCode:   uiCountryCode,
      uiPhone      :   uiPhone,
      uiPwd        :   uiPwd,
      uiGender     :   uiGender,
      uiBirth      :   uiBirth,
      uiNews       :   uiNews
    }
    const param2 = {
      aiPlaceName     :    uiLastName + uiFirstName  ,
      aiRecipentName  :    uiLastName + uiFirstName  ,
      aiCountryCode   :    uiCountryCode             ,
      aiPhone         :    uiPhone                   ,
      aiZipcode       :    document.querySelector('#aiZipcode').value  ,
      aiAddress1      :    document.querySelector('#aiAddress1').value ,
      aiAddress2      :    document.querySelector('#aiAddress2').value
    }
    const param3 = {
      unEmail           : uiEmail    ,
      unStatus          : uiNews     ,
      unLastName        : uiLastName ,
      unFirstName       : uiFirstName
    }
    const combinedParam = {
          user: param,
          address: param2,
          newsletter: param3
    };
      
    axios.post('/join', combinedParam, {
      headers: {
        'Content-Type': 'application/json'
      }
    }) // API URL을 실제 엔드포인트로 변경
    .then(res => {
      if(res.data=='3'){
        alert("회원가입에 성공하였습니다. 로그인해주세요.");
        sessionStorage.removeItem('userEmail'); // 사용 후 세션에서 삭제
        location.href ='/views/user/welcome';
      }else{
        alert("회원가입에 실패하였습니다. 다시 입력해주세요.");
        location.href ='/';
      }
    })
    .catch(error => {
      console.error('Error fetching statistics:', error);
    });
  }else{
    alert('필수항목에 정보를 입력해주세요.');
  }
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
        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
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
      document.querySelector("#aiAddress1").value = addr;
      // 커서를 상세주소 필드로 이동한다.
      document.querySelector("#aiAddress2").value = '';
      document.querySelector("#aiAddress2").focus();
    }
  }).open();
}
function getFormattedDate() {
  var today = new Date();  // 오늘 날짜
  var year = today.getFullYear();  // 년도
  var month = today.getMonth() + 1;  // 월 (0부터 시작하므로 1을 더함)
  var day = today.getDate();  // 일

  // 월과 일이 10보다 작은 경우 앞에 0을 추가하여 두 자리로 만듦
  month = month < 10 ? '0' + month : month;
  day = day < 10 ? '0' + day : day;

  // 'yyyyMMdd' 형식으로 날짜를 반환
  return (year + month + day);
}